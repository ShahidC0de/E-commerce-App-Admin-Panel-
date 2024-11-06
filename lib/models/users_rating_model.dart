class UsersRatingModel {
  final String name;

  final int rating;
  final String comment;
  final String userId;
  UsersRatingModel({
    required this.name,
    required this.rating,
    required this.comment,
    required this.userId,
  });
  factory UsersRatingModel.fromMap(
    Map<String, dynamic> data,
  ) {
    return UsersRatingModel(
      name: data['name'],
      rating: data['rating'],
      comment: data['comment'],
      userId: data['userId'],
    );
  }
}
