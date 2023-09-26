import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:bubble/bubble.dart';
import 'package:draggable_widget/model/anchor_docker.dart';
import 'package:equatable/equatable.dart';
import 'package:example/src/view/helping_assistant.dart';
import 'package:example/src/view/widget/speech_bubble_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:meta/meta.dart';

part 'speech_bubble_state.dart';

class SpeechBubbleCubit extends Cubit<ControlSpeechBubbleState> {
  SpeechBubbleCubit() : super(ControlSpeechBubbleState());


  void controlSpeechBubbleVisibility({bool? hideTemporarily}) {
    if(hideTemporarily == null) {
      emit(ControlSpeechBubbleState(
          isVisible: !state.isVisible, bubblePosition: state.bubblePosition, bubbleNip: state.bubbleNip));
    } else {
      if(hideTemporarily && state.isVisible) {
        emit(ControlSpeechBubbleState(
            isVisible: false, bubblePosition: state.bubblePosition, bubbleNip: state.bubbleNip, isTemporarilyHidden: true));
      }
      if(!hideTemporarily && state.isTemporarilyHidden != null) {
        emit(ControlSpeechBubbleState(
            isVisible: true, bubblePosition: state.bubblePosition, bubbleNip: state.bubbleNip, isTemporarilyHidden: null));
      }
    }
  }

  void controlSpeechBubblePosition({
    required AnchoringPosition docker,
    required Offset draggableOffset,
    required Size draggableSize,
    required Size positionalSize}) {

    double? dx = draggableOffset.dx;
    double? dy = draggableOffset.dy;

    Offset _bubbleOffset;
    SpeechBubbleNip _speechBubbleNip;


    switch (docker) {
      case AnchoringPosition.topLeft:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + (draggableSize.height / 2 - draggableSize.height * 0.1));
        _speechBubbleNip = SpeechBubbleNip.LEFT_TOP;
        break;
      case AnchoringPosition.topCenter:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + (draggableSize.height / 2 - draggableSize.height * 0.1));
        _speechBubbleNip = SpeechBubbleNip.LEFT_TOP;
        break;
      case AnchoringPosition.topRight:
        _bubbleOffset = Offset(dx - (draggableSize.width + positionalSize.width / 4), dy + (draggableSize.height / 2 - draggableSize.height * 0.1));
        _speechBubbleNip = SpeechBubbleNip.RIGHT_TOP;
        break;
      case AnchoringPosition.leftCenter:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - positionalSize.height / 2);
        _speechBubbleNip = SpeechBubbleNip.LEFT_CENTER;
        break;
      case AnchoringPosition.center:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - positionalSize.height / 2);
        _speechBubbleNip = SpeechBubbleNip.LEFT_CENTER;
        break;
      case AnchoringPosition.bottomLeft:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - positionalSize.height);
        _speechBubbleNip = SpeechBubbleNip.LEFT_BOTTOM;
        break;
      case AnchoringPosition.bottomCenter:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - positionalSize.height);
        _speechBubbleNip = SpeechBubbleNip.LEFT_BOTTOM;
        break;
      case AnchoringPosition.bottomRight:
        _bubbleOffset = Offset(dx - (draggableSize.width + positionalSize.width / 4), dy + 40 - positionalSize.height);
        _speechBubbleNip = SpeechBubbleNip.RIGHT_BOTTOM;
        break;
      case AnchoringPosition.rightCenter:
        _bubbleOffset = Offset(dx - (draggableSize.width + positionalSize.width / 4), dy + 40 - positionalSize.height / 2);
        _speechBubbleNip = SpeechBubbleNip.RIGHT_CENTER;
        break;
    }

    emit(ControlSpeechBubbleState(bubblePosition:  _bubbleOffset, bubbleNip: _speechBubbleNip, isVisible: state.isVisible,));
  }



}
