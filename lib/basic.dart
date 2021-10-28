import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User {
  String _name;

  User(this._name);

  String get name => _name;

  set name(newName) => _name = newName;
}

class BasicProvoider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = User("Thai Doan");
    // return Provider<User>.value(
    //   value: user,
    //   child: BasicWidget(),
    // );
    return Provider(
      create: (context) {
        return user;
      },
      child: BasicWidget(),
    );
  }
}

class BasicWidget extends StatelessWidget {
  const BasicWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DemoConsumerWidget(),
          DemoWithoutConsumerWidget(),
        ],
      ),
    );
  }
}

class DemoConsumerWidget extends StatelessWidget {
  const DemoConsumerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext parContext) {
    return Consumer<User>(builder: (curContext, user, child) {
      return Text(user.name);
    });
  }
}

class DemoWithoutConsumerWidget extends StatelessWidget {
  const DemoWithoutConsumerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<User>(context, listen: false);
    // context.read<User>();
    // context.watch<User>();

    return Text(userProvider._name);
  }
}
