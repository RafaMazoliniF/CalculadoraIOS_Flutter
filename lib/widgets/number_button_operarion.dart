import 'package:calculator/main.dart';
import 'package:calculator/widgets/result_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberButtonOperation extends ConsumerWidget {
  final String text;
  final int fontColor;

  const NumberButtonOperation(
      {super.key, required this.text, this.fontColor = 0xFFFFFFFF});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentValue = ref.watch(resultProvider);
    final currentOperationsState = ref.watch(operationsProvider);
    int operationsColor;

    if (currentOperationsState[0] == false) {
      operationsColor = 0xFFEA9E00;
    } else if (currentOperationsState[1] == text) {
      operationsColor = 0xFFFFCB19;
    } else {
      operationsColor = 0xFFEA9E00;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 6,
        height: MediaQuery.of(context).size.width / 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(operationsColor)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
          ),
          onPressed: () {
            if (text != '=') {
              ref.read(operationsProvider.notifier).state = [
                !currentOperationsState[0],
                text,
                currentValue
              ];
            } else {
              if (currentOperationsState[1] == "+") {
                ref.read(resultProvider.notifier).add(
                    double.parse(currentValue),
                    double.parse(currentOperationsState[2]));
              } else if (currentOperationsState[1] == "-") {
                ref.read(resultProvider.notifier).sub(
                    double.parse(currentOperationsState[2]),
                    double.parse(currentValue));
              } else if (currentOperationsState[1] == "×") {
                ref.read(resultProvider.notifier).mul(
                    double.parse(currentOperationsState[2]),
                    double.parse(currentValue));
              } else if (currentOperationsState[1] == "÷") {
                ref.read(resultProvider.notifier).div(
                    double.parse(currentOperationsState[2]),
                    double.parse(currentValue));
              }
            }
          },
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: GoogleFonts.mulish(
                  textStyle: TextStyle(
                      color: Color(fontColor),
                      fontSize: 36,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
