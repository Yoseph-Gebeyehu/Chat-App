// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final bool obscureText;
//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.obscureText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey.shade200),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.white),
//         ),
//         fillColor: Colors.grey[400],
//         filled: true,
//         hintText: hintText,
//         hintStyle: const TextStyle(
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
          ),
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
