part of 'helping_assistant_cubit.dart';


class HelpingAssistantState extends Equatable {

  @override
  List<Object> get props => [];
}


class ControlAssistantVisibilityState extends HelpingAssistantState {
  final bool isVisible;
  final bool? showBubbleImmediately;

  ControlAssistantVisibilityState(this.isVisible, {this.showBubbleImmediately});

  @override
  List<Object> get props => [isVisible];
}




