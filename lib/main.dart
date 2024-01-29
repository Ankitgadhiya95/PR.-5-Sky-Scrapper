import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sky/provide/theme_provider.dart';
import 'package:sky/screens/screens.dart';
import 'package:sky/utilities/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>ThemeProvider())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, providerios, child) {
        return MaterialApp(
          title: 'Flutter Clima',
          debugShowCheckedModeBanner: false,
          theme: providerios.isDarkMethod == true
              ? ThemeData.dark(useMaterial3: true)
              : ThemeData.light(useMaterial3: true),

          /*ThemeData.dark().copyWith(
            primaryColor: kPrimaryDarkColor,
            hintColor: kTealColor,
            scaffoldBackgroundColor: kPrimaryDarkColor,
          ),*/
          home: LoadingScreen(
            fromPage: 'location', cityName: '',
          ),
        );}
      ),
    );
  }
}
