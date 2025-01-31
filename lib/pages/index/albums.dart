import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Albums extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Albums'),
        ),
        child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            children: List<Widget>.generate(15, (int i) {
              return Builder(builder: (BuildContext context) {
                // fait la grille des albums
                return Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ));
              });
            })));
  }

  Widget albumbutton() {
    return IconButton(
      icon: const Icon(Icons.volume_up),
      tooltip: 'Increase volume by 10',
      onPressed: () {
        print("miaou");
      },
    );
  }
}
