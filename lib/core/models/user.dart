import 'package:emergency_app/core/models/notices.dart';

class User {
  String id;
  String name;
  String email;
  String phone;
  String address;
  List<String>? contacts;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.contacts,
  });

  User copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    String? phone,
    String? address,
    List<Notice>? sentNotices,
    List<String>? contacts,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      contacts: contacts ?? this.contacts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phonenumber': phone,
      'address': address,
      'contacts': contacts,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phonenumber'] as String,
      address: map['address'] as String,
      contacts: (map['contacts'] as List<dynamic>)
          .map((contact) => contact as String)
          .toList(),
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email contacts: $contacts';
  }
}
