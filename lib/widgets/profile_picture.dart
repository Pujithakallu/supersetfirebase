import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double radius;

  const ProfilePicture({Key? key, this.radius = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage('assets/images/profile_pic.png'),
    );
  }
}
