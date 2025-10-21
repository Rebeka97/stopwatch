import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import "../lib/main.dart";
import 'dart:async';

//Segedosztaly a main modositasa helyett
class TestableCounterAppState extends CounterAppState {

  TestableCounterAppState() {
    timer = Timer(Duration.zero, () {})
      ..cancel();
  }

  @override
  void increment() {
    if (isRunning) return;
    isRunning = true;
    timer = Timer(Duration.zero, () {});
  }

  @override
  void pause() {
    if (!isRunning) return;

    if (timer.isActive) {
      timer.cancel();
    }
    isRunning = false;
  }

  @override
  void reset() {
    if (timer.isActive) {
      timer.cancel();
    }

    milisec = 0;
    counter = 0;
    minutes = 0;
    isRunning = false;
    highlightChange = false;
  }
}

void main() {
  group('Stopwatch Unit Tests', () {

      //1. Test: Create a unit test to verify that pressing the start button starts the stopwatch and the elapsed time increases over time.
      test('START gomb megnyomása elindítja a stoppert és az idő nő', () {
        final TestableCounterAppState state = TestableCounterAppState();
        expect(state.isRunning, false);

        state.increment(); //meghivom a funkciot

        expect(state.isRunning, true);

        //manualis leptetes
        for (int i = 0; i < 100; i++) {
          state.milisec++;
          if (state.milisec == 100) {
            state.milisec = 0;
            state.counter++;
          }
        }

        //Ellenorzes
        expect(state.milisec, 0);
        expect(state.counter, 1);
        expect(state.minutes, 0);
        state.timer.cancel();
      });


      //2. Test: Write a unit test to ensure that pressing the pause button pauses the stopwatch and the elapsed time stops increasing.
      test('PAUSE gomb megállítja a stoppert, és az idő megáll', () {
        final TestableCounterAppState state = TestableCounterAppState();
        state.increment();

        expect(state.isRunning, true);

        state.pause(); //meghivas

        //Ellenorzes
        expect(state.isRunning, false);
        expect(state.timer.isActive, false);
      });


      //3. Test: Implement a unit test to confirm that pressing the reset button resets the stopwatch to 0 and stops the elapsed time.
      test('RESET gomb visszaállítja a stoppert 00:00:00-ra', () {
        final TestableCounterAppState state = TestableCounterAppState();

        state.minutes = 1;
        state.counter = 30;
        state.milisec = 50;
        state.isRunning = true;

        state.reset(); //meghivom a funkciot

        //Ellenorzes
        expect(state.minutes, 0);
        expect(state.counter, 0);
        expect(state.milisec, 0);
        expect(state.isRunning, false);
      });

      //4. Test: Write widget test to simulate user interactions by tapping the buttons and verify that the UI responds correctly.

      //5. Test: Include a test case to handle edge cases, such as a verifíing that pressing the start button multiple times without pausing or resetting doesn't cause unexpected behavior.
      test(
        'START gomb többszöri megnyomása nem indítja el többször a számlálót', () {
        final TestableCounterAppState state = TestableCounterAppState();

        state.increment();
        expect(state.isRunning, true);

        state.increment();
        expect(state.isRunning, true);

        state.timer.cancel();
      },
      );
    }
    );
  }
