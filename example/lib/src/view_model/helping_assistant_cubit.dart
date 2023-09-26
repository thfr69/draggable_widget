import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:bubble/bubble.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'helping_assistant_state.dart';

class HelpingAssistantCubit extends Cubit<HelpingAssistantState> {
  HelpingAssistantCubit() : super(HelpingAssistantState());

  void controlAssistantVisibility() {
    bool isVisible;
    HelpingAssistantState helpingState = state;
    isVisible = helpingState is ControlAssistantVisibilityState
      ? !helpingState.isVisible : true;

    emit(ControlAssistantVisibilityState(isVisible));
  }

/*  void controlSpeechBubblePosition({
    required AnchoringPosition position,
    required Offset draggableOffset,
    required Size draggableSize,
    required Size bubbleSize,
    required Size positionalSize}) {

    double? dx = draggableOffset.dx;
    double? dy = draggableOffset.dy;

    Offset _bubbleOffset;
    BubbleNip _bubbleNip;

    switch (position) {
      case AnchoringPosition.topLeft:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + (draggableSize.height / 2 - draggableSize.height * 0.1));
        _bubbleNip = BubbleNip.leftTop;
        break;
      case AnchoringPosition.topCenter:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + (draggableSize.height / 2 - draggableSize.height * 0.1));
        _bubbleNip = BubbleNip.leftTop;
        break;
      case AnchoringPosition.topRight:
        _bubbleOffset = Offset(dx - (draggableSize.width + positionalSize.width / 4), dy + (draggableSize.height / 2 - draggableSize.height * 0.1));
        _bubbleNip = BubbleNip.rightTop;
        break;
      case AnchoringPosition.leftCenter:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - bubbleSize.height / 2);
        _bubbleNip = BubbleNip.leftCenter;
        break;
      case AnchoringPosition.center:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - bubbleSize.height / 2);
        _bubbleNip = BubbleNip.leftCenter;
        break;
      case AnchoringPosition.bottomLeft:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - bubbleSize.height);
        _bubbleNip = BubbleNip.leftBottom;
        break;
      case AnchoringPosition.bottomCenter:
        _bubbleOffset = Offset(dx + (draggableSize.width - 20), dy + 40 - bubbleSize.height);
        _bubbleNip = BubbleNip.leftBottom;
        break;
      case AnchoringPosition.bottomRight:
        _bubbleOffset = Offset(dx - (draggableSize.width + positionalSize.width / 4), dy + 40 - bubbleSize.height);
        _bubbleNip = BubbleNip.rightBottom;
        break;
      case AnchoringPosition.rightCenter:
        _bubbleOffset = Offset(dx - (draggableSize.width + positionalSize.width / 4), dy + 40 - bubbleSize.height / 2);
        _bubbleNip = BubbleNip.rightCenter;
        break;
    }

    emit(ControlBubblePositionState(bubblePosition: _bubbleOffset, bubbleNip: _bubbleNip));
  }*/



}
