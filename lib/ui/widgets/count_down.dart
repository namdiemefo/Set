import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:street_set/ui/home.dart';

class CountDown extends StatefulWidget {
  int time;
  CountDown({this.time});

  @override
  _CountDownState createState() => _CountDownState(time);
}

class _CountDownState extends State<CountDown> with TickerProviderStateMixin {
  AnimationController _animationController;
  int time;

  _CountDownState(this.time);

  String get timerString {
    Duration duration =
        _animationController.duration * _animationController.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(minutes: time));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white10,
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    height: _animationController.value *
                        MediaQuery.of(context).size.height,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimePainter(
                                    animation: _animationController,
                                    backgroundColor: Colors.white,
                                    color: themeData.indicatorColor,
                                  )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Set!",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        timerString,
                                        style: TextStyle(
                                            fontSize: 112.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton.extended(
                                    onPressed: () {
                                      if (_animationController.isAnimating)
                                        _animationController.stop();
                                      else {
                                        _animationController.reverse(
                                            from: _animationController.value ==
                                                    0.0
                                                ? 1.0
                                                : _animationController.value);
                                      }
                                    },
                                    icon: Icon(_animationController.isAnimating
                                        ? Icons.pause
                                        : Icons.play_arrow),
                                    label: Text(_animationController.isAnimating
                                        ? "Pause"
                                        : "Play")),

                                SizedBox(
                                  width: 20,
                                ),

                                FloatingActionButton.extended(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    label: Text('End Match')
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CustomTimePainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor, color;

  CustomTimePainter({this.animation, this.backgroundColor, this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomTimePainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
