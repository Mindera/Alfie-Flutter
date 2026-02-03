/// A utility class defining the design system's spacing scale.
///
/// This system is built on a base unit of [_unit] pixels, ensuring
/// visual consistency across the application layout.
class Spacing {
  const Spacing._();

  /// The base multiplier for the spacing scale.
  static const double _unit = 8.0;

  /// 2px
  static const double extraExtraExtraSmall = _unit * 0.25;

  /// 4px
  static const double extraExtraSmall = _unit * 0.5;

  /// 8px
  static const double extraSmall = _unit * 1;

  /// 16px
  static const double small = _unit * 2;

  /// 24px
  static const double medium = _unit * 3;

  /// 32px
  static const double large = _unit * 4;

  /// 40px
  static const double extraLarge = _unit * 5;

  /// 48px
  static const double extraExtraLarge = _unit * 6;

  /// 56px
  static const double extraExtraExtraLarge = _unit * 7;
}
