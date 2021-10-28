import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter1 with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  increment() {
    _count++;
    notifyListeners();
  }
}

class Counter2 with ChangeNotifier {
  int _count = 10;

  int get count => _count;

  increment() {
    _count++;
    notifyListeners();
  }
}

class User {
  String _name;

  User(this._name);

  String get name => _name;

  set name(newName) => _name = newName;
}

class DemoMultipleProvider extends StatelessWidget {
  const DemoMultipleProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Counter1()),
        ChangeNotifierProvider(create: (context) => Counter2()),
        Provider(create: (context) => User('Thai Doan'),),
      ],
      child: TestWidget(),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counter1 = Provider.of<Counter1>(context);
    var counter2 = Provider.of<Counter2>(context);
    var user = Provider.of<User>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "User : ${user.name}",
            style: const TextStyle(fontSize: 20.0),
          ),
          Text(
            "Count1 : ${counter1.count}",
            style: const TextStyle(fontSize: 40.0),
          ),
          Text(
            "Count2 : ${counter2.count}",
            style: const TextStyle(fontSize: 40.0),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
              onPressed: () {
                counter1.increment();
                counter2.increment();
              },
              child: const Text("Increment 1 & 2")),
        ],
      ),
    );
  }
}
