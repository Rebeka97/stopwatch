import 'package:flutter/material.dart';
import 'dart:async'; // enélkül nem megy a TIMER

void main() { runApp(const CounterApp()); }

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0; //masodperc szamlalo
  int _minutes = 0; //perc szamlalp (bovitheto oraval, nappal stb...)
  late Timer _timer;

  bool _isRunning = false; //logikai valtozo a mar futo szamlalomhoz

  /*void _increment() { //valtozo novelese
    setState(() {
      _counter++;
    });
  }*/

  void _increment() { //valtozo folyamatos novekedese
    if (_isRunning) return; //fontos!!!!! Ne induljon el tobbszor!!!
    _isRunning = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) { //masodpercenkent no
    setState(() {
      _counter++;

      if (_counter == 60) { // 60 masodpercenkent noveli a percet es nullaza a mp-t
        _counter = 0;
        _minutes++;
      }
    });
    });
  }

  void _pause() { //valtozo novelesenek megallitasa
    setState(() {
      _timer.cancel();
    });
  }

  void _reset() { //visszaallitas 0-ra a masodpercet es percet is

    setState(() {
      _counter = 0;
      _minutes = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(title: const Text('Task 1 - Stopwatch')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //kozepre igazit
            children: <Widget>[

              Text(
                '$_minutes :', //a perc valtozom meghivasa
                style: const TextStyle(
                    fontSize: 60, fontWeight: FontWeight.bold),
              ),

              Text(
                '$_counter', //a masodperc valtozom meghivasa
                style: const TextStyle(
                    fontSize: 60, fontWeight: FontWeight.bold),
              ),

              //gombok
              ElevatedButton(
                onPressed: _increment, //
                child: const Text('START'),
              ),

              ElevatedButton(
                onPressed: _pause,
                child: const Text('PAUSE'),
              ),

              ElevatedButton(
                onPressed: _reset,
                child: const Text('RESET'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}