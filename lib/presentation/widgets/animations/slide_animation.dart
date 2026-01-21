import 'package:flutter/material.dart';

enum SlideDirection { fromLeft, fromRight, fromTop, fromBottom }

class SlideAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final SlideDirection direction;
  final double distance;
  final bool animateOnMount;
  final VoidCallback? onAnimationComplete;

  const SlideAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.direction = SlideDirection.fromBottom,
    this.distance = 50,
    this.animateOnMount = true,
    this.onAnimationComplete,
  });

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);

    Offset beginOffset;
    switch (widget.direction) {
      case SlideDirection.fromLeft:
        beginOffset = Offset(-widget.distance, 0);
        break;
      case SlideDirection.fromRight:
        beginOffset = Offset(widget.distance, 0);
        break;
      case SlideDirection.fromTop:
        beginOffset = Offset(0, -widget.distance);
        break;
      case SlideDirection.fromBottom:
        beginOffset = Offset(0, widget.distance);
        break;
    }

    _offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
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

class StaggeredSlideAnimation extends StatelessWidget {
  final List<Widget> children;
  final SlideDirection direction;
  final Duration itemDuration;
  final Duration delayBetweenItems;
  final Curve curve;
  final double distance;

  const StaggeredSlideAnimation({
    super.key,
    required this.children,
    this.direction = SlideDirection.fromBottom,
    this.itemDuration = const Duration(milliseconds: 300),
    this.delayBetweenItems = const Duration(milliseconds: 100),
    this.curve = Curves.easeOut,
    this.distance = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < children.length; i++)
          SlideAnimation(
            duration: itemDuration,
            delay: Duration(milliseconds: i * delayBetweenItems.inMilliseconds),
            curve: curve,
            direction: direction,
            distance: distance,
            child: children[i],
          ),
      ],
    );
  }
}

class SlideTransitionWidget extends StatefulWidget {
  final Widget child;
  final bool show;
  final SlideDirection direction;
  final Duration duration;
  final Curve curve;

  const SlideTransitionWidget({
    super.key,
    required this.child,
    required this.show,
    this.direction = SlideDirection.fromBottom,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  State<SlideTransitionWidget> createState() => _SlideTransitionWidgetState();
}

class _SlideTransitionWidgetState extends State<SlideTransitionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    final beginOffset = _getBeginOffset();
    _animation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    if (widget.show) {
      _controller.forward();
    }
  }

  Offset _getBeginOffset() {
    switch (widget.direction) {
      case SlideDirection.fromLeft:
        return const Offset(-1, 0);
      case SlideDirection.fromRight:
        return const Offset(1, 0);
      case SlideDirection.fromTop:
        return const Offset(0, -1);
      case SlideDirection.fromBottom:
        return const Offset(0, 1);
    }
  }

  @override
  void didUpdateWidget(SlideTransitionWidget oldWidget) {
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
    return SlideTransition(position: _animation, child: widget.child);
  }
}
