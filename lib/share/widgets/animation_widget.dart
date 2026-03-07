import 'package:flutter/material.dart';

class AnimatedTapWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const AnimatedTapWrapper({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedTapWrapperState createState() => _AnimatedTapWrapperState();
}

class _AnimatedTapWrapperState extends State<AnimatedTapWrapper> {
  bool _pressed = false;

  void _setPressed(bool val) {
    setState(() => _pressed = val);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(_pressed ? 0.95 : 1.0),
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}
