// import 'package:flutter/material.dart';
//
// class AppButton extends StatelessWidget {
//   const AppButton(
//     this.label, {
//     super.key,
//     required this.onTap,
//     this.icon,
//   });
//
//   final IconData? icon;
//   final String label;
//   final void Function() onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//         icon: Icon(icon),
//         label: Text(label),
//         onPressed: onTap,
//         style: OutlinedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(
//             vertical: 10,
//             horizontal: 40,
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';

Color appColor = Colors.blue[500] ?? Colors.blue; // Fallback if null

class AppButton extends StatelessWidget {
  const AppButton(
      this.label, {
        super.key,
        required this.onTap,
        this.icon,
      });

  final IconData? icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor, // Button background color
        padding: const EdgeInsets.symmetric(
          vertical: 15, // Adjust vertical padding
          horizontal: 30, // Adjust horizontal padding
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        elevation: 5, // Add a shadow effect
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Make the button fit its content
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white), // Add the icon (optional)
            const SizedBox(width: 10), // Space between icon and label
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color
            ),
          ),
        ],
      ),
    );
  }
}

