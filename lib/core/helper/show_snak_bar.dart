import 'package:flutter/material.dart';

/*
 * showSnakBar function
 * displays a custom styled SnackBar with a given message in the provided context
 */
void showSnakBar(BuildContext context, String message, {bool isError = false}) {
  final color = isError ? Colors.redAccent : Colors.green;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.favorite,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
      elevation: 6,
    ),
  );
}
