import 'package:bmi_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
      ),
      body: Consumer<MyProv>(
        builder: (context, value, child) => SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Gender: ${value.isMale ? 'Male' : 'Female'}'),
                Text('Result: ${value.result.toStringAsFixed(1)}'),
                Text(
                  'Healthiness: ${value.resultPhrase}',
                  textAlign: TextAlign.center,
                ),
                Text('Age: ${value.age}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
