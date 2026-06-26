import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Provider-branded sign-in button (Apple / Google) following each provider's
/// button guidelines, but sharing Orbit's rounded shape + zoom-tap press so it
/// sits consistently next to [PrimaryButton]. Full width, height 54.
class SocialButton extends StatefulWidget {
  const SocialButton({
    super.key,
    required this.label,
    required this.leading,
    required this.background,
    required this.foreground,
    this.border,
    this.onPressed,
  });

  /// Apple — black button, white Apple glyph.
  factory SocialButton.apple({
    Key? key,
    required String label,
    required bool isDark,
    VoidCallback? onPressed,
  }) {
    final bg = isDark ? Colors.white : Colors.black;
    final fg = isDark ? Colors.black : Colors.white;
    return SocialButton(
      key: key,
      label: label,
      leading: Icon(Icons.apple, size: 22, color: fg),
      background: bg,
      foreground: fg,
      onPressed: onPressed,
    );
  }

  /// Google — neutral surface, 4-colour "G" mark, bordered.
  factory SocialButton.google({
    Key? key,
    required String label,
    required bool isDark,
    required Color surface,
    required Color border,
    required Color foreground,
    VoidCallback? onPressed,
  }) {
    return SocialButton(
      key: key,
      label: label,
      leading: SvgPicture.asset(
        'assets/icons/google_g.svg',
        width: 20,
        height: 20,
      ),
      background: isDark ? surface : Colors.white,
      foreground: isDark ? foreground : const Color(0xFF3C4043),
      border: border,
      onPressed: onPressed,
    );
  }

  final String label;
  final Widget leading;
  final Color background;
  final Color foreground;
  final Color? border;
  final VoidCallback? onPressed;

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _down = false;

  bool get _enabled => widget.onPressed != null;

  void _set(bool v) {
    if (_down != v) setState(() => _down = v);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _enabled ? (_) => _set(true) : null,
      onTapUp: _enabled ? (_) => _set(false) : null,
      onTapCancel: _enabled ? () => _set(false) : null,
      onTap: _enabled ? widget.onPressed : null,
      child: AnimatedScale(
        scale: _down ? 0.93 : 1,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOut,
        child: Opacity(
          opacity: _enabled ? 1 : 0.5,
          child: Container(
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.background,
              borderRadius: BorderRadius.circular(16),
              border: widget.border != null
                  ? Border.all(color: widget.border!)
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.leading,
                const SizedBox(width: 10),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: widget.foreground,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
