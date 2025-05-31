import 'package:flutter/material.dart';
import 'package:office_buddy/src/data/model/calendar/event_model.dart';
import 'package:office_buddy/src/data/repositories/calendar_repositories.dart';
import 'package:office_buddy/src/presentation/calendar/add_event.dart';
import 'package:office_buddy/src/presentation/calendar/event_detail_screen.dart';
import 'package:office_buddy/src/presentation/calendar/event_list_item.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarService _calendarService = CalendarService();
  List<CustomEvent> allEvents = [];
  List<CustomEvent> displayedEvents = [];
  DateTime? selectedDate;
  CalendarController calendarController = CalendarController();
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final events = await _calendarService.getEvents();
      setState(() {
        allEvents = events;
        // Sort events by date
        allEvents.sort((a, b) => a.date.compareTo(b.date));
        displayedEvents = List.from(allEvents);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _addEvent(CustomEvent event) async {
    try {
      final newEvent = await _calendarService.addEvent(event);
      setState(() {
        allEvents.add(newEvent);
        _updateDisplayedEvents();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add event: ${e.toString()}')),
      );
    }
  }

  void _updateDisplayedEvents() {
    setState(() {
      if (selectedDate != null) {
        displayedEvents = _getEventsForDate(selectedDate!);
      } else {
        displayedEvents = List.from(allEvents);
      }
      // Sort events by date
      displayedEvents.sort((a, b) => a.date.compareTo(b.date));
    });
  }

  List<Appointment> _getAppointments() {
    return allEvents.map((event) {
      return Appointment(
        startTime: event.date,
        endTime: event.date.add(const Duration(hours: 1)),
        subject: event.title,
        color: event.color,
        notes: event.description,
      );
    }).toList();
  }

  List<CustomEvent> _getEventsForDate(DateTime date) {
    return allEvents
        .where((event) =>
            event.date.year == date.year &&
            event.date.month == date.month &&
            event.date.day == date.day)
        .toList();
  }

  void _showEventDetails(CustomEvent event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => EventDetailSheet(
        event: event,
        onNavigateToDate: () => _navigateToDate(event.date),
      ),
    );
  }

  void _navigateToDate(DateTime date) {
    calendarController.displayDate = date;
    setState(() {
      selectedDate = date;
      _updateDisplayedEvents();
    });
  }

  void _addNewEvent() {
    showDialog(
      context: context,
      builder: (context) => AddEventDialog(
        onEventAdded: (CustomEvent newEvent) async {
          await _addEvent(newEvent);
        },
      ),
    );
  }

  Widget _buildEventsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header showing All Events or Selected Date
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDate == null ? 'All Events' : 'Events for ${_formatDate(selectedDate!)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (selectedDate != null)
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = null;
                      _updateDisplayedEvents();
                    });
                  },
                  child: const Text('Show All'),
                ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: displayedEvents.isEmpty
              ? Center(
                  child: Text(
                    selectedDate == null
                        ? 'No events found'
                        : 'No events for selected date',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: displayedEvents.length,
                  itemBuilder: (context, index) {
                    final event = displayedEvents[index];
                    return EventListItem(
                      event: event,
                      onTap: () => _showEventDetails(event),
                    );
                  },
                ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $error'),
            ElevatedButton(
              onPressed: _loadEvents,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Calendar'),
        backgroundColor:Color(0xfff1e40af),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: SfCalendar(
              view: CalendarView.month,
              controller: calendarController,
              dataSource: AppointmentDataSource(_getAppointments()),
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                showAgenda: false,
              ),
              onTap: (CalendarTapDetails details) {
                if (details.targetElement == CalendarElement.calendarCell &&
                    details.date != null) {
                  setState(() {
                    selectedDate = details.date!;
                    _updateDisplayedEvents();
                  });
                } else if (details.targetElement == CalendarElement.appointment) {
                  final appointment = details.appointments?.first;
                  if (appointment != null) {
                    final event = allEvents.firstWhere(
                      (e) =>
                          e.title == appointment.subject &&
                          e.date == appointment.startTime,
                    );
                    _showEventDetails(event);
                  }
                }
              },
            ),
          ),
          Expanded(
            child: _buildEventsList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewEvent,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
} 