import 'package:flutter/material.dart';
import 'package:marketly/config/constants.dart';

class EmptyState extends StatelessWidget {
  final String actionText;
  final Function actionCommand;

  const EmptyState({
    Key key,
    this.actionText,
    this.actionCommand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                actionText,
                textAlign: TextAlign.center,
                style:  TextStyle(
                  fontSize: 16,
                  color: kTextColor,
                ),
              ),
              GestureDetector(
                onTap: actionCommand,
                child: Icon(
                  Icons.add_circle_rounded,
                  size: 80.0,
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
