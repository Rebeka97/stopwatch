import 'package:flutter/material.dart';
import 'dart:async'; //enelkul nem megy a TIMER

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => CounterAppState();
}

class CounterAppState extends State<CounterApp> {
  int milisec = 0; //milisec szamlalo
  int counter = 0; //masodperc szamlalo
  int minutes = 0; //perc szamlalp (bovitheto oraval, nappal stb...)
  late Timer timer;

  bool isRunning = false; //logikai valtozo a mar futo szamlalomhoz
  bool highlightChange = false; //percvaltasnak szinvaltas

  List<String> laps = []; //koridok tarolasara szolgalo lista

  String get formattedTime => //listaa elemeinek megfelelo kijelzese 00:00:00
      '${minutes.toString().padLeft(2, '0')} : ${counter.toString().padLeft(2, '0')} : ${milisec.toString().padLeft(2, '0')}';

  /*void _increment() { //valtozo novelese
    setState(() {
      _counter++;
    });
  }*/

  void increment() {
    //valtozo folyamatos novekedese
    if (isRunning) return; //fontos!!!!! Ne induljon el tobbszor!!!
    isRunning = true;

    /*_timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //masodpercenkent no
      setState(() {
        if (_highlightChange) {
          _highlightChange = false;
        }

        _counter++;

        if (_counter == 60) {
          //60 masodpercenkent noveli a percet es nullaza a mp-t
          _counter = 0;
          _minutes++;
          _highlightChange = true; //percvaltas
        }*/

    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      //milisec timer beallitasa, 1000 a valto, de progban centisec kell valamierrt
      setState(() {
        // Kiemelés kikapcsolása, ha aktív volt (csak 1 másodpercig tart)
        if (highlightChange) {
          highlightChange = false;
        }

        milisec++; // Növeljük a miliszekundum (centiszekundum) számlálót

        if (milisec == 100) {
          milisec = 0;
          counter++;

          if (counter == 60) {
            // 60 másodpercenként növeli a percet és nullázza a mp-t
            counter = 0;
            minutes++;
            /*_highlightChange =
                true; // Percváltás: Beállítjuk a kiemelést TRUE-ra*/
          }
        }
        highlightChange =
            (minutes > 0 &&
            minutes % 10 == 0); //10 percenkent zold a kijelzett ido
      });
    });
  }

  void pause() {
    //TASK: NEM INDUL UJRA A SZAMLALAS!
    //valtozo novelesenek megallitasa
    if (!isRunning) return; //csak futasnal lehet leallitani

    if (timer.isActive) {
      //amikor aktiv, akkor leall
      timer.cancel();
    }

    setState(() {
      isRunning = false; //ujra mukodik a start gomb
    });
  }

  void reset() {
    //visszaallitas 0-ra a masodpercet es percet is
    setState(() {
      milisec = 0;
      counter = 0;
      minutes = 0;
      timer.cancel(); //ne induljon ujra
      isRunning = false;
      highlightChange = false;
    });
  }

  void lap() {
    if (!isRunning) return;

    setState(() {
      //mindig az uj adat keruljon elore!
      laps.insert(0, formattedTime);
    });

    print('LAP saved: ${laps.first}');
  }

  void deleteLaps() {
    setState(() {
      laps.clear();
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
    final Color displayColor = highlightChange ? Colors.green : Colors.black;

    final TextStyle displayStyle = TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      color: displayColor,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,

        //appBar: AppBar(title: const Text('Task 1 - Stopwatch')),
        appBar: AppBar(
          title: const Text('Stopwatch'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: Container(
          //hatterszin
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC8E6C9), Color(0xFFFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 326),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //kozepre igazitja egy sorba a szamlalokat
                      children: <Widget>[
                        Text(formattedTime, style: displayStyle),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //kozepre igazitja egy sorba a szamlalokat
              children: <Widget>[
                //a perc valtozom
                Text(minutes.toString().padLeft(2, '0'), style: displayStyle),
                //00:00:00 formatum
                Text(' : ', style: displayStyle),
                //a masodperc valtozom
                Text(counter.toString().padLeft(2, '0'), style: displayStyle),
                //00:00:00 formatum
                Text(' : ', style: displayStyle),
                //a milisec valtozom
                Text(milisec.toString().padLeft(2, '0'), style: displayStyle),
                //00:00:00 formatum
              ],
            ),

            const SizedBox(height: 30),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //kozepre igazitja egy sorba a gombokat
                    children: [
                      //gombok
                      ElevatedButton(
                        onPressed: increment,
                        style: buttonStyle,
                        child: const Text('START'),
                      ),

                      const SizedBox(width: 15),

                      ElevatedButton(
                        onPressed: pause,
                        style: buttonStyle,
                        child: const Text('PAUSE'),
                      ),

                      const SizedBox(width: 15),

                      ElevatedButton(
                        onPressed: reset,
                        style: buttonStyle,
                        child: const Text('RESET'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //kozepre igazitja egy sorba a gombokat
                    children: [
                      ElevatedButton(
                        onPressed: lap,
                        style: buttonStyle.copyWith(
                          shape: MaterialStateProperty.all(
                            const CircleBorder(),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(25),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.lightGreen.shade400,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                        ),
                        child: const Text('LAP'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Padding(
                    //A lista elejen elhelyezkedo cim
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (laps.isNotEmpty) //rekord rogziteskor jelenjen meg
                          const Text(
                            'Laps:',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        if (laps.isNotEmpty) //torles gomb
                          IconButton(
                            icon: const Icon(Icons.delete_sweep),
                            onPressed: deleteLaps,
                            tooltip: null,
                            style: ButtonStyle(
                              //piros hover
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>((
                                    Set<MaterialState> states,
                                  ) {
                                    if (states.contains(
                                      MaterialState.hovered,
                                    )) {
                                      return Colors.red;
                                    }
                                    return Colors.black;
                                  }),
                              //felesleges formazas eltuntetese
                              splashFactory: NoSplash.splashFactory,

                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>((
                                    Set<MaterialState> states,
                                  ) {
                                    if (states.contains(
                                      MaterialState.hovered,
                                    )) {
                                      return Colors.transparent;
                                    }
                                    if (states.contains(
                                      MaterialState.pressed,
                                    )) {
                                      return Colors.transparent;
                                    }
                                    return Colors.transparent;
                                  }),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),

                  //Korido listajat kijelzem
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: laps.isEmpty
                          ? Container()
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: laps.length,
                              itemBuilder: (context, index) {
                                final lapNumber = laps.length - index;
                                final lapTime = laps[index];

                                final isLatestLap = index == 0;
                                final itemColor = isLatestLap
                                    ? Colors.lightGreen.shade400
                                    : Colors.black;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Lap $lapNumber.:',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: itemColor,
                                        ),
                                      ),
                                      Text(
                                        lapTime,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: itemColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
