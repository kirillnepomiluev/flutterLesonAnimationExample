import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

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
class AnimatedLogo extends AnimatedWidget {
  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 300, end: 600);
  static final _topMarginTween = Tween<double>(begin: 10, end: 200);
  static final _leftMarginTween = Tween<double>(begin: 10, end: 100);
  Widget child;
  AnimatedLogo({Key key, Animation<double> animation, this.child})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Container(
      child: Opacity(opacity: _opacityTween.evaluate(animation),
      child: Container(
        margin: EdgeInsets.fromLTRB(_leftMarginTween.evaluate(animation),
            _topMarginTween.evaluate(animation), 0, 0),
      height: _sizeTween.evaluate(animation),
      width: 300,
      child: child,)),
    );
  }
}




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
      if (status == AnimationStatus.dismissed)
        controller.forward();
    });
    super.initState();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: AnimatedLogo(animation: animation, child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.blue,) ),
          child: Center(child: Text("Загрузка"))),)
      );
      // This trailing comma makes auto-formatting nicer for build methods.

  }
}
