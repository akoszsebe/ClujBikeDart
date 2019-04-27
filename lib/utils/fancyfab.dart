import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/colors.dart';

class FancyFab extends StatefulWidget {
  final void Function(bool) listener;

  const FancyFab(this.listener);

  @override
  _FancyFabState createState() => _FancyFabState(listener);

  void clear(){
    createState().close();
  }
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Icon fabIcon = Icon(Icons.search, color: Colors.white);
  final void Function(bool) listener;

  _FancyFabState(this.listener);

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addStatusListener((status) {
            setState(() {
              if (isOpened) {
                if (status == AnimationStatus.completed) {
                  fabIcon = Icon(Icons.close, color: Colors.white);
                }
              } else {
                if (status == AnimationStatus.dismissed) {
                  fabIcon = Icon(Icons.search, color: Colors.white);
                }
              }
            });
          });

    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
    listener(isOpened);
  }

  void close() {
    _animationController.reverse();
    isOpened = !isOpened;
    listener(isOpened);
  }

  Widget toggle() {
    return Transform.translate(
        offset: Offset(0, -_animationController.value * 20),
        child: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: ColorUtils.colorPrimary,
          onPressed: animate,
          child: AnimatedBuilder(
            animation: _animationController,
            child: fabIcon,
            builder: (context, _widget) {
              return Transform.rotate(
                angle: _animationController.value * 1.6,
                child: _widget,
              );
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}
