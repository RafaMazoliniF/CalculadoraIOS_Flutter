import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

//Notifier with it's methods
class ResultNotifier extends StateNotifier<String> {
  ResultNotifier() : super('0');

  void clear() {
    state = '0';
  }

  void newDigit(String currentValue, String newValue) {
    if (newValue == '.') {
      if (!state.contains(newValue)) {
        state = currentValue + newValue;
      }
    } else {
      state = currentValue + newValue;
    }
  }

  void neg() {
    num aux;
    if (state.contains('.')) {
      aux = double.parse(state);
    } else {
      aux = int.parse(state);
    }

    state = (-aux).toString();
  }

  void percent() {
    state = (double.parse(state) / 100).toString();
  }

  void add(double firstValue, double secondValue) {
    num res = firstValue + secondValue;
    if (res.toInt() == res.toDouble()) {
      res = res.toInt();
    }
    state = (res).toString();
  }

  void sub(double firstValue, double secondValue) {
    num res = firstValue - secondValue;
    if (res.toInt() == res.toDouble()) {
      res = res.toInt();
    }
    state = (res).toString();
  }

  void mul(double firstValue, double secondValue) {
    num res = double.parse((firstValue * secondValue).toStringAsPrecision(5));
    if (res.toInt() == res.toDouble()) {
      res = res.toInt();
    }
    state = (res).toString();
  }

  void div(double firstValue, double secondValue) {
    num res = double.parse((firstValue / secondValue).toStringAsPrecision(5));
    if (res.toInt() == res.toDouble()) {
      res = res.toInt();
    }
    state = (res).toString();
  }
}

// Provider of result
final resultProvider =
    StateNotifierProvider<ResultNotifier, String>((ref) => ResultNotifier());

// Result Widget
class ResultField extends StatelessWidget {
  const ResultField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        alignment: Alignment.bottomRight,
        color: Colors.black,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Consumer(builder: (context, ref, child) {
            String value = ref.watch(resultProvider); // Get the provider value

            // Removes left zero if it has not a decimal part
            if (value[0] == '0' && value != '0') {
              value = value.substring(1);
              if (value[0] == '.') {
                value = '0$value';
              }
            }

            return Text(
              value,
              style: GoogleFonts.mulish(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 72,
                    fontWeight: FontWeight.bold),
              ),
            );
          }),
        ),
      ),
    );
  }
}
