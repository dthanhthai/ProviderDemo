import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CounterApi {
  int _count = 100;

  int get count => _count;
}

class CounterService {
  CounterApi _api;

  CounterService({required CounterApi api}) : _api = api;

  CounterApi get api => _api;
}

class CounterModel with ChangeNotifier {
  CounterService _counterService;

  // CounterModel();

  void update(CounterService counterService) {
    _counterService = counterService;
    notifyListeners();
  }

  CounterModel({required CounterService counterService})
      : _counterService = counterService;

  CounterService get counterService => _counterService;
}

class DemoProxyProvider extends StatelessWidget {
  const DemoProxyProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CounterApi()),
        ProxyProvider<CounterApi, CounterService>(
            update: (context, counterApi, _) =>
                CounterService(api: counterApi)),
      ],
      child: TestWidget(),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterModel>(
      create: (context) {
        return CounterModel(counterService: context.read<CounterService>());
      },
      child: Consumer<CounterModel>(
        builder: (context, model, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.counterService.api.count.toString(),
                  style: const TextStyle(fontSize: 40),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class TestProxyWidget extends StatelessWidget {
  const TestProxyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CounterService, CounterModel>(
      create: (context) =>
          CounterModel(counterService: context.read<CounterService>()),
      update: (context, counterService, counterModel) =>
          counterModel!..update(counterService),
      child: Consumer<CounterModel>(
        builder: (context, model, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.counterService.api.count.toString(),
                  style: const TextStyle(fontSize: 40),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
