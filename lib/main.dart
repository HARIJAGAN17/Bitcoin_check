import 'package:flutter/material.dart';

import 'Price_Screen.dart';

void main()
{
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Price(),
    );
  }
}
