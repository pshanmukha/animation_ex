import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnimatedSearchBar(),
    );
  }
}

class AnimatedSearchBar extends StatefulWidget {
  const AnimatedSearchBar({Key? key}) : super(key: key);

  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController _textEditingController = TextEditingController();
  int toggle = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffF2F3F7),
        child: Center(
          child: Container(
            height: 100.0,
            width: 250.0,
            alignment: const Alignment(-1.0, 0.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 375),
              height: 48.0,
              width: (toggle == 0) ? 48.0 : 250.0,
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: -10.0,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 375),
                    top: 6,
                    right: 7,
                    curve: Curves.easeOut,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: (toggle == 0) ? 0 : 1.0,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffF2F3F7),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: AnimatedBuilder(
                          child: Icon(
                            Icons.mic,
                            size: 20.0,
                          ),
                          builder: (context, widget) {
                            return Transform.rotate(
                              angle: _controller.value * 2.0 * pi,
                              child: widget,
                            );
                          },
                          animation: _controller,
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 375),
                    left: (toggle == 0) ? 20 : 40,
                    top: 11.0,
                    curve: Curves.easeOut,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: (toggle == 0) ? 0.0 : 1.0,
                      child: Container(
                          height: 23.0,
                          width: 180.0,
                          child: TextField(
                            controller: _textEditingController,
                            cursorRadius: const Radius.circular(10.0),
                            cursorWidth: 2.0,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: 'Search...',
                                labelStyle: TextStyle(
                                  color: Color(0xff5B5B5B),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                )),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    bottom: 6,
                    right: 6,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Material(
                        borderRadius: BorderRadius.circular(30.0),
                        child: IconButton(
                          splashRadius: 19.0,
                          onPressed: () {
                            setState(() {
                              if (toggle == 0) {
                                toggle = 1;
                                _controller.forward();
                              } else {
                                toggle = 0;
                                _textEditingController.clear();
                                _controller.reverse();
                              }
                            });
                          },
                          icon: Icon(
                            Icons.search,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
