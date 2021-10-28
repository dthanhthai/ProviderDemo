import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter {
  final ValueNotifier<int> valueNotifier = ValueNotifier(0);

  void increment() {
    valueNotifier.value++;
  }
}

class DemoValueListenableProvider extends StatelessWidget {
  const DemoValueListenableProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => Counter(),
      child: Consumer<Counter>(
        builder: (context, counter, _) {
          return ValueListenableBuilder<int>(
            valueListenable: counter.valueNotifier,
            builder: (context, value, _) {
              return Provider<int>.value(
                value: value,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DemoConsumerWidget(),
                      IncrementButtonWidget(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DemoConsumerWidget extends StatelessWidget {
  const DemoConsumerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<int>(builder: (context, value, _) {
      return Text(
        value.toString(),
        style: const TextStyle(fontSize: 20),
      );
    });
  }
}

class IncrementButtonWidget extends StatelessWidget {
  const IncrementButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          final counter = Provider.of<Counter>(context, listen: false);
          counter.increment();
        },
        child: const Text(
          'Increment',
          style: TextStyle(fontSize: 20),
        ));
  }
}
