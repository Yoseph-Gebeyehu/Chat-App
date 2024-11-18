import 'package:flutter/material.dart';

class SquareTitle extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTitle({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
