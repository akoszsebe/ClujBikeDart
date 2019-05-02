import 'package:flutter/material.dart';
import 'package:clujbikedart/utils/colors.dart';

class FancyFab extends StatefulWidget {
  final void Function(bool) listener;

  const FancyFab(this.listener);

  @override
  _FancyFabState createState() => _FancyFabState(listener);

  void clear() {
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
  Animation<double> transfromation;
  Animation<double> rotation;
  Animation<double> animation;
  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    transfromation =
        new Tween(begin: 0.0, end: 24.0).animate(_animationController);
    rotation = new Tween(begin: 0.0, end: 1.6).animate(_animationController);
    _animationController.addStatusListener((status) {
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
    _animationController.drive(CurveTween(curve: Curves.easeIn));
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: FloatingActionButton(
          elevation: 1.0,
          backgroundColor: ColorUtils.colorPrimary,
          onPressed: animate,
          child: AnimatedBuilder(
            animation: _animationController,
            child: fabIcon,
            builder: (context, _widget) {
              return Transform.rotate(angle: rotation.value, child: _widget);
            },
          ),
        ),
        builder: (context, _widget) {
          return Transform.translate(
              offset: Offset(0, -transfromation.value), child: _widget);
        });
  }
}
