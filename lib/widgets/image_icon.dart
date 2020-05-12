import 'package:flutter/material.dart';

class ImageIconWidget extends StatefulWidget {

  final String temperature;
  final String description;

  @override
  _ImageIconWidgetState createState() => _ImageIconWidgetState();

  const ImageIconWidget({Key key, this.temperature, this.description,}) : super(key: key);

}

class _ImageIconWidgetState extends State<ImageIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}