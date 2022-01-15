import 'package:flutter/material.dart';

class ProfileController extends StatelessWidget {
  final String username;
  const ProfileController({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Welcome ${username}"),
    );
  }
}
