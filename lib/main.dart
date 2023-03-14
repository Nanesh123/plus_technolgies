import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plus_technolgies/model/local/clientModel.dart';
import 'package:plus_technolgies/provider/client_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'screen/client_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureHive();
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
        home: const ClientScreen(),
      ),
    );
  }
}

Future<void> configureHive() async {
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter<ClientModel>(ClientModelAdapter());
  await Hive.openBox<ClientModel>("client");
}
