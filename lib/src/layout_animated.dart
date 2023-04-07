import 'package:flutter/material.dart';

class LayoutAnimated extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve switchInCurve;
  final Curve switchOutCurve;

  const LayoutAnimated({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
  });

  @override
  State<LayoutAnimated> createState() => _LayoutAnimatedState();
}

class _LayoutAnimatedState extends State<LayoutAnimated> {
  bool _show = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _show = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.duration,
      switchInCurve: widget.switchInCurve,
      switchOutCurve: widget.switchOutCurve,
      child: _show ? widget.child : SizedBox(key: widget.key),
    );
  }
}
