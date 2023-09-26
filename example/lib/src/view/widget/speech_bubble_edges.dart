import 'package:flutter/painting.dart';

class SpeechBubbleEdges {
  const SpeechBubbleEdges.fromLTRB(
      this.left,
      this.top,
      this.right,
      this.bottom,
      );

  const SpeechBubbleEdges.all(double? value)
      : left = value,
        top = value,
        right = value,
        bottom = value;

  const SpeechBubbleEdges.only({
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  const SpeechBubbleEdges.symmetric({
    double? vertical,
    double? horizontal,
  })  : left = horizontal,
        top = vertical,
        right = horizontal,
        bottom = vertical;

  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  EdgeInsets get edgeInsets =>
      EdgeInsets.fromLTRB(left ?? 0, top ?? 0, right ?? 0, bottom ?? 0);

  @override
  String toString() => 'BubbleEdges($left, $top, $right, $bottom)';
}