import 'package:calculator/main.dart';
import 'package:calculator/widgets/result_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberButton extends ConsumerWidget {
  final String text;
  final int color;
  final int fontColor;

  const NumberButton(
      {super.key,
      required this.text,
      required this.color,
      this.fontColor = 0xFFFFFFFF});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    final currentValue = ref.watch(resultProvider);
    final currentOperationsState = ref.watch(operationsProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 6,
        height: MediaQuery.of(context).size.width / 6,
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(100),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(color)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
          ),
          onPressed: () {
            if (currentOperationsState[0] == true) {
              if (numbers.contains(text) || text == '.') {
                //New digit
                ref.read(operationsProvider.notifier).state[2] = currentValue;
                ref.read(resultProvider.notifier).newDigit('0', text);
                ref.read(operationsProvider.notifier).state[0] = false;
              } else if (text == 'AC') {
                // Clear
                ref.read(resultProvider.notifier).clear();
                ref.read(operationsProvider.notifier).state[0] = false;
              } else if (text == '+/-') {
                // Neg
                ref.read(resultProvider.notifier).neg();
              } else if (text == '%') {
                // Divide by 100
                ref.read(resultProvider.notifier).percent();
              }
            } else {
              if (currentValue.length <= 7 && numbers.contains(text) ||
                  text == '.') {
                //New digit
                ref.read(resultProvider.notifier).newDigit(currentValue, text);
              } else if (text == 'AC') {
                // Clear
                ref.read(resultProvider.notifier).clear();
              } else if (text == '+/-') {
                // Neg
                ref.read(resultProvider.notifier).neg();
              } else if (text == '%') {
                // Divide by 100
                ref.read(resultProvider.notifier).percent();
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
