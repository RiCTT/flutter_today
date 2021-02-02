import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 * 表字段模拟
 *  // 早起的格式，早睡类似（统计需要组合计算）
 *  let data = {
 *    2019: {
 *      1: [1, 0, 0, 1, ....],
 *      2: [0, 1, 0, 1, ....]
 *    }
 *  }
 *  0 = 这一天未打卡
 *  1 = 打了起床卡
 *  update = data[day] = 1 // default = 0
 */


class HomePage extends StatefulWidget {

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int upStatus;
  int downStatus;

  getTodayStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = (prefs.getString('up_list'));
    print('list === ');
    print(list);
    print(list);
  }
  
  updateTodayList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var s = [{
      1022: [1, 0, 2]
    }];
    var d = s.toString();
    await prefs.setString('up_list', d);
  }
  
  @override
  void initState() {
    getTodayStatus();
    updateTodayList();
    upStatus = 0;
    downStatus = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new CircleContainer(
              upStatus: upStatus, 
              downStatus: 0,
              onChangeUp: () {
                setState(() {
                  upStatus = 1;
                });
              },
              onChangeDown: () {
                setState(() {
                  downStatus = 1;
                });
              }
            ),
            new RecordContainer(),
          ],
        )
      )
    );
  }
}


class CircleContainer extends StatefulWidget {
  final upStatus; // 起床的状态
  final downStatus; // 睡觉的状态
  final Function onChangeUp;
  final Function onChangeDown;

  CircleContainer({
    Key key, 
    this.upStatus, 
    this.downStatus,
    this.onChangeUp,
    this.onChangeDown
  }) : super(key: key);

  @override
  _CircleContainerState createState() => _CircleContainerState();
}

List<Color> upColor = [
  Color(0xFF5abcff),
  Color(0xFF379afb)
];

List<Color> downColor = [
  Color(0xff40495e),
  Color(0xFF30394e)
];

class _CircleContainerState extends State<CircleContainer> {
  String upStatusStr;
  String downStatusStr;
  List<Color> gradientColors;
  bool lock;
  
  @override
  void initState() {
    if (widget.upStatus == 0) {
      upStatusStr = '我要起床';
      gradientColors = upColor;
    } else {
      upStatusStr = '早起成功';
      gradientColors = upColor;
    }
    
    if (widget.downStatus == 0 && widget.upStatus == 1) {
      upStatusStr = '要睡觉啦~';
      gradientColors = downColor;
    }
    if(widget.downStatus == 1 && widget.upStatus == 1) {
      upStatusStr = '早睡成功';
      gradientColors = downColor;
    }
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
        colors: gradientColors,
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
        if (widget.upStatus == 1 && widget.downStatus == 1) return;
        if (widget.upStatus == 0) {
          widget.onChangeUp();
          upStatusStr = '早起成功';
          setState(() {
            lock = true;
          });
          new Future.delayed(
            new Duration(seconds: 3),
            () {
              setState(() {
                upStatusStr = '等待睡觉～';
                gradientColors = downColor;
                lock = false;
              });
            }
          );
        }
        if (widget.downStatus == 0 && widget.upStatus == 1 && !lock) {
          widget.onChangeDown();
          upStatusStr = '早睡成功';
        }
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
              upStatusStr,
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
    if (minute.length == 1) {
      minute = '0' + minute;
    }
    var second = dateTime.second.toString();
    if (second.length == 1) {
      second = '0' + second;
    }
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