class AddReviewBody {
  String id;
  String name;
  String review;

  AddReviewBody({
    required this.id,
    required this.name,
    required this.review,
  });

  factory AddReviewBody.fromJson(Map<String, dynamic> json) => AddReviewBody(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}
