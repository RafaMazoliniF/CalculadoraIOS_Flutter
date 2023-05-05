import 'package:calculator/widgets/result_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberButtonBig extends ConsumerWidget {
  final String text;
  final int color;
  final int fontColor;

  const NumberButtonBig(
      {super.key,
      required this.text,
      required this.color,
      this.fontColor = 0xFFFFFFFF});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentValue = ref.watch(resultProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: MediaQuery.of(context).size.width / 6,
        width: (MediaQuery.of(context).size.width / 3) + 20,
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
            if (ref.watch(resultProvider) != '0') {
              ref.read(resultProvider.notifier).newDigit(currentValue, '0');
            }
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Center(
                  child: Text(
                    text,
                    style: GoogleFonts.mulish(
                        color: Color(fontColor),
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
