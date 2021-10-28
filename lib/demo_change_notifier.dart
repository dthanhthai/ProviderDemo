import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  increment() {
    _count++;
    notifyListeners();
  }
}

class DemoChangeNotifierProvider extends StatelessWidget {
  const DemoChangeNotifierProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: TestConsumerWidget(),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counterProvider = Provider.of<Counter>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${counterProvider.count}",
            style: const TextStyle(fontSize: 40.0),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
              onPressed: () {
                counterProvider.increment();
              },
              child: const Text("Increment")),
        ],
      ),
    );
  }
}

class TestConsumerWidget extends StatelessWidget {
  const TestConsumerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(
        child: Text("dfdfdfd"),
        builder: (context, counter, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child ?? Container(),
                Text(
                  "${counter.count}",
                  style: const TextStyle(fontSize: 40.0),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      counter.increment();
                    },
                    child: const Text("Increment")),
              ],
            ),
          );
        });
  }
}
