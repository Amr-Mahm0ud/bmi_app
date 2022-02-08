import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'home.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SplashScreenView(
          navigateRoute: const MyHomePage(),
          pageRouteTransition: PageRouteTransition.SlideTransition,
          duration: 2000,
          text: 'Please Wait...',
          textStyle: Theme.of(context).textTheme.bodyText2,
          textType: TextType.TyperAnimatedText,
        ),
        const Align(
          alignment: Alignment(0, 0.85),
          child: CircularProgressIndicator(),
        )
      ]),
    );
  }
}
