part of 'helping_assistant_cubit.dart';


class HelpingAssistantState extends Equatable {

  @override
  List<Object> get props => [];
}


class ControlAssistantVisibilityState extends HelpingAssistantState {
  final bool isVisible;

  ControlAssistantVisibilityState(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}

/*class ControlBubblePositionState extends HelpingAssistantState {
  final Offset bubblePosition;
  final BubbleNip bubbleNip;
  final bool showBubble;

  ControlBubblePositionState({required this.bubblePosition, required this.bubbleNip, this.showBubble = false});

  @override
  List<Object> get props => [bubblePosition, bubbleNip];
}*/



/*class ControlBubbleVisibilityState extends HelpingAssistantState {
  final bool isVisible;
  ControlBubbleVisibilityState({this.isVisible = false});

  @override
  List<Object> get props => [isVisible];

}

class ControlBubblePositionState extends ControlBubbleVisibilityState {
  final Offset bubblePosition;
  final BubbleNip bubbleNip;

  ControlBubblePositionState({super.isVisible, required this.bubblePosition, required this.bubbleNip});

  @override
  List<Object> get props => [super.isVisible, bubblePosition, bubbleNip];
}*/


