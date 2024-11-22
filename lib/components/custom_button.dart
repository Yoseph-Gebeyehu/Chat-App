// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final void Function()? onTap;
//   final String text;
//   const CustomButton({super.key, required this.onTap, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(9),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const CustomButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      // padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      height: 50,
      decoration: BoxDecoration(
        // color: Colors.transparent,
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 0.2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              // color: const Color.fromARGB(255, 164, 98, 17),
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: deviceSize.width * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}
