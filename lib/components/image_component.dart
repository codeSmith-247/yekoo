import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final double height;
  final double width;
  final String link;
  final double radius;

  const ImageBox(
      {super.key,
      this.link = '',
      this.height = 100,
      this.width = 100,
      this.radius = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (width / 100),
      height: MediaQuery.of(context).size.height * (height / 100),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(
          image: AssetImage(link),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class IconBox extends StatelessWidget {
  final double height;
  final double width;
  final String link;
  final double radius;

  const IconBox(
      {super.key,
      this.link = '',
      this.height = 100,
      this.width = 100,
      this.radius = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * (height / 100),
      height: MediaQuery.of(context).size.height * (height / 100),
      // margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(
          image: AssetImage(link),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
