import 'package:calculator/widgets/number_button.dart';
import 'package:calculator/widgets/number_button_big.dart';
import 'package:calculator/widgets/number_button_operarion.dart';
import 'package:calculator/widgets/result_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

const _providerList = [false, '', 0.0];

final operationsProvider = StateProvider<List>((ref) => _providerList);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [
      0xFF333333,
      0xFFEA9E00,
      0xFF8C8C8C
    ]; // 0 = Cinza, 1 = Amarelo, 2 = Cinza Claro

    return CupertinoApp(
      home: Builder(builder: (context) {
        return CupertinoPageScaffold(
          navigationBar:
              const CupertinoNavigationBar(backgroundColor: Colors.black),
          backgroundColor: Colors.black,
          child: Padding(
            padding: EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: MediaQuery.of(context).size.height * 0.05),
            child: Consumer(
              builder: (context, ref, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const ResultField(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberButton(
                            text: "AC",
                            color: colors[2],
                            fontColor: 0xFF000000),
                        NumberButton(
                            text: "+/-",
                            color: colors[2],
                            fontColor: 0xFF000000),
                        NumberButton(
                            text: "%", color: colors[2], fontColor: 0xFF000000),
                        const NumberButtonOperation(text: "÷"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberButton(text: "7", color: colors[0]),
                        NumberButton(text: "8", color: colors[0]),
                        NumberButton(text: "9", color: colors[0]),
                        const NumberButtonOperation(text: "×"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberButton(text: "4", color: colors[0]),
                        NumberButton(text: "5", color: colors[0]),
                        NumberButton(text: "6", color: colors[0]),
                        const NumberButtonOperation(text: "-"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberButton(text: "1", color: colors[0]),
                        NumberButton(text: "2", color: colors[0]),
                        NumberButton(text: "3", color: colors[0]),
                        const NumberButtonOperation(text: "+"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NumberButtonBig(text: "0", color: colors[0]),
                        NumberButton(text: ".", color: colors[0]),
                        const NumberButtonOperation(text: "="),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
