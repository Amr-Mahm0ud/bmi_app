import 'package:bmi_app/provider.dart';
import 'package:bmi_app/result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int age = 20;
  int weight = 70;
  double height = 170.0;
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<MyProv>(context).themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                isDark = !isDark;
                Provider.of<MyProv>(context, listen: false).changeTheme(isDark);
              },
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode)),
        ],
      ),
      body: Consumer<MyProv>(
        builder: (context, value, _) => SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Row(
                    children: [
                      genderCardBuilder(value, context, true),
                      const SizedBox(width: 15),
                      genderCardBuilder(value, context, false),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Height',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              height.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              'cm',
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                        Slider(
                            value: height,
                            min: 50,
                            max: 250,
                            onChanged: (newVal) {
                              setState(() {
                                height = newVal;
                              });
                            })
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Row(
                    children: [
                      weightAndAgeCard(value, context, 'weight'),
                      const SizedBox(width: 15),
                      weightAndAgeCard(value, context, 'age'),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    minimumSize: Size(double.infinity,
                        MediaQuery.of(context).size.height / 16)),
                onPressed: () {
                  value.age = age;
                  value.calculateResult(weight, height);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const Result()));
                },
                child: Text(
                  'Calculate',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded genderCardBuilder(MyProv value, BuildContext context, bool male) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!value.isMale && male) value.changeGender(true);
          if (value.isMale && !male) value.changeGender(false);
        },
        child: Container(
          decoration: BoxDecoration(
              color: male
                  ? value.isMale
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary
                  : value.isMale
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                male ? Icons.male : Icons.female,
                size: 90,
              ),
              Text(
                male ? 'Male' : 'Female',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded weightAndAgeCard(MyProv value, BuildContext context, String card) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              card == 'weight' ? 'Weight' : 'Age',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              card == 'weight' ? weight.toString() : age.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onLongPress: () {
                    setState(() {
                      if (card == 'weight')
                        ((weight - 10) > 15)
                            ? weight = weight - 10
                            : weight = 15;
                      else
                        ((age - 5) > 1) ? age = (age - 5) : age = 1;
                    });
                  },
                  child: FloatingActionButton(
                    heroTag: card == 'age' ? 'age--' : 'weight--',
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      setState(() {
                        if (card == 'weight')
                          weight > 15 ? weight-- : weight = 15;
                        else
                          age > 1 ? age-- : age = 1;
                      });
                    },
                    child: const Icon(Icons.remove),
                    mini: true,
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onLongPress: () {
                    setState(() {
                      if (card == 'weight')
                        (weight + 10) < 200
                            ? weight = weight + 10
                            : weight = 200;
                      else
                        (age + 5) < 150 ? age = age + 5 : age = 150;
                    });
                  },
                  child: FloatingActionButton(
                    heroTag: card == 'age' ? 'age++' : 'weight++',
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      setState(() {
                        if (card == 'weight')
                          weight < 200 ? weight++ : weight = 200;
                        else
                          age < 150 ? age++ : age = 150;
                      });
                    },
                    child: const Icon(Icons.add),
                    mini: true,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
