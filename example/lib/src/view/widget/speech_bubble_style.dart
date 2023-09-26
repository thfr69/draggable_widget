import 'package:example/src/view/widget/speech_bubble_edges.dart';
import 'package:example/src/view/widget/speech_bubble_widget.dart';
import 'package:flutter/material.dart';

class SpeechBubbleStyle {
  const SpeechBubbleStyle({
    this.radius,
    this.showNip,
    this.nip,
    this.nipWidth,
    this.nipHeight,
    this.nipOffset,
    this.nipRadius,
    this.stick,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.borderUp,
    this.elevation,
    this.shadowColor,
    this.padding,
    this.margin,
    this.alignment,
  });

  final Radius? radius;
  final bool? showNip;
  final SpeechBubbleNip? nip;
  final double? nipHeight;
  final double? nipWidth;
  final double? nipOffset;
  final double? nipRadius;
  final bool? stick;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final bool? borderUp;
  final double? elevation;
  final Color? shadowColor;
  final SpeechBubbleEdges? padding;
  final SpeechBubbleEdges? margin;
  final AlignmentGeometry? alignment;
}
