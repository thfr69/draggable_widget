part of 'speech_bubble_cubit.dart';


class SpeechBubbleState extends Equatable  {
  @override
  List<Object> get props => [];
}

class ControlSpeechBubbleState extends SpeechBubbleState {
  bool isVisible = false;

  ControlSpeechBubbleState(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}

class ControlBubblePositionState extends ControlSpeechBubbleState {
  final Offset bubblePosition;
  final BubbleNip bubbleNip;

  ControlBubblePositionState(super.isVisible, this.bubblePosition, this.bubbleNip);

  @override
  List<Object> get props => [super.isVisible, bubblePosition, bubbleNip];
}