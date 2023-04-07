import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class ShareValue<T> {
  final AnimationController controller;
  final T initialValue;
  late Animation<T> _animation;

  ShareValue({
    required this.controller,
    required this.initialValue,
  }) {
    _animation =
        Tween<T>(begin: initialValue, end: initialValue).animate(controller);
  }

  T get value => _animation.value;

  set value(value) {
    _animation = controller.drive(Tween<T>(begin: value, end: value));
    controller.value = 0;
  }

  Animation<T> get animation => _animation;

  TickerFuture timingTo({
    required T target,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.linear,
    bool repeat = false,
    bool reverse = false,
  }) {
    if (repeat) {
      return controller.repeat(reverse: reverse, period: duration);
    }

    _animation =
        controller.drive(Tween<T>(begin: _animation.value, end: target));
    controller.value = 0;

    return controller.animateTo(1, duration: duration, curve: curve);
  }

  TickerFuture springTo({
    required T target,
    double stiffness = 1,
    double damping = 1,
    double mass = 30,
    double velocity = 0,
    Tolerance tolerance = Tolerance.defaultTolerance,
  }) {
    _animation =
        controller.drive(Tween<T>(begin: _animation.value, end: target));
    return controller.animateWith(
      SpringSimulation(
        SpringDescription(
          mass: mass,
          stiffness: stiffness,
          damping: damping,
        ),
        0,
        1,
        velocity,
        tolerance: tolerance,
      ),
    );
  }
}

class ShareColor {
  final AnimationController controller;
  final Color initialValue;
  late Animation _animation;

  ShareColor({
    required this.controller,
    required this.initialValue,
  }) {
    _animation =
        ColorTween(begin: initialValue, end: initialValue).animate(controller);
  }

  Color get value => _animation.value;
  Animation get animation => _animation;

  void timingTo({
    required Color target,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.linear,
    bool repeat = false,
    bool reverse = false,
  }) {
    _animation =
        controller.drive(ColorTween(begin: _animation.value, end: target));

    void execute() {
      controller
          .animateTo(controller.value == 0 ? 1 : 0,
              duration: duration, curve: curve)
          .whenComplete(() {
        if (repeat) {
          execute();
        }
      });
    }

    execute();

    // controller.value = 0;
    // controller.animateTo(1, duration: duration, curve: curve).whenComplete(() {
    //   if (repeat) {
    //     timingTo(
    //       target: reverse ? initialValue : target,
    //       duration: duration,
    //       curve: curve,
    //       repeat: repeat,
    //       reverse: !reverse,
    //     );
    //   }
    // });
  }

  TickerFuture springTo({
    required Color target,
    double stiffness = 1,
    double damping = 1,
    double mass = 30,
    double velocity = 0,
    Tolerance tolerance = Tolerance.defaultTolerance,
  }) {
    _animation =
        controller.drive(ColorTween(begin: _animation.value, end: target));
    return controller.animateWith(
      SpringSimulation(
        SpringDescription(
          mass: mass,
          stiffness: stiffness,
          damping: damping,
        ),
        0,
        1,
        velocity,
        tolerance: tolerance,
      ),
    );
  }
}
