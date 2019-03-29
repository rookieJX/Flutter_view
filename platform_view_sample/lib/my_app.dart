import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {

  static const methodChannel = const MethodChannel('com.pages.your/native_get');
  int _counter = 0;

  void _incrementCounter() {
    _counter++;

    print('flutter的log打印：现在输出count=$_counter');
    Map<String, String> map = { "title": "这是一条来自flutter的参数点击了$_counter次" };
    methodChannel.invokeMethod('toNativePush',map);
  }

  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 380,
            height: 500,
            child: UiKitView(
              viewType: 'NativeView',
            ),
          ),
        ),
          floatingActionButton: new FloatingActionButton(
            onPressed :() {
              _incrementCounter();
            } ,
            child: new Icon(Icons.add),
            backgroundColor: Colors.blue,
          )
      ),
    );
  }


}