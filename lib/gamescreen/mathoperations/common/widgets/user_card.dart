import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final int score;

  const UserCard({
    Key? key,
    required this.username,
    required this.avatarUrl,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Spacer(flex: 1),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 5,
            ),
          ),
          child: CircleAvatar(
            backgroundImage: AssetImage(avatarUrl),
            radius: screenWidth/80,
          ),
        ),
        SizedBox(width: screenWidth/80),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: TextStyle(
                fontSize: screenWidth/40,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            SizedBox(width: screenWidth/2),
            Text(
              'Score: $score',
              style: TextStyle(
                fontSize: screenWidth/40,
                color: Colors.white54,
              ),
            ),
          ],
        ),
        Spacer(flex: 1),],
    );
  }
}
