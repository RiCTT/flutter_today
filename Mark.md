## 快速创建项目

  flutter create [project_name]

## 常用命令

  - **flutter doctor：** 检查flutter环境配置
  - **终端中输入r：** 热加载
  - **终端中输入R：** 重新启动
  - **终端中输入q：** 退出
  - **终端中输入p：** 显示网格
  - **终端中输入P：** 显示帧率
  - **终端中输入o：** 切换ios跟android的预览模式

## 目录结构
  |目录|名称|
  |----------|----------|
  |pages|所有UI界面的文件|

## 常用组件的区别

  - 布局组件
    
    1、Scaffold

      直译过来就是“脚手架”，搭建了一个基本布局架子，可以添加tab，body，需要包括在MaterialApp组件中
      
    2、Container


    3、InkWell/Ink+InkResponse+Material

      自带常用交互事件和点击交互效果的组件，你可以用InkWell来包裹这个元素；
      ！！！如果容器设置了color，水纹不会生效

    4、Column

      A widget that displays its children in a vertical array;

## 使用其他包（自定义、第三方、本地）

  - 几种库

    ```js
    import 'dart:xxx'; // dart内置库
    import 'package:xxx'; // pub管理的库
    import './xxx'; // 本地文件
    ```

  - 包管理文件(第三方插件和静态文件)

    pubspec.yaml

  - 本地、自定义

    ```js
    import './path.js'
    ```
  
  - 第三方

## http请求

  使用第三方dio库，版本v2
  - 添加依赖
  - 引入dio.dart文件(import 'package:dio/dio.dart';)

  ```dart
  void getHttp()async{
    try{
      Response response;
      var data={'name':'22'};
      response = await Dio().get(
        "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=123",
        //  queryParameters:data
      );
      return print(response);
    }catch(e){
      return print(e);
    }
  }
  ```

## 异步任务

  跟js引擎的event loop有点相似，也分同步任务、微任务、宏任务（概念上）

  ```dart
    import 'dart:async';
    main() {
      print('main #1 of 2');
      scheduleMicrotask(() => print('microtask #1 of 2'));

      new Future.delayed(new Duration(seconds:1),
                        () => print('future #1 (delayed)'));
      new Future(() => print('future #2 of 3'));
      new Future(() => print('future #3 of 3'));

      scheduleMicrotask(() => print('microtask #2 of 2'));

      print('main #2 of 2');
    }
    // 结果
    main #1 of 2
    main #2 of 2
    microtask #1 of 2
    microtask #2 of 2
    future #2 of 3
    future #3 of 3
    future #1 (delayed)
  ```

## 风格

  flutter内置了两种风格

  - material多平台一致（平板、手机、电脑等），提供一些默认的交互动画
  - cupertino适用IOS的交互和风格

## 第三方依赖

  - dio —— http请求库
  - flutter_swiper —— 轮播库
  - flutter_screenutil —— 屏幕适配
  - url_launcher —— 打开网页，发送邮件，拨打电话的插件
  - 数据持久化（ios、android）本地缓存
    - [官方出品shared_preferences](https://pub.dev/packages/shared_preferences)

      ```js
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // 设置
      await prefs.setString(key, value) // setBool, setDouble, setInt
      prefs.setStringList(key, value);

      // 获取
      prefs.getString(key)
      ```

    - local_cache_sync
  - 图片/文件缓存

## 踩坑记录

  - 在函数中如果要停止执行，return后面要接分号；，不然后面的代码还是会执行到，，
  - 早/晚签到记录的结构设计（增/改，获取）

    ```js
    // 字段结构
    let data = {
      2019: [0, 1, 0, 1, 0, 1, 0]
    }
    update = data[day] = 1 // default = 0
    ```