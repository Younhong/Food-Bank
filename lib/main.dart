import 'package:flutter/material.dart';
import 'package:food_bank/facility.data.dart';
import 'package:food_bank/user.data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Food Bank App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          GestureDetector(
            child: Text("이용자 데이터 조회"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => UserData()
              ));
            },
          ),
          GestureDetector(
            child: Text("이용시설단체 데이터 조회"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FacilityData()
              ));
            },
          )
        ],
      )
    );
  }
}
