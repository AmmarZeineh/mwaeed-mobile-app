class UserEntity {
  final String accessToken;
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String city;

  UserEntity({
    required this.accessToken,
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.city,
  });

  toJson() => {
    'accessToken': accessToken,
    'id': id,
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'city': city,
  };

  UserEntity.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        id = json['id'],
        name = json['name'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        city = json['city'];

  UserEntity copyWith({
    String? accessToken,
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? city,
  }) {
    return UserEntity(
      accessToken: accessToken ?? this.accessToken,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
    );
  }
}
