  import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  String title;
  IconData icon;
  final VoidCallback? press;



  EditButton(
    this.title,
    this.icon,
    this.press
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        IconButton(onPressed: press, icon: Icon(icon , color: Colors.black,))
      ],
    );
  }
}