import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final startNum = 1.obs;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton.filled(
              onPressed: () {
                startNum.value -= 1;
              },
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(width: 20),
            Obx(() {
              int number = startNum.value;
              return Text(
                '$number',
                style: Theme.of(context).textTheme.displaySmall,
              );
            }),
            const SizedBox(width: 20),
            IconButton.filled(
              onPressed: () {
                startNum.value += 1;
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
