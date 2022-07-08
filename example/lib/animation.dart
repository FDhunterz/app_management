import 'package:flutter/material.dart';

class CheckIcon extends StatefulWidget {
  final bool status;
  const CheckIcon({Key? key, this.status = false}) : super(key: key);

  @override
  State<CheckIcon> createState() => _CheckIcon();
}

class _CheckIcon extends State<CheckIcon> with TickerProviderStateMixin {
  final tween = Tween(begin: 0.0, end: 1.0);
  late AnimationController controller;

  validator() {
    if (widget.status) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800), reverseDuration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    validator();
    return AnimateScale(
      animation: tween.animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut)),
      tween: tween,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: const Center(
          child: Icon(
            Icons.check,
            size: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ScaleAnimation extends StatefulWidget {
  final Widget child;
  final Duration? delay;
  const ScaleAnimation({Key? key, required this.child, this.delay}) : super(key: key);

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation> with TickerProviderStateMixin {
  final tween = Tween(begin: 0.0, end: 1.0);
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800), reverseDuration: const Duration(milliseconds: 600));
    Future.delayed(widget.delay ?? Duration.zero, () {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimateScale(
      animation: tween.animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut)),
      tween: tween,
      child: widget.child,
    );
  }
}

class AnimateScale extends AnimatedWidget {
  const AnimateScale({Key? key, required Animation<double> animation, required this.child, required this.tween}) : super(key: key, listenable: animation);
  final Tween<double> tween;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.scale(
      scale: tween.evaluate(animation),
      child: child,
    );
  }
}
