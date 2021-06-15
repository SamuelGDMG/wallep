import 'package:flutter/material.dart';

class OnTapCard extends StatelessWidget {

  final borderRadius = 16.0;

  final onTap;

  const OnTapCard({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Material(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: onTap,
            child: Container(
              width: 60,
              height: 60,
              child: Icon(Icons.add),
            ),
          ),
        )
    );
  }
}
