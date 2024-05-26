class UserApiResponseDto {
  final int id;
  final String role;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final DateTime birthDate;

  UserApiResponseDto({
    required this.id,
    required this.role,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.birthDate,
  });

  factory UserApiResponseDto.fromJson(Map<String, dynamic> json) =>
      UserApiResponseDto(
        id: json["id"],
        role: json["role"],
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        birthDate: DateTime.parse(json["birthDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobileNumber": mobileNumber,
        "birthDate":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
      };
}
