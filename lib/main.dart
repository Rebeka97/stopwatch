import 'package:flutter/material.dart';
import 'dart:async'; // enélkül nem megy a TIMER

void main() { runApp(const CounterApp()); }

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;
  late Timer _timer;

  /*void _increment() { //valtozo novelese
    setState(() {
      _counter++;
    });
  }*/

  void _increment() { //valtozo folyamatos novekedese
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) { //masodpercenkent no
    setState(() {
      _counter++;
    });
    });
  }


  void _pause() { //valtozo novelesenek megallitasa
    setState(() {
      _timer.cancel();
    });
  }

  void _reset() { //visszaallitas 0-ra
    setState(() {
      _counter = 0;
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
                '$_counter', //a valtozom meghivasa
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