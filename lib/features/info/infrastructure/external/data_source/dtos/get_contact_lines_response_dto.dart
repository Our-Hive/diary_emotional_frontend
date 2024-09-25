class GetContactLinesResponseDto {
  final String id;
  final String name;
  final String description;

  GetContactLinesResponseDto({
    required this.id,
    required this.name,
    required this.description,
  });

  factory GetContactLinesResponseDto.fromJson(Map<String, dynamic> json) =>
      GetContactLinesResponseDto(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
