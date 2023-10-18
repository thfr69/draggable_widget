import 'dart:ui';

import 'package:bubble/bubble.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:example/src/model/speech_bubble.dart';

import '../view/widget/speech_bubble.export.dart';

class PositionController {
  SpeechBubble calculateSpeechBubblePosition(
      AnchoringPosition docker,
      Offset draggableOffset,
      Size draggableSize,
      Size positionalSize) {

    double? dx = draggableOffset.dx;
    double? dy = draggableOffset.dy;

    Offset _bubbleOffset;
    SpeechBubbleNip _bubbleNip;


    switch (docker) {
      case AnchoringPosition.topLeft:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + (draggableSize.height / 2 - draggableSize.height * 0.1));
        _bubbleNip = SpeechBubbleNip.LEFT_TOP;
        break;
      case AnchoringPosition.topCenter:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + (draggableSize.height / 2 - draggableSize.height * 0.1));
        _bubbleNip = SpeechBubbleNip.LEFT_TOP;
        break;
      case AnchoringPosition.topRight:
        _bubbleOffset = Offset(dx - (draggableSize.width + positionalSize.width / 4), dy + (draggableSize.height / 2 - draggableSize.height * 0.1));
        _bubbleNip = SpeechBubbleNip.RIGHT_TOP;
        break;
      case AnchoringPosition.leftCenter:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - positionalSize.height / 2);
        _bubbleNip = SpeechBubbleNip.LEFT_CENTER;
        break;
      case AnchoringPosition.center:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - positionalSize.height / 2);
        _bubbleNip = SpeechBubbleNip.LEFT_CENTER;
        break;
      case AnchoringPosition.bottomLeft:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - positionalSize.height);
        _bubbleNip = SpeechBubbleNip.LEFT_BOTTOM;
        break;
      case AnchoringPosition.bottomCenter:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - positionalSize.height);
        _bubbleNip = SpeechBubbleNip.LEFT_BOTTOM;
        break;
      case AnchoringPosition.bottomRight:
        _bubbleOffset = Offset(dx - (draggableSize.width + positionalSize.width / 4), dy + 40 - positionalSize.height);
        _bubbleNip = SpeechBubbleNip.RIGHT_BOTTOM;
        break;
      case AnchoringPosition.rightCenter:
        _bubbleOffset = Offset(dx - (draggableSize.width + positionalSize.width / 4), dy + 40 - positionalSize.height / 2);
        _bubbleNip = SpeechBubbleNip.RIGHT_CENTER;
        break;
    }

    return SpeechBubble(bubbleOffset: _bubbleOffset, bubbleNip: _bubbleNip);
  }
}