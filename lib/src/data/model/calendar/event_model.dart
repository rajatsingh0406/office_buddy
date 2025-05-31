import 'package:flutter/material.dart';
import 'dart:convert';
class CustomEvent {
  final String? id;
  final String title;
  final DateTime date;
  final String type;
  final String? description;
  final String? location;
  final String? images;
  CustomEvent({
    this.id,
    required this.title,
    required this.date,
    required this.type,
    this.description,
    this.location,
    this.images,
  });
  Color get color {
    switch (type) {
      case 'birthday':
        return Colors.red;
      case 'holiday':
        return Colors.blue;
      case 'anniversary':
        return Colors.yellow;
      default:
        return Colors.green; // Default color for other events
    }
  }
  factory CustomEvent.fromJson(Map<String, dynamic> json) {
    String? rawDescription = json['description'];
    String? cleanDescription;
    if (rawDescription != null) {
      try {
        // First try to parse as Delta format
        Map<String, dynamic> deltaJson = jsonDecode(rawDescription);
        if (deltaJson.containsKey('ops')) {
          List<dynamic> ops = deltaJson['ops'];
          cleanDescription = ops.map((op) => op['insert']).join('').trim();
        }
      } catch (e) {
        // If not Delta format, use as is (might be HTML)
        cleanDescription = rawDescription;
      }
    }
    return CustomEvent(
      id: json['id']?.toString(),
      title: json['title'] as String,
      date: DateTime.parse(json['event_date'] as String),
      type: 'default',
      description: cleanDescription,
      images: json['images'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'event_date': date.toIso8601String().split('T')[0],
      'description': description,
      'images': images,
    };
  }
}