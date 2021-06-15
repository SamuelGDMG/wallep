import 'package:flutter/material.dart';

class ScrollHorizontalCards extends StatelessWidget {

  final labelCarousel;
  final Widget? widget;

  const ScrollHorizontalCards({this.labelCarousel = "", this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(labelCarousel, style: TextStyle(
              fontSize: 24
          ),
            textAlign: TextAlign.start,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: widget,
        ),
      ],
    );
  }

}
