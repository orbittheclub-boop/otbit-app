import 'package:flutter/widgets.dart';

/// Wraps any tappable child (buttons, cards) to add a tactile "zoom" press —
/// it scales down while a pointer is held and springs back on release.
///
/// Uses a passive [Listener] (raw pointer events) rather than a GestureDetector
/// so it never competes in the gesture arena with the child's own tap handler —
/// the wrapped button's onPressed keeps working normally.
class ZoomTap extends StatefulWidget {
  const ZoomTap({super.key, required this.child, this.scale = 0.94});

  final Widget child;
  final double scale;

  @override
  State<ZoomTap> createState() => _ZoomTapState();
}

class _ZoomTapState extends State<ZoomTap> {
  bool _down = false;

  void _set(bool v) {
    if (_down != v) setState(() => _down = v);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _set(true),
      onPointerUp: (_) => _set(false),
      onPointerCancel: (_) => _set(false),
      child: AnimatedScale(
        scale: _down ? widget.scale : 1,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
