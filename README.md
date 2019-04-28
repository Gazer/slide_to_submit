# slide_to_submit

A Flutter widget that allow the user submit an action sliding a widget.

## Usage
To use this plugin, add `slide_to_submit` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).


### Example

``` dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SlideToSubmitWidget(
            icon: Icons.arrow_forward,
            text: "Deslizá para transferir",
            color: Colors.red,
            onSubmit: (onFinish, onError) async {
              // .. submit code ..
              onFinish();
            },
          ),
          SizedBox(height: 16.0,),
          SlideToSubmitWidget(
            icon: Icons.arrow_forward,
            text: "Go! Go!",
            color: Colors.green,
            onSubmit: (onFinish, onError) async {
              // .. submit code ..

              onError();
            },
          )
        ],
      ),
    ),
  ));
}

```
