import 'package:flutter/material.dart';

class CardSelection extends StatelessWidget {
  const CardSelection({
    Key? key,
    required this.cardImages,
    required this.isPortrait,
    required this.screenSize,
    required this.onSelectCard,
  }) : super(key: key);

  final List<String> cardImages;
  final bool isPortrait;
  final Size screenSize;
  final void Function(int) onSelectCard;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: isPortrait
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return GestureDetector(
                  onTap: () => onSelectCard(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.asset(
                      cardImages[index],
                      height: screenSize.height / 4,
                    ),
                  ),
                );
              }),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return GestureDetector(
                  onTap: () => onSelectCard(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      cardImages[index],
                      width: screenSize.width / 4,
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
