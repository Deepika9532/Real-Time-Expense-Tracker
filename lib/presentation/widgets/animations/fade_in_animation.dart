import 'package:flutter/material.dart';

class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double beginOpacity;
  final double endOpacity;
  final Offset offset;
  final bool animateOnMount;
  final VoidCallback? onAnimationComplete;

  const FadeInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.beginOpacity = 0,
    this.endOpacity = 1,
    this.offset = const Offset(0, 20),
    this.animateOnMount = true,
    this.onAnimationComplete,
  });

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);

    _opacityAnimation = Tween<double>(
      begin: widget.beginOpacity,
      end: widget.endOpacity,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _offsetAnimation = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    if (widget.animateOnMount) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward().then((_) {
            widget.onAnimationComplete?.call();
          });
        }
      });
    }
  }

  void play() {
    _controller.forward();
  }

  void reverse() {
    _controller.reverse();
  }

  void reset() {
    _controller.reset();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: _offsetAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class FadeInListAnimation extends StatelessWidget {
  final List<Widget> children;
  final Duration duration;
  final Duration delayBetweenItems;
  final Curve curve;
  final double beginOpacity;
  final double endOpacity;
  final Offset offset;

  const FadeInListAnimation({
    super.key,
    required this.children,
    this.duration = const Duration(milliseconds: 300),
    this.delayBetweenItems = const Duration(milliseconds: 100),
    this.curve = Curves.easeOut,
    this.beginOpacity = 0,
    this.endOpacity = 1,
    this.offset = const Offset(0, 20),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < children.length; i++)
          FadeInAnimation(
            duration: duration,
            delay: Duration(milliseconds: i * delayBetweenItems.inMilliseconds),
            curve: curve,
            beginOpacity: beginOpacity,
            endOpacity: endOpacity,
            offset: offset,
            child: children[i],
          ),
      ],
    );
  }
}

class FadeInWidget extends StatefulWidget {
  final Widget child;
  final bool show;
  final Duration duration;
  final Curve curve;

  const FadeInWidget({
    super.key,
    required this.child,
    required this.show,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
  }

  @override
  void didUpdateWidget(FadeInWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: _controller, curve: widget.curve),
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: _controller, curve: widget.curve),
        child: widget.child,
      ),
    );
  }
}
