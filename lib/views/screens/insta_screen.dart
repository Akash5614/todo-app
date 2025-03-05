import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/icon_button.dart';

class InstaPage extends StatefulWidget {
  const InstaPage({ super.key });
  State<InstaPage> createState() => _InstaScreen();
}

class _InstaScreen extends State<InstaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          CustomIconButton(
            icon: Icon(Icons.favorite_border_outlined), 
            method: () {}
          ),
          CustomIconButton(
            icon: Icon(Icons.send), 
            method: () {}
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(0.1),
        child: Column(
          children: [
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              height: 1, 
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                  children: [
                    CustomIconButton(icon: Icon(Icons.account_circle), method: () {}),
                    Text('Akash'),
                  ],
                  )
                ),
                CustomIconButton(icon: Icon(Icons.more_vert), method: () {})
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomIconButton(
                icon: Icon(Icons.home),
                method: () {},
              ),
              CustomIconButton(
                icon: Icon(Icons.search),
                method: () {},
              ),
              CustomIconButton(
                icon: Icon(Icons.add),
                method: () {},
              ),
              CustomIconButton(
                icon: Icon(Icons.favorite_border_outlined),
                method: () {},
              ),
              CustomIconButton(
                icon: Icon(Icons.person),
                method: () {},
              )
            ]
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home)),
      //     BottomNavigationBarItem(icon: Icon(Icons.search)),
      //     BottomNavigationBarItem(icon: Icon(Icons.plus_one_outlined)),
      //     BottomNavigationBarItem(icon: Icon(Icons.heat_pump_rounded)),
      //     BottomNavigationBarItem(icon: Icon(Icons.photo))
      //   ]
      // ),
    );
  }
}