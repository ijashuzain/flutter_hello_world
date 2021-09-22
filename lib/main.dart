import 'package:flutter/material.dart';
import 'package:hello_world/loginFature/loginPage.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (_, model, __) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(), // Provide light theme.
              darkTheme: ThemeData.dark(), // Provide dark theme.
              themeMode: model.mode, // Decides which theme to show.
              home: MainApp(model: model));
        },
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  final ThemeModel model;

   MainApp({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Light/Dark Theme Demo')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => model.toggleMode(),
            child: Text('Toggle Theme'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text('Login Page'),
          ),
        ],
      )),
    );
  }
}

class ThemeModel with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeModel({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
