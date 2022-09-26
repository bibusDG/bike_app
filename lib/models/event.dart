// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:bike_app/models/users.dart';

class Events {
  String id;
  String eventName;
  String eventDate;
  String startEvent;
  String stopEvent;
  int estimatedTime;
  String eventType;
  String eventPlace;
  Map<String, dynamic> users;
  Events({
    required this.id,
    required this.eventName,
    required this.eventDate,
    required this.startEvent,
    required this.stopEvent,
    required this.estimatedTime,
    required this.eventType,
    required this.eventPlace,
    required this.users,
  });

  Events copyWith({
    String? id,
    String? eventName,
    String? eventDate,
    String? startEvent,
    String? stopEvent,
    int? estimatedTime,
    String? eventType,
    String? eventPlace,
    Map<String, dynamic>? users,
  }) {
    return Events(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      startEvent: startEvent ?? this.startEvent,
      stopEvent: stopEvent ?? this.stopEvent,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      eventType: eventType ?? this.eventType,
      eventPlace: eventPlace ?? this.eventPlace,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'eventName': eventName,
      'eventDate': eventDate,
      'startEvent': startEvent,
      'stopEvent': stopEvent,
      'estimatedTime': estimatedTime,
      'eventType': eventType,
      'eventPlace': eventPlace,
      'users': users,
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      id: map['id'] as String,
      eventName: map['eventName'] as String,
      eventDate: map['eventDate'] as String,
      startEvent: map['startEvent'] as String,
      stopEvent: map['stopEvent'] as String,
      estimatedTime: map['estimatedTime'] as int,
      eventType: map['eventType'] as String,
      eventPlace: map['eventPlace'] as String,
      users: Map<String, dynamic>.from(map['users'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Events.fromJson(String source) =>
      Events.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Events(id: $id, eventName: $eventName, eventDate: $eventDate, startEvent: $startEvent, stopEvent: $stopEvent, estimatedTime: $estimatedTime, eventType: $eventType, eventPlace: $eventPlace, users: $users)';
  }

  @override
  bool operator ==(covariant Events other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.eventName == eventName &&
        other.eventDate == eventDate &&
        other.startEvent == startEvent &&
        other.stopEvent == stopEvent &&
        other.estimatedTime == estimatedTime &&
        other.eventType == eventType &&
        other.eventPlace == eventPlace &&
        mapEquals(other.users, users);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        eventName.hashCode ^
        eventDate.hashCode ^
        startEvent.hashCode ^
        stopEvent.hashCode ^
        estimatedTime.hashCode ^
        eventType.hashCode ^
        eventPlace.hashCode ^
        users.hashCode;
  }
}
