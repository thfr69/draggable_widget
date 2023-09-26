part of 'speech_bubble_cubit.dart';

class ControlSpeechBubbleState extends Equatable {
  final bool isVisible;
  final bool? isTemporarilyHidden;
  final Offset bubblePosition;
  final SpeechBubbleNip bubbleNip;

  ControlSpeechBubbleState({this.isVisible = false, this.isTemporarilyHidden, this.bubblePosition = const Offset(1000, 1000), this.bubbleNip = SpeechBubbleNip.NO});

  @override
  List<Object> get props => [isVisible, bubblePosition, bubbleNip];
}





