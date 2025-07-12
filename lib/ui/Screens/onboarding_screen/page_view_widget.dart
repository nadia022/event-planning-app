import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageViewWidget extends StatelessWidget {
  String image;
  String label;
  String text;

  PageViewWidget(
      {super.key,
      required this.image,
      required this.text,
      required this.label});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Center(child: Image.asset(image))),
        Padding(
          padding: EdgeInsets.only(top: height * 0.03),
          child: Text(
            textAlign: TextAlign.start,
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.03, bottom: height * 0.05),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )
      ],
    );
  }
}
