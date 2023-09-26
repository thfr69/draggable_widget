

import 'dart:math';

import 'package:example/src/view/widget/speech_bubble_widget.dart';
import 'package:flutter/rendering.dart';

class SpeechBubbleClipper extends CustomClipper<Path> {


  SpeechBubbleClipper({
    required this.radius,
    required this.showNip,
    required this.nip,
    required this.nipWidth,
    required this.nipHeight,
    required this.nipOffset,
    required this.nipRadius,
    required this.stick,
    required this.padding,
  })   : assert(nipWidth > 0),
        assert(nipHeight > 0),
        assert(nipRadius >= 0),
        assert(nipRadius <= nipWidth / 2 && nipRadius <= nipHeight / 2),
        super() {
    if (nip == SpeechBubbleNip.NO) return;

    _startOffset = _endOffset = nipWidth;

    final isCenter =
        nip == SpeechBubbleNip.LEFT_CENTER || nip == SpeechBubbleNip.RIGHT_CENTER;
    final k = isCenter ? nipHeight / 2 / nipWidth : nipHeight / nipWidth;
    final a = atan(k);

    _nipCX = isCenter
        ? sqrt(nipRadius * nipRadius * (1 + 1 / k / k))
        : (nipRadius + sqrt(nipRadius * nipRadius * (1 + k * k))) / k;
    final nipStickOffset = (_nipCX - nipRadius).floorToDouble();

    _nipCX -= nipStickOffset;
    _nipCY = isCenter ? 0 : nipRadius;
    _nipPX = _nipCX - nipRadius * sin(a);
    _nipPY = _nipCY + nipRadius * cos(a);
    _startOffset -= nipStickOffset;
    _endOffset -= nipStickOffset;

    if (stick) _endOffset = 0;
  }

  final Radius radius;
  final bool showNip;
  final SpeechBubbleNip nip;
  final double nipHeight;
  final double nipWidth;
  final double nipOffset;
  final double nipRadius;
  final bool stick;
  final EdgeInsets padding;

  double _startOffset = 0; // Offsets of the bubble
  double _endOffset = 0;
  double _nipCX = 0; // The center of the circle
  double _nipCY = 0;
  double _nipPX = 0; // The point of contact of the nip with the circle
  double _nipPY = 0;

  EdgeInsets get edgeInsets {
    switch (nip) {
      case SpeechBubbleNip.LEFT_TOP:
      case SpeechBubbleNip.LEFT_BOTTOM:
      case SpeechBubbleNip.LEFT_CENTER:
        return EdgeInsets.only(
            left: _startOffset + padding.left,
            top: padding.top,
            right: _endOffset + padding.right,
            bottom: padding.bottom);

      case SpeechBubbleNip.RIGHT_TOP:
      case SpeechBubbleNip.RIGHT_BOTTOM:
      case SpeechBubbleNip.RIGHT_CENTER:
        return EdgeInsets.only(
            left: _endOffset + padding.left,
            top: padding.top,
            right: _startOffset + padding.right,
            bottom: padding.bottom);

      default:
        return EdgeInsets.only(
            left: _endOffset + padding.left,
            top: padding.top,
            right: _endOffset + padding.right,
            bottom: padding.bottom);
    }
  }

  @override
  Path getClip(Size size) {
    var radiusX = radius.x;
    var radiusY = radius.y;
    final maxRadiusX = size.width / 2;
    final maxRadiusY = size.height / 2;

    if (radiusX > maxRadiusX) {
      radiusY *= maxRadiusX / radiusX;
      radiusX = maxRadiusX;
    }
    if (radiusY > maxRadiusY) {
      radiusX *= maxRadiusY / radiusY;
      radiusY = maxRadiusY;
    }

    var path = Path();

    switch (nip) {
      case SpeechBubbleNip.LEFT_TOP:
      case SpeechBubbleNip.LEFT_BOTTOM:
      case SpeechBubbleNip.LEFT_CENTER:
        path.addRRect(RRect.fromLTRBR(
            _startOffset, 0, size.width - _endOffset, size.height, radius));
        break;

      case SpeechBubbleNip.RIGHT_TOP:
      case SpeechBubbleNip.RIGHT_BOTTOM:
      case SpeechBubbleNip.RIGHT_CENTER:
        path.addRRect(RRect.fromLTRBR(
            _endOffset, 0, size.width - _startOffset, size.height, radius));
        break;

      default:
        path.addRRect(RRect.fromLTRBR(
            _endOffset, 0, size.width - _endOffset, size.height, radius));
    }

    if (showNip) {
      switch (nip) {
        case SpeechBubbleNip.LEFT_TOP:
          final path2 = Path()
            ..moveTo(_startOffset + radiusX, nipOffset)
            ..lineTo(_startOffset + radiusX, nipOffset + nipHeight)
            ..lineTo(_startOffset, nipOffset + nipHeight);

          if (nipRadius == 0) {
            path2.lineTo(0, nipOffset);
          } else {
            path2
              ..lineTo(_nipPX, nipOffset + _nipPY)
              ..arcToPoint(
                Offset(_nipCX, nipOffset),
                radius: Radius.circular(nipRadius),
              );
          }

          path2.close();
          path = Path.combine(PathOperation.union, path, path2);
          break;

        case SpeechBubbleNip.LEFT_CENTER:
          final cy = nipOffset + size.height / 2;
          final nipHalf = nipHeight / 2;

          final path2 = Path()
            ..moveTo(_startOffset, cy - nipHalf)
            ..lineTo(_startOffset + radiusX, cy - nipHalf)
            ..lineTo(_startOffset + radiusX, cy + nipHalf)
            ..lineTo(_startOffset, cy + nipHalf);

          if (nipRadius == 0) {
            path2.lineTo(0, cy);
          } else {
            path2
              ..lineTo(_nipPX, cy + _nipPY)
              ..arcToPoint(
                Offset(_nipPX, cy - _nipPY),
                radius: Radius.circular(nipRadius),
              );
          }

          path2.close();
          path = Path.combine(PathOperation.union, path, path2);
          break;

        case SpeechBubbleNip.LEFT_BOTTOM:
          final path2 = Path()
            ..moveTo(_startOffset + radiusX, size.height - nipOffset)
            ..lineTo(
                _startOffset + radiusX, size.height - nipOffset - nipHeight)
            ..lineTo(_startOffset, size.height - nipOffset - nipHeight);

          if (nipRadius == 0) {
            path2.lineTo(0, size.height - nipOffset);
          } else {
            path2
              ..lineTo(_nipPX, size.height - nipOffset - _nipPY)
              ..arcToPoint(
                Offset(_nipCX, size.height - nipOffset),
                radius: Radius.circular(nipRadius),
                clockwise: false,
              );
          }

          path2.close();
          path = Path.combine(PathOperation.union, path, path2);
          break;

        case SpeechBubbleNip.RIGHT_TOP:
          final path2 = Path()
            ..moveTo(size.width - _startOffset - radiusX, nipOffset)
            ..lineTo(size.width - _startOffset - radiusX, nipOffset + nipHeight)
            ..lineTo(size.width - _startOffset, nipOffset + nipHeight);

          if (nipRadius == 0) {
            path2.lineTo(size.width, nipOffset);
          } else {
            path2
              ..lineTo(size.width - _nipPX, nipOffset + _nipPY)
              ..arcToPoint(
                Offset(size.width - _nipCX, nipOffset),
                radius: Radius.circular(nipRadius),
                clockwise: false,
              );
          }

          path2.close();
          path = Path.combine(PathOperation.union, path, path2);
          break;

        case SpeechBubbleNip.RIGHT_CENTER:
          final cy = nipOffset + size.height / 2;
          final nipHalf = nipHeight / 2;

          final path2 = Path()
            ..moveTo(size.width - _startOffset, cy - nipHalf)
            ..lineTo(size.width - _startOffset - radiusX, cy - nipHalf)
            ..lineTo(size.width - _startOffset - radiusX, cy + nipHalf)
            ..lineTo(size.width - _startOffset, cy + nipHalf);

          if (nipRadius == 0) {
            path2.lineTo(size.width, cy);
          } else {
            path2
              ..lineTo(size.width - _nipPX, cy + _nipPY)
              ..arcToPoint(
                Offset(size.width - _nipPX, cy - _nipPY),
                radius: Radius.circular(nipRadius),
                clockwise: false,
              );
          }

          path2.close();
          path = Path.combine(PathOperation.union, path, path2);
          break;

        case SpeechBubbleNip.RIGHT_BOTTOM:
          final path2 = Path()
            ..moveTo(
                size.width - _startOffset - radiusX, size.height - nipOffset)
            ..lineTo(size.width - _startOffset - radiusX,
                size.height - nipOffset - nipHeight)
            ..lineTo(
                size.width - _startOffset, size.height - nipOffset - nipHeight);

          if (nipRadius == 0) {
            path2.lineTo(size.width, size.height - nipOffset);
          } else {
            path2
              ..lineTo(size.width - _nipPX, size.height - nipOffset - _nipPY)
              ..arcToPoint(
                Offset(size.width - _nipCX, size.height - nipOffset),
                radius: Radius.circular(nipRadius),
              );
          }

          path2.close();
          path = Path.combine(PathOperation.union, path, path2);
          break;

        default:
      }
    }

    return path;
  }

  @override
  bool shouldReclip(SpeechBubbleClipper oldClipper) => true;

}