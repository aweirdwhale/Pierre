import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pierre/pages/widgets/grid.dart';

import 'widgets/header.dart';

class Photos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Pierre.",
              style: theme.textTheme.displayMedium!
                  .copyWith(color: theme.colorScheme.onPrimary)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(padding: const EdgeInsets.all(2.0), child: Grid()));
  }
}
