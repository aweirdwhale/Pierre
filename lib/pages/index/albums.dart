import 'package:flutter/cupertino.dart';

class Albums extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Albums'),
        ),
        child: Center(child: Text('Albums')));
  }
}
