import 'dart:math';

import 'package:flutter/material.dart';

/// This enum represents all possible color combinations a `AdwAvatar` widget
/// can feature. They're extracted directly from the GTK `libadwaita` implementation.
enum AdwAvatarColors {
  blue,
  cyan,
  green,
  lime,
  yellow,
  gold,
  orange,
  raspberry,
  magenta,
  purple,
  violet,
  beige,
  brown,
  gray
}

/// Represents a set of background gradient colors and a foreground color for the
/// `AdwAvatar` widget.
class AdwAvatarColor {
  final Color foregroundColor;
  final List<Color> backgroundGradient;

  const AdwAvatarColor({
    required this.foregroundColor,
    required this.backgroundGradient,
  });
}

/// Color palette for both the foreground and background of a `AdwAvatar` widget.
class AdwAvatarColorPalette {
  static const _palette = {
    AdwAvatarColors.blue: AdwAvatarColor(
      foregroundColor: Color(0xFFcfe1f5),
      backgroundGradient: [
        Color(0xFF83b6ec),
        Color(0xFF337fdc),
      ],
    ),
    AdwAvatarColors.cyan: AdwAvatarColor(
      foregroundColor: Color(0xFFcaeaf2),
      backgroundGradient: [
        Color(0xFF7ad9f1),
        Color(0xFF0f9ac8),
      ],
    ),
    AdwAvatarColors.green: AdwAvatarColor(
      foregroundColor: Color(0xFFcef8d8),
      backgroundGradient: [
        Color(0xFF8de6b1),
        Color(0xFF29ae74),
      ],
    ),
    AdwAvatarColors.lime: AdwAvatarColor(
      foregroundColor: Color(0xFFe6f9d7),
      backgroundGradient: [
        Color(0xFFb5e98a),
        Color(0xFF6ab85b),
      ],
    ),
    AdwAvatarColors.yellow: AdwAvatarColor(
      foregroundColor: Color(0xFFf9f4e1),
      backgroundGradient: [
        Color(0xFFf8e359),
        Color(0xFFd29d09),
      ],
    ),
    AdwAvatarColors.gold: AdwAvatarColor(
      foregroundColor: Color(0xFFffead1),
      backgroundGradient: [
        Color(0xFFffcb62),
        Color(0xFFd68400),
      ],
    ),
    AdwAvatarColors.orange: AdwAvatarColor(
      foregroundColor: Color(0xFFffe5c5),
      backgroundGradient: [
        Color(0xFFffa95a),
        Color(0xFFed5b00),
      ],
    ),
    AdwAvatarColors.raspberry: AdwAvatarColor(
      foregroundColor: Color(0xFFf8d2ce),
      backgroundGradient: [
        Color(0xFFf78773),
        Color(0xFFe62d42),
      ],
    ),
    AdwAvatarColors.magenta: AdwAvatarColor(
      foregroundColor: Color(0xFFfac7de),
      backgroundGradient: [
        Color(0xFFe973ab),
        Color(0xFFe33b6a),
      ],
    ),
    AdwAvatarColors.purple: AdwAvatarColor(
      foregroundColor: Color(0xFFe7c2e8),
      backgroundGradient: [
        Color(0xFFcb78d4),
        Color(0xFF9945b5),
      ],
    ),
    AdwAvatarColors.violet: AdwAvatarColor(
      foregroundColor: Color(0xFFd5d2f5),
      backgroundGradient: [
        Color(0xFF9e91e8),
        Color(0xFF7a59ca),
      ],
    ),
    AdwAvatarColors.beige: AdwAvatarColor(
      foregroundColor: Color(0xFFf2eade),
      backgroundGradient: [
        Color(0xFFe3cf9c),
        Color(0xFFb08952),
      ],
    ),
    AdwAvatarColors.brown: AdwAvatarColor(
      foregroundColor: Color(0xFFe5d6ca),
      backgroundGradient: [
        Color(0xFFbe916d),
        Color(0xFF785336),
      ],
    ),
    AdwAvatarColors.gray: AdwAvatarColor(
      foregroundColor: Color(0xFFd8d7d3),
      backgroundGradient: [
        Color(0xFFc0bfbc),
        Color(0xFF6e6d71),
      ],
    ),
  };

  /// Returns a set of values depending on the `color` variable.
  ///
  /// If the variable is `null`, it'll then return a random set of colors.
  static AdwAvatarColor getColor(AdwAvatarColors? color) {
    if (color != null) return _palette[color]!;

    final randomColor =
        AdwAvatarColors.values[Random().nextInt(AdwAvatarColors.values.length)];

    return _palette[randomColor]!;
  }
}

/// `AdwAvatar` is a widget that shows a round avatar. Usually, an icon or some
/// letters. Automatic theme will be applied in those cases to make them look
/// cohesive inside the avatar.
class AdwAvatar extends StatelessWidget {
  static const defaultAvatarSize = 40.0;

  const AdwAvatar({
    Key? key,
    required this.child,
    this.size = defaultAvatarSize,
    this.backgroundColor,
    this.backgroundImage,
  }) : super(key: key);

  /// Constructor that allows the pass of a `String` object in order to render
  /// the first letters of the first two words inside the widget.
  ///
  /// The `String` object should not be empty.
  factory AdwAvatar.text({
    Key? key,
    required String text,
    double size = defaultAvatarSize,
    AdwAvatarColors? backgroundColor,
    ImageProvider? backgroundImage,
  }) {
    assert(text.isNotEmpty, 'Text should not be empty');

    // 1. Trim the string from leading and trailing whitespace.
    // 2. Separate the string via whitespaces (can be multiple spaces between words).
    // 3. Select a max of 2 words and store it in a list.
    final words = text.trim().split(RegExp(r' +')).take(2);

    // Pick the first letters of the words stored and join them in a string.
    final letters = words.fold(
      '',
      (value, element) => '$value${element[0]}',
    );

    return AdwAvatar(
      key: key,
      child: Text(letters.toUpperCase()),
      size: size,
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
    );
  }

  /// Main view that will be rendered at the center of the avatar.
  /// It will feature a default icon size of `size / 2`.
  final Widget child;

  /// Size of the widget. Defaults to `40`.
  final double size;

  /// Main color that will be used to decorate the widget.
  ///
  /// If `null`, a random set of colors will be picked.
  final AdwAvatarColors? backgroundColor;

  /// Image that will be rendered at the background of the widget.
  ///
  /// No background color or child will be visible is an image is provided.
  final ImageProvider? backgroundImage;

  @override
  Widget build(BuildContext context) {
    final colorPalette = AdwAvatarColorPalette.getColor(backgroundColor);
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: backgroundImage != null
              ? DecorationImage(
                  image: backgroundImage!,
                  fit: BoxFit.cover,
                )
              : null,
          gradient: LinearGradient(
            colors: colorPalette.backgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: backgroundImage == null
            ? IconTheme.merge(
                data: IconThemeData(
                  color: colorPalette.foregroundColor,
                  size: size / 2,
                ),
                child: DefaultTextStyle.merge(
                  style: TextStyle(
                    color: colorPalette.foregroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                  child: Center(child: child),
                ),
              )
            : null,
      ),
    );
  }
}
