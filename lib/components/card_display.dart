import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class CardDisplay extends StatelessWidget {
  const CardDisplay({
    Key? key,
    required this.cardKey,
    required this.cardWidth,
    required this.cardHeight,
    required this.cardImages,
    required this.selectedCardIndex,
  }) : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final double cardWidth;
  final double cardHeight;
  final List<String> cardImages;
  final int selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: cardKey,
      flipOnTouch: false,
      front: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: AssetImage('assets/card_back.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      back: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(cardImages[selectedCardIndex]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
