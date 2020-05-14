import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app-state.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo List",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  initState() {
    super.initState();
    context.read<AppState>().load();
    print("\n-- InitState --\n");
  }

  @override
  Widget build(BuildContext context) {
    final newTaskCtrl = TextEditingController();
    final appstate = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            labelText: "Nova Tarefa",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: appstate.items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = appstate.items[index];

          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value) {
                appstate.checkboxValue(value, index);
              },
            ),
            key: Key(item.title),
            background: Container(
              color: Colors.red.withOpacity(0.35),
            ),
            onDismissed: (direction) {
              appstate.remove(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appstate.add(newTaskCtrl);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
