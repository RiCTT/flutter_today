import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new CircleContainer(),
            new RecordContainer()
          ],
        )
      )
    );
  }
}

class CircleContainer extends StatelessWidget {
  const CircleContainer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var boxDirection = new BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color(0xffc7e3fe),
          offset: Offset(0.0, 15.0),
          blurRadius: 20.0, //阴影模糊程度
          spreadRadius: 1.0 
        ),
      ],
      gradient: LinearGradient(
        colors: [
          Color(0xFF5abcff),
          Color(0xFF379afb)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
            // color: Colors.blue,
      borderRadius: BorderRadius.all(
        Radius.circular(120.0)
      )
    );

    return Container(
      child: new Container(
        padding: EdgeInsets.only(top: 20.0),
        width: 240,
        height: 240,
        decoration: boxDirection,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text(
              '早 起',
              style: TextStyle(
                fontSize: 40.0,
                color: Color(0xfff7fcff),
              ),
            ),
            new Text(
              '19:12:11',
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xff9ed7ff)
              )
            )
          ],
        )
      ),
    );
  }
}

class RecordContainer extends StatelessWidget {
  const RecordContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      child: new Text('今天是记录的第xx天，请继续保持'),
    );
  }
}