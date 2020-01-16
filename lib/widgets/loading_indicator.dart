import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
