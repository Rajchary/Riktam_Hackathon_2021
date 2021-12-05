import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String message;
  final Color color;
  // ignore: use_key_in_widget_constructors
  const ProgressDialog({required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(
                width: 6.0,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
              const SizedBox(
                width: 26.0,
              ),
              Text(
                message,
                style: TextStyle(color: color, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
