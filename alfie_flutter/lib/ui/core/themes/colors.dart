import 'package:flutter/material.dart';

enum AppColors {
  /// Neutrals: a grey scale that is used for the majority of UI elements.
  neutral(color: Color(0xFFFFFFFF)),
  neutral100(color: Color(0xFFF7F7F7)),
  neutral200(color: Color(0xFFE9E9E9)),
  neutral300(color: Color(0xFFCDCDCD)),
  neutral400(color: Color(0xFFA5A5A5)),
  neutral500(color: Color(0xFF767676)),
  neutral600(color: Color(0xFF4A4A4A)),
  neutral700(color: Color(0xFF2B2B2B)),
  neutral800(color: Color(0xFF111111)),
  neutral900(color: Color(0xFF000000)),

  /// Semantic/Functional: to communicate error or success states.

  /// Error colors
  error100(color: Color(0xFFFEF2F1)),
  error200(color: Color(0xFFF9DEDC)),
  error300(color: Color(0xFFE99FA2)),
  error400(color: Color(0xFFEB676D)),
  error500(color: Color(0xFFE03E40)),
  error600(color: Color(0xFFB22525)),
  error700(color: Color(0xFF952525)),
  error800(color: Color(0xFF770500)),

  /// Success colors
  success100(color: Color(0xFFEDF7E7)),
  success200(color: Color(0xFFD4EAC3)),
  success300(color: Color(0xFFA3CF82)),
  success400(color: Color(0xFF84C553)),
  success500(color: Color(0xFF60A62B)),
  success600(color: Color(0xFF48911F)),
  success700(color: Color(0xFF368316)),
  success800(color: Color(0xFF006201));

  final Color color;

  const AppColors({required this.color});
}
