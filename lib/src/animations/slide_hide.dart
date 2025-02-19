import 'package:flutter/widgets.dart';

class SlideHide extends StatefulWidget {
  final Widget child;
  final bool isHidden;
  final double width;

  const SlideHide({
    Key? key,
    required this.child,
    required this.isHidden,
    required this.width,
  }) : super(key: key);

  @override
  _SlideHideState createState() => _SlideHideState();
}

class _SlideHideState extends State<SlideHide>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> widthAnimation;
  late GlobalKey key;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    widthAnimation = Tween(begin: widget.width, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    animate();
    super.initState();
  }

  void animate() {
    if (widget.isHidden) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    animate();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: 1,
          child: SizedBox(
            height: double.infinity,
            child: widget.child,
            width: widthAnimation.value,
          ),
        );
      },
    );
  }
}
