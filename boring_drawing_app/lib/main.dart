
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _offsets = <Offset>[];
  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
     
      body: GestureDetector(
        
        onPanStart: (details) {
         setState(() {
          final renderObject = context.findRenderObject() as RenderBox;
          final localPosition = renderObject.globalToLocal(details.globalPosition);
          print(details.globalPosition);
            _offsets.add(localPosition);
         });
          
        },
        onPanUpdate: (details){
         setState(() {
          final renderObject = context.findRenderObject() as RenderBox;
          final localPosition = renderObject.globalToLocal(details.globalPosition);
          print(details.globalPosition);
            _offsets.add(localPosition);
         });
        },
        onPanEnd: (details) {
          _offsets.clear();
        },
        
        child: Center(
          child: CustomPaint(
            painter: FlipBookPainter(_offsets),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              
            ),
          ),
        ),
      ),
    
    );
  }
}

class FlipBookPainter extends CustomPainter {
  final List<Offset> offsets;

  FlipBookPainter(this.offsets): super();


  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;
    for(var i = 0; i < offsets.length; i++){
      if(offsets[i] != null && offsets[i+1] != null ){
        canvas.drawLine(
          offsets[i]!, 
          offsets[i+1]!, 
          paint);
      } else if ( offsets[i] != null && offsets[i+1] == null ) {
        canvas.drawPoints(
          PointMode.points,
          [offsets[i]], 
          paint);
      }
    }


    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}