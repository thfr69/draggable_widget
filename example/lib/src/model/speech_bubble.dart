import 'dart:ui';

import 'package:bubble/bubble.dart';
import 'package:equatable/equatable.dart';
import 'package:example/src/view/widget/speech_bubble.export.dart';
import 'package:flutter/material.dart';

@immutable
class SpeechBubble extends Equatable {
  final Offset bubbleOffset;
  final SpeechBubbleNip bubbleNip;

  SpeechBubble({required this.bubbleOffset, required this.bubbleNip});

  @override
  List<Object> get props => [bubbleOffset, bubbleNip];

  SpeechBubble copyWith({
    Offset? bubbleOffset,
    SpeechBubbleNip? bubbleNip,
  }) {
    return SpeechBubble(
      bubbleOffset: bubbleOffset ?? this.bubbleOffset,
      bubbleNip: bubbleNip ?? this.bubbleNip,
    );
  }
}