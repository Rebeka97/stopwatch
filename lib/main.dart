import 'package:flutter/material.dart';
import 'dart:async'; //enelkul nem megy a TIMER

void main() {
  runApp(const CounterApp());
}

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
  bool _highlightChange = false; //percvaltasnak szinvaltas

  /*void _increment() { //valtozo novelese
    setState(() {
      _counter++;
    });
  }*/

  void _increment() {
    //valtozo folyamatos novekedese
    if (_isRunning) return; //fontos!!!!! Ne induljon el tobbszor!!!
    _isRunning = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //masodpercenkent no
      setState(() {
        if (_counter == 1) {
          _highlightChange = false;
        }
        _counter++;

        if (_counter == 60) {
          // 60 masodpercenkent noveli a percet es nullaza a mp-t
          _counter = 0;
          _minutes++;
          _highlightChange = true;
        }
      });
    });
  }

  void _pause() {
    //TASK: NEM INDUL UJRA A SZAMLALAS!
    //valtozo novelesenek megallitasa
    if (!_isRunning) return; //csak futasnal lehet leallitani

    if (_timer.isActive) {
      //amikor aktiv, akkor leall
      _timer.cancel();
    }

    setState(() {
      _isRunning = false; //ujra mukodik a start gomb
    });
  }

  void _reset() {
    //visszaallitas 0-ra a masodpercet es percet is

    setState(() {
      _counter = 0;
      _minutes = 0;
      _timer.cancel(); //ne induljon ujra
      _isRunning = false;
      _highlightChange = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //gombok formazasa
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.green,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      textStyle: const TextStyle(fontSize: 18),
    );

    //kijelzo zoldre valtasa minden percben
    final Color displayColor = _highlightChange ? Colors.green : Colors.black;

    final TextStyle displayStyle = TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      color: displayColor,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(title: const Text('Task 1 - Stopwatch')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //kozepre igazit
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //kozepre igazitja egy sorba a szamlalokat
                children: <Widget>[
                  Text(_minutes.toString(), style: displayStyle),
                  //a perc valtozom
                  Text(' : ', style: displayStyle),
                  Text(_counter.toString(), style: displayStyle),
                  //a masodperc valtozom
                ],
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //kozepre igazitja egy sorba a gombokat
                children: [
                  //gombok
                  ElevatedButton(
                    onPressed: _increment,
                    style: buttonStyle,
                    child: const Text('START'),
                  ),

                  const SizedBox(width: 15),

                  ElevatedButton(
                    onPressed: _pause,
                    style: buttonStyle,
                    child: const Text('PAUSE'),
                  ),

                  const SizedBox(width: 15),

                  ElevatedButton(
                    onPressed: _reset,
                    style: buttonStyle,
                    child: const Text('RESET'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
