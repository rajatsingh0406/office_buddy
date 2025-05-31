
import 'package:dio/dio.dart';
import 'package:office_buddy/src/core/api/api_provider.dart';
import 'package:office_buddy/src/core/api/app_constant.dart';
import 'package:office_buddy/src/data/model/calendar/event_model.dart';

class CalendarService {
  final Dio _dio = ApiProvider.getDio();
  final String baseUrl = AppConstant.dynamicBaseUrl;
  Future<List<CustomEvent>> getEvents() async {
    try {
      final response = await _dio.get(AppConstant.calendar);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CustomEvent.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Error fetching events: $e');
    }
  }
  Future<CustomEvent> addEvent(CustomEvent event) async {
    try {
      final response = await _dio.post(
        AppConstant.calendar,
        data: event.toJson(),
      );
      if (response.statusCode == 201) {
        return CustomEvent.fromJson(response.data);
      } else {
        throw Exception('Failed to add event');
      }
    } catch (e) {
      throw Exception('Error adding event: $e');
    }
  }
  Future<void> updateEvent(CustomEvent event) async {
    try {
      final response = await _dio.put(
        '${AppConstant.calendar}${event.id}/',
        data: event.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update event');
      }
    } catch (e) {
      throw Exception('Error updating event: $e');
    }
  }
  Future<void> deleteEvent(String eventId) async {
    try {
      final response = await _dio.delete(
        '${AppConstant.calendar}$eventId/',
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete event');
      }
    } catch (e) {
      throw Exception('Error deleting event: $e');
    }
  }
}