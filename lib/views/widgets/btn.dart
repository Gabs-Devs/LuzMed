import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const AnimatedButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.transparent),
                borderRadius: BorderRadius.circular(100),
                boxShadow: _controller.value == 1
                    ? []
                    : [const BoxShadow(
                        color: Color.fromRGBO(94, 110, 165, 50),
                        spreadRadius: 4,
                      )],
              ),
              child: Center(
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _controller.value == 1 ? const Color(0xff1f387e) : const Color(0xff212121),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}