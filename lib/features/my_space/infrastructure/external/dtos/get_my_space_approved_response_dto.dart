class GetMySpaceApprovedResponseDto {
  final String id;
  final String name;
  final String url;
  final DateTime createdTime;
  final bool isApproved;

  GetMySpaceApprovedResponseDto({
    required this.id,
    required this.name,
    required this.url,
    required this.createdTime,
    required this.isApproved,
  });

  factory GetMySpaceApprovedResponseDto.fromJson(Map<String, dynamic> json) =>
      GetMySpaceApprovedResponseDto(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        createdTime: DateTime.parse(json["created_time"]),
        isApproved: json["is_approved"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "created_time": createdTime.toIso8601String(),
        "is_approved": isApproved,
      };
}
