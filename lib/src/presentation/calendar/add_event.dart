import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:office_buddy/src/data/model/calendar/event_model.dart';

class AddEventDialog extends StatefulWidget {
  final Function(CustomEvent) onEventAdded;

  const AddEventDialog({super.key, required this.onEventAdded});

  @override
  _AddEventDialogState createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late DateTime _date;
  late String _type;
  String? _description;
  String? _location;

  @override
  void initState() {
    super.initState();
    _title = '';
    _date = DateTime.now();
    _type = 'birthday';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Event'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Event Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _type,
                decoration: const InputDecoration(labelText: 'Event Type'),
                items: const [
                  DropdownMenuItem(value: 'birthday', child: Text('Birthday')),
                  DropdownMenuItem(value: 'holiday', child: Text('Holiday')),
                  DropdownMenuItem(
                    value: 'anniversary',
                    child: Text('Anniversary'),
                  ),
                ],
                onChanged: (value) => setState(() => _type = value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                onSaved: (value) => _location = value,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Event Date'),
                subtitle: Text(DateFormat('dd MMM yyyy').format(_date)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => _date = picked);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onEventAdded(
                CustomEvent(
                  title: _title,
                  date: _date,
                  type: _type,
                  description: _description,
                  location: _location,
                ),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add Event'),
        ),
      ],
    );
  }
} 