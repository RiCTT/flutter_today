import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/*
 * 表字段模拟
 *  haveGotUp: false,
 *  haveGoneBed: false,
 */


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
            new RecordContainer(),
          ],
        )
      )
    );
  }
}

class CircleContainer extends StatefulWidget {
  CircleContainer({Key key}) : super(key: key);

  @override
  _CircleContainerState createState() => _CircleContainerState();
}

class _CircleContainerState extends State<CircleContainer> {
  String statusStr;
  int todayStatus; // 0 我要起床 1 起床成功
  @override
  void initState() { 
    statusStr = '我要起床';
    todayStatus = 0;
    super.initState();
  }

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
    return new InkWell(
      borderRadius: BorderRadius.all(Radius.circular(120.0)),
      onTap: () {
        if (todayStatus == 1) return;
        setState(() {
          todayStatus = 1;
          statusStr = '起床成功';
        });
      }, 
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        width: 240,
        height: 240,
        decoration: boxDirection,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text(
              statusStr,
              style: TextStyle(
                fontSize: 40.0,
                color: Color(0xfff7fcff),
              ),
            ),
            new CurrentTime()
          ],
        )
      )
    );
  }
}

class CurrentTime extends StatefulWidget {
  CurrentTime({Key key}) : super(key: key);
  @override
  _CurrentTimeState createState() => _CurrentTimeState();
}

class _CurrentTimeState extends State<CurrentTime> {
  String currentTime;
  
  @override
  void initState() {
    const timeout = const Duration(seconds: 1);
    Timer.periodic(timeout, (timer) {
      setState(() {
        currentTime = getCurrentTime();
      });
    });
    currentTime = getCurrentTime();
    super.initState();
  }

  String getCurrentTime() {
    var dateTime = DateTime.now();
    var hour = dateTime.hour.toString();
    var minute = dateTime.minute.toString();
    var second = dateTime.second.toString();
    var current = hour + ':' +  minute + ':' + second;
    return current;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Text(
        currentTime,
        style: TextStyle(
          fontSize: 20.0,
          color: Color(0xff9ed7ff)
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
      child: Text('您已经坚持xxx天啦，请继续加油'),
    );
  }
}