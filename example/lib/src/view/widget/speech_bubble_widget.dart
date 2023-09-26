import 'package:example/src/view/widget/speech_bubble_clipper.dart';
import 'package:example/src/view/widget/speech_bubble_edges.dart';
import 'package:example/src/view/widget/speech_bubble_painter.dart';
import 'package:example/src/view/widget/speech_bubble_style.dart';
import 'package:flutter/material.dart';

class SpeechBubbleWidget extends StatefulWidget {
  SpeechBubbleWidget({
    Key? key,
    this.child,
    Radius? radius,
    bool? showNip,
    SpeechBubbleNip? nip,
    double? nipWidth,
    double? nipHeight,
    double? nipOffset,
    double? nipRadius,
    bool? stick,
    Color? color,
    Color? borderColor,
    double? borderWidth,
    bool? borderUp,
    double? elevation,
    Color? shadowColor,
    SpeechBubbleEdges? padding,
    SpeechBubbleEdges? margin,
    AlignmentGeometry? alignment,
    SpeechBubbleStyle? style,
  })  : color = color ?? style?.color ?? Colors.white,
        borderColor = borderColor ?? style?.borderColor ?? Colors.transparent,
        borderWidth = borderWidth ?? style?.borderWidth ?? 1,
        borderUp = borderUp ?? style?.borderUp ?? true,
        elevation = elevation ?? style?.elevation ?? 1,
        shadowColor = shadowColor ?? style?.shadowColor ?? Colors.black,
        margin = EdgeInsets.only(
          left: margin?.left ?? style?.margin?.left ?? 0,
          top: margin?.top ?? style?.margin?.top ?? 0,
          right: margin?.right ?? style?.margin?.right ?? 0,
          bottom: margin?.bottom ?? style?.margin?.bottom ?? 0,
        ),
        alignment = alignment ?? style?.alignment,
        bubbleClipper = SpeechBubbleClipper(
          radius: radius ?? style?.radius ?? const Radius.circular(6),
          showNip: showNip ?? style?.showNip ?? true,
          nip: nip ?? style?.nip ?? SpeechBubbleNip.NO,
          nipWidth: nipWidth ?? style?.nipWidth ?? 8,
          nipHeight: nipHeight ?? style?.nipHeight ?? 10,
          nipOffset: nipOffset ?? style?.nipOffset ?? 0,
          nipRadius: nipRadius ?? style?.nipRadius ?? 1,
          stick: stick ?? style?.stick ?? false,
          padding: EdgeInsets.only(
            left: padding?.left ?? style?.padding?.left ?? 8,
            top: padding?.top ?? style?.padding?.top ?? 6,
            right: padding?.right ?? style?.padding?.right ?? 8,
            bottom: padding?.bottom ?? style?.padding?.bottom ?? 6,
          ),
        ),
        super(key: key);

  final Widget? child;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final bool borderUp;
  final double elevation;
  final Color shadowColor;
  final EdgeInsets margin;
  final AlignmentGeometry? alignment;
  final SpeechBubbleClipper bubbleClipper;

  @override
  State<SpeechBubbleWidget> createState() => _SpeechBubbleWidgetState();
}

class _SpeechBubbleWidgetState extends State<SpeechBubbleWidget> {
  @override
  Widget build(BuildContext context) => Container(
        // key: key,
        alignment: widget.alignment,
        margin: widget.margin,
        child: CustomPaint(
          painter: SpeechBubblePainter(
            clipper: widget.bubbleClipper,
            color: widget.color,
            borderColor: widget.borderColor,
            borderWidth: widget.borderWidth,
            borderUp: widget.borderUp,
            elevation: widget.elevation,
            shadowColor: widget.shadowColor,
          ),
          child: Container(
            padding: widget.bubbleClipper.edgeInsets,
            child: widget.child,
          ),
        ),
      );
}

enum SpeechBubbleNip {
  NO,
  LEFT_TOP,
  LEFT_CENTER,
  LEFT_BOTTOM,
  RIGHT_TOP,
  RIGHT_CENTER,
  RIGHT_BOTTOM,
}


