import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // final dragController = DragController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DraggableWidget(
            bottomMargin: 40,
            topMargin: 80,
            // initialVisibility: true,
            horizontalSpace: 0,
            shadowBorderRadius: 50,
            child: SvgPicture.asset(
              'assets/icon/ps_now.svg',
              width: 150,
              height: 150,
            ),
            initialPosition: AnchoringPosition.center,
            // dragController: dragController,
          )
        ],
      ),
/*      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
*//*
                TextButton(
                  onPressed: () {
                    dragController.showWidget();
                  },
                  child: Text("Show"),
                ),
                TextButton(
                  onPressed: () {
                    dragController.hideWidget();
                  },
                  child: Text("Hide"),
                ),
                TextButton(
                  onPressed: () {
                    dragController.jumpTo(AnchoringPosition.topRight);
                  },
                  child: Text("Move to Top Right"),
                ),
                TextButton(
                  onPressed: () {
                    dragController.jumpTo(AnchoringPosition.topLeft);
                  },
                  child: Text("Move to Top Left"),
                ),
                TextButton(
                  onPressed: () {
                    dragController.jumpTo(AnchoringPosition.bottomRight);
                  },
                  child: Text("Move to Bottom Right"),
                ),
                TextButton(
                  onPressed: () {
                    dragController.jumpTo(AnchoringPosition.bottomLeft);
                  },
                  child: Text("Move to Bottom Left"),
                ),
                TextButton(
                  onPressed: () {
                    dragController.jumpTo(AnchoringPosition.leftCenter);
                  },
                  child: Text("Move to Left Center"),
                ),
                TextButton(
                  onPressed: () {
                    dragController.jumpTo(AnchoringPosition.rightCenter);
                  },
                  child: Text("Move to Right Center"),
                ),
                TextButton(
                  onPressed: () {
                    dragController.jumpTo(AnchoringPosition.topCenter);
                  },
                  child: Text("Move to Top Center"),
                ),
                TextButton(
                  onPressed: () {
                    dragController.jumpTo(AnchoringPosition.bottomCenter);
                  },
                  child: Text("Move to Bottom Center"),
                ),
                TextButton(
                  onPressed: () {
                    dragController.jumpTo(AnchoringPosition.center);
                  },
                  child: Text("Move to Center"),
                ),
*//*
              ],
            ),
          ),
          Container(
            height: 80,
            width: double.infinity,
            color: Colors.green,
          ),
          DraggableWidget(
            bottomMargin: 40,
            topMargin: 80,
            // initialVisibility: true,
            horizontalSpace: 0,
            shadowBorderRadius: 50,
            child: SvgPicture.asset(
              'assets/icon/ps_now.svg',
              width: 150,
              height: 150,
              ),
            initialPosition: AnchoringPosition.center,
            dragController: dragController,
          )
        ],
      ),*/
    );
  }
}