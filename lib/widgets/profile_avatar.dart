import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  const ProfileAvatar({super.key, this.radius = 32});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage: const AssetImage('assets/images/profile.jpg'),
      onForegroundImageError: (_, __) {},
      child: Icon(Icons.person, size: radius),
    );
  }
}