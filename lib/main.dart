import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonuri de service',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bonuri de service'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Bon {
  int nr;
  bool checked;

  Bon(this.nr, this.checked);
}

class _MyHomePageState extends State<MyHomePage> {
  List<Bon> _bonuri = [];
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _bonuri.add(Bon(++_counter, false));
    });
  }

  bool _isChecked() {
    for (Bon bon in _bonuri) {
      if (bon.checked) {
        return true;
      }
    }
    return false;
  }

  void _resolve() {
    setState(() {
      _bonuri = _bonuri.where((bon) => !bon.checked).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 238, 120, 161),
          title: Text(widget.title),
        ),
        body: _bonuri.isEmpty
            ? Center(
                child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.pink[200],
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('Nu există bonuri active.',
                          textScaleFactor: 1.25),
                    ),
                  ],
                ),
              ))
            : Scrollbar(
                child: ListView(
                  restorationId: 'list_demo_list_view',
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    for (int index = 0; index < _bonuri.length; index++)
                      CheckboxListTile(
                        title: Text('Bon nr. ${_bonuri[index].nr}'),
                        value: _bonuri[index].checked,
                        onChanged: (bool? value) {
                          setState(() {
                            _bonuri[index].checked = !_bonuri[index].checked;
                          });
                        },
                        secondary: CircleAvatar(
                          backgroundColor: Colors.pink[200],
                          child: Text('${index + 1}'),
                        ),
                      )
                  ],
                ),
              ),
        floatingActionButton: _isChecked()
            ? FloatingActionButton.extended(
                icon: const Icon(Icons.done_all),
                label: const Text('Rezolvare'),
                onPressed: _resolve,
              )
            : FloatingActionButton.extended(
                icon: const Icon(Icons.post_add_rounded),
                backgroundColor: const Color.fromARGB(255, 226, 116, 153),
                foregroundColor: Colors.white,
                label: const Text('Creare bon'),
                onPressed: _incrementCounter,
              ));
  }
}
