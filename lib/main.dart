import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;
  TextEditingController numberofcallsController = TextEditingController();
  int _start = 0;
  int _counter = 0;
  double rating = 0;

  int count = 0;

  void startTimer() {
    var ratingInteger = (rating * 10).round();
    // for (var i = 0; i < ratingInteger; i++) {

    const _oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(_oneSec, (timer) {
      print(ratingInteger);
      _start = int.parse(numberofcallsController.text);
      setState(() {
        if (_start > 0) {
          _start--;
          if (_start == 0) {
            launchCaller();
          }
        } else {
          _timer!.cancel();
        }
      });
    });
    // }
  }

  void launchCaller() async {
    FlutterPhoneDirectCaller.callNumber('+201234567890');
  }

  void _incrementCounter() async {
    startTimer();
    if (_start > 0) {
      //
    } else {
      launchCaller();
    }
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Seconds : ' + _start.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              const Text(
                'Enter Number Of Seconds Please !',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              TextField(
                keyboardType: TextInputType.number,
                autofocus: true,
                textAlign: TextAlign.center,
                controller: numberofcallsController,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              const Text(
                'Current Number Of Calls:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Slider(
                value: rating,
                onChanged: (newRating) {
                  setState(() {
                    rating = newRating;
                    print(rating);
                  });
                },
                divisions: 5,
              ),
              Text(
                (rating * 10).toInt().toString(),
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var x = rating * 10;
          _incrementCounter();
        },
        tooltip: 'Call',
        child: Icon(Icons.call),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
