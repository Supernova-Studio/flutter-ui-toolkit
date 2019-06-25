import 'package:flutter/material.dart';
import 'package:supernova_flutter_ui_toolkit/transitions.dart';
import 'package:supernova_flutter_ui_toolkit/keyframes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supernova Toolkit Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(title: 'Supernova Toolkit Demo'),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {

  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
  }

  startAnimation() {
    this.controller.reset();
    this.controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.title),),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 100,
              height: 100,
              child: AnimatableRectangle(controller: this.controller),
            )
          ),

          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(onPressed: () {
              this.startAnimation();
            }),
          )
        ],
      ),
    );
  }
}

class AnimatableRectangle extends StatelessWidget {

  AnimatableRectangle({
    Key key,
    AnimationController controller,
  }): this._backgroundColorAnimation = ColorInterpolation(
    keyframes: [
      Keyframe(fraction: 0, value: Colors.black),
      Keyframe(fraction: 0.3, value: Colors.yellow.shade500),
      Keyframe(fraction: 0.6, value: Colors.red.shade500),
      Keyframe(fraction: 1, value: Colors.blueAccent.shade400)
    ]
  ).animate(controller),
  this._cornerRadiusAnimation = Interpolation(
    keyframes: [
      Keyframe<double>(fraction: 0, value: 0),
      Keyframe<double>(fraction: 0.3, value: 30),
      Keyframe<double>(fraction: 0.6, value: 15),
      Keyframe<double>(fraction: 1, value: 50)
    ]
  ).animate(controller),
  super(key: key);

  Animation<Color> _backgroundColorAnimation;
  Animation<double> _cornerRadiusAnimation;

  @override
  Widget build(BuildContext context) {
    return DecorationTransition(
      cornerRadiusAnimation: this._cornerRadiusAnimation,
      colorAnimation: this._backgroundColorAnimation,
    );
  }
}
