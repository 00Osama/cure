import 'package:flutter/material.dart';

class BookingStep extends StatelessWidget {
  const BookingStep({
    super.key,
    required this.stepNumber,
    required this.stepText,
  });

  final String stepNumber;
  final String stepText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  stepNumber,
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
            ),
            Text('  '),
            Text(stepText, style: TextStyle(fontSize: 18)),
          ],
        ),
        if (stepNumber == '1') SizedBox(height: 15),
      ],
    );
  }
}
