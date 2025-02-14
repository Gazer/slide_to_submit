import 'package:flutter/material.dart';
import 'package:slide_to_submit/slide_to_submit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title}) : super();

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future pause() => Future.delayed(Duration(seconds: 2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideToSubmitWidget(
                icon: Icons.arrow_forward,
                text: "Deslizá para transferir",
                color: Colors.red,
                onSubmit: (onFinish, onError) async {
                  await pause();

                  onFinish();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideToSubmitWidget(
                icon: Icons.arrow_forward,
                text: "Go! Go!",
                color: Colors.green,
                onSubmit: (onFinish, onError) async {
                  await pause();

                  onError();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideToSubmitWidget(
                icon: Icons.arrow_forward,
                text: "Deslizá para transferir",
                color: Colors.red,
                height: 60,
                onSubmit: (onFinish, onError) async {
                  await pause();

                  onFinish();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideToSubmitWidget(
                icon: Icons.arrow_forward,
                text: "Go! Go!",
                color: Colors.green,
                height: 40,
                onSubmit: (onFinish, onError) async {
                  await pause();

                  onError();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideToSubmitWidget(
                icon: Icons.arrow_forward,
                text: "Deslizá para transferir",
                color: Colors.red,
                height: 160,
                onSubmit: (onFinish, onError) async {
                  await pause();

                  onFinish();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideToSubmitWidget(
                icon: Icons.arrow_forward,
                text: "Go! Go!",
                color: Colors.green,
                height: 140,
                onSubmit: (onFinish, onError) async {
                  await pause();

                  onError();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
