import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CounterProvider extends ChangeNotifier {
  int _count1 = 0;
  int _count2 = 0;
  int _count3 = 0;

  int get count1 => _count1;

  int get count2 => _count2;

  incrementCounter1() {
    _count1++;
    notifyListeners();
  }

  incrementCounter2() {
    _count2--;
    notifyListeners();
  }
}

class DemoSelector extends StatelessWidget {
  const DemoSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      builder: (BuildContext context, _) {
        final counterProvider =
            Provider.of<CounterProvider>(context, listen: false);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /////////////CONSUMER///////////////
              // Consumer<CounterProvider>(
              //   builder: (context, data, child) {
              //     print('Update UI Consumer 1');
              //     return Container(
              //       height: 40,
              //       color: Colors.red,
              //       child: Center(child: Text('Consumer1: ${data.count1}')),
              //     );
              //   },
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              // Consumer<CounterProvider>(
              //   builder: (context, data, child) {
              //     print('Update UI Consumer 2');
              //     return Container(
              //       height: 40,
              //       color: Colors.blue,
              //       child:
              //           Center(child: Text('Consumer2: ${data.count2}')),
              //     );
              //   },
              // ),
              /////////////SELECTOR///////////////
              Selector<CounterProvider, int>(
                builder: (context, data, child) {
                  print('Update UI Selector 1');
                  return Container(
                    height: 40,
                    color: Colors.red,
                    child: Center(child: Text('Selector 1: $data')),
                  );
                },
                selector: (buildContext, counterProvider) {
                  print('Check Selector 1');
                  return counterProvider.count1;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Selector<CounterProvider, int>(
                builder: (context, data, child) {
                  print('Update UI Selector 2');
                  return Container(
                    height: 40,
                    color: Colors.blue,
                    child: Center(child: Text('Selector 2: $data')),
                  );
                },
                selector: (buildContext, counterProvider) {
                  print('Check Selector 2');
                  return counterProvider.count2;
                },
              ),
              /////////////SELECTOR - TUPLE///////////////
              // Selector<CounterProvider, Tuple2<int, int>>(
              //   builder: (context, data, child) {
              //     print('Update UI Selector 2');
              //     return Container(
              //       height: 40,
              //       color: Colors.blue,
              //       child: Center(child: Text('Selector 2: $data')),
              //     );
              //   },
              //   selector: (buildContext, counterProvider) {
              //     print('Check Selector 1 & 2');
              //     return Tuple2(counterProvider._count1, counterProvider._count2);
              //   },
              // ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => counterProvider.incrementCounter1(),
                    child: const Text('Button 1'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: () => counterProvider.incrementCounter2(),
                    child: const Text('Button 2'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
