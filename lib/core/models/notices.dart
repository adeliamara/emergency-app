import 'package:emergency_app/core/models/user.dart';

class Notice {
  String id;
  User sentBy;
  double latitude;
  double longitude;
  Notice({
    required this.id,
    required this.sentBy,
    required this.latitude,
    required this.longitude,
  });

  Notice copyWith({
    String? id,
    User? sentBy,
    double? latitude,
    double? longitude,
    DateTime? sentDate,
    List<User>? recipitents,
  }) {
    return Notice(
      id: id ?? this.id,
      sentBy: sentBy ?? this.sentBy,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': sentBy.id,
      'lat': latitude,
      'long': longitude,
    };
  }

  factory Notice.fromMap(Map<String, dynamic> map) {
    return Notice(
      id: map['id'] as String,
      sentBy: User.fromMap(map['user_id'] as Map<String, dynamic>),
      latitude: map['lat'] as double,
      longitude: map['long'] as double,
    );
  }

  @override
  String toString() {
    return 'Notice(id: $id, sentBy: $sentBy, latitude: $latitude, longitude: $longitude)';
  }
}
