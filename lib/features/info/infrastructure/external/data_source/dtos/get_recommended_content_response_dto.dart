class GetRecommendedContentResponseDto {
  final String id;
  final String title;
  final String description;
  final String url;

  GetRecommendedContentResponseDto({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
  });

  factory GetRecommendedContentResponseDto.fromJson(
          Map<String, dynamic> json) =>
      GetRecommendedContentResponseDto(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
      };
}
