import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techtrove_admin/helpers/firebase_firestore.dart';
import 'package:techtrove_admin/models/users_rating_model.dart';

class UsersRatingPage extends StatefulWidget {
  const UsersRatingPage({super.key});

  @override
  State<UsersRatingPage> createState() => _UsersRatingPageState();
}

class _UsersRatingPageState extends State<UsersRatingPage> {
  bool isLoading = true;
  List<UsersRatingModel> usersRatings = [];

  void getData() async {
    final fetchedRating =
        await FirebaseFirestoreHelper.instance.getUsersRating();
    setState(() {
      usersRatings = fetchedRating;
    });
  }

  @override
  void initState() {
    getData();

    isLoading = false;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Rating',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: usersRatings.length,
                itemBuilder: (context, index) {
                  UsersRatingModel userRating = usersRatings[index];
                  return RatingContainer(
                    name: userRating.name,
                    stars: userRating.rating,
                    comment: userRating.comment,
                  );
                }));
  }
}

class RatingContainer extends StatelessWidget {
  final String name;
  final int stars;
  final String comment;
  const RatingContainer({
    super.key,
    required this.name,
    required this.stars,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.03,
        horizontal: width * 0.05,
      ),
      child: Container(
        width: width * 0.8,
        height: height * 0.25,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Name:   $name",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: List.generate(stars, (index) {
                  return const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  );
                }),
              ),
              Text(
                "Comment:   $comment",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
