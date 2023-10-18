import 'dart:ui';

import 'package:bubble/bubble.dart';
import 'package:draggable_widget/model/anchor_docker.dart';
import 'package:example/src/model/speech_bubble.dart';
import 'package:example/src/view_model/position_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/widget/speech_bubble.export.dart';

final StateProvider<bool> assistantVisibilityProvider = StateProvider<bool>((ref) => false);

final bubbleVisibilityProvider = StateNotifierProvider((ref) => BubbleVisibilityNotifier(false));

class BubbleVisibilityNotifier extends StateNotifier<bool> {
  bool? _isTemporarilyHidden;

  BubbleVisibilityNotifier(super.state);

  void controlBubbleVisibility({bool? hideTemporarily}) {
      if(hideTemporarily == null) {
        state = !state;
      } else {
        if(hideTemporarily && state) {
          _isTemporarilyHidden = true;
          state = false;
        }
        if(!hideTemporarily && _isTemporarilyHidden != null) {
          _isTemporarilyHidden = null;
          state = true;
        }
      }
  }

  // bool get visibility => state;

}

final bubblePositionProvider = Provider<PositionController>((ref) => PositionController());

final speechBubbleProvider = StateNotifierProvider((ref) => SpeechBubbleNotifier(ref.watch(bubblePositionProvider)));


class SpeechBubbleNotifier extends StateNotifier<SpeechBubble> {
  final PositionController _positionController;

  SpeechBubbleNotifier(this._positionController) : super(SpeechBubble(bubbleOffset: Offset(-1000, -1000), bubbleNip: SpeechBubbleNip.LEFT_TOP));

  void refreshSpeechBubble(AnchoringPosition docker,
      Offset draggableOffset,
      Size draggableSize,
      Size positionalSize) {
    final SpeechBubble newBubble = _positionController.calculateSpeechBubblePosition(docker, draggableOffset, draggableSize, positionalSize);
    state = newBubble;
  }
}
