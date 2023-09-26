import 'dart:ui';

import 'package:bubble/bubble.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class SpeechBubble extends Equatable {
  final Offset bubbleOffset;
  final BubbleNip bubbleNip;

  SpeechBubble({required this.bubbleOffset, required this.bubbleNip});

  @override
  List<Object> get props => [bubbleOffset, bubbleNip];

  SpeechBubble copyWith({
    Offset? bubbleOffset,
    BubbleNip? bubbleNip,
  }) {
    return SpeechBubble(
      bubbleOffset: bubbleOffset ?? this.bubbleOffset,
      bubbleNip: bubbleNip ?? this.bubbleNip,
    );
  }
}