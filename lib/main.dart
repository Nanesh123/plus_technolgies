import 'package:flutter/material.dart';
import 'package:plus_technolgies/provider/client_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'screen/client_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ClientProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          applyElevationOverlayColor: true,
        ),
        home: ClientScreen(),
      ),
    );
  }
}
