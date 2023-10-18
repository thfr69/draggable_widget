import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:bubble/bubble.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'helping_assistant_state.dart';

class HelpingAssistantCubit extends Cubit<HelpingAssistantState> {
  HelpingAssistantCubit() : super(HelpingAssistantState());

/*  void controlAssistantVisibility() {
    bool isVisible;
    HelpingAssistantState helpingState = state;
    isVisible = helpingState is ControlAssistantVisibilityState
      ? !helpingState.isVisible : true;

    emit(ControlAssistantVisibilityState(isVisible));
  }*/

  void controlAssistantVisibility({bool? showBubbleAsWell}) {
    bool isVisible;
    bool? isBubbleVisible;
    final HelpingAssistantState helpingState = state;
    isVisible = helpingState is ControlAssistantVisibilityState
        ? !helpingState.isVisible : true;

    isBubbleVisible = helpingState is ControlAssistantVisibilityState ? helpingState.showBubbleImmediately : null;
    emit(ControlAssistantVisibilityState(isVisible, showBubbleImmediately: isBubbleVisible ?? showBubbleAsWell));

  }

}
