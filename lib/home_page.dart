import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'components/card_display.dart';
import 'components/card_selection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _cardSelected = false;
  bool _cardRevealed = false;
  int _selectedCardIndex = -1;
  String _selectedCardValue = "";
  GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  final List<String> _cardValues = ["TFB", "NFC", "LFG"];
  final List<String> _cardImages = [
    'assets/card_tfb.png',
    'assets/card_nfc.png',
    'assets/card_lfg.png'
  ];

  @override
  void initState() {
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.x > 10 || event.y > 10 || event.z > 10) {
        if (_cardSelected && !_cardRevealed) {
          _revealCard();
        }
      }
    });
  }

  void _selectCard(int index) {
    setState(() {
      _cardSelected = true;
      _cardRevealed = false;
      _selectedCardIndex = index;
      _selectedCardValue = _cardValues[index];
      _cardKey = GlobalKey<FlipCardState>(); // Reset the card key
    });
  }

  void _revealCard() {
    if (_cardKey.currentState != null && !_cardRevealed) {
      _cardKey.currentState?.toggleCard();
      setState(() {
        _cardRevealed = true;
      });
    }
  }

  void _reset() {
    setState(() {
      _cardSelected = false;
      _cardRevealed = false;
      _selectedCardIndex = -1;
      _selectedCardValue = "";
      _cardKey = GlobalKey<FlipCardState>(); // Reset the card key
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final screenSize = MediaQuery.of(context).size;
    final cardHeight = screenSize.height * 0.8; // 80% of screen height
    final cardWidth = cardHeight * (2.5 / 3.5); // Maintain aspect ratio of 2.5:3.5
    final cardMargin = screenSize.height * 0.05; // 5% margin

    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_cardSelected)
              CardSelection(
                cardImages: _cardImages,
                isPortrait: isPortrait,
                screenSize: screenSize,
                onSelectCard: _selectCard,
              ),
            if (_cardSelected)
              GestureDetector(
                onTap: _revealCard,
                child: Container(
                  margin: EdgeInsets.all(cardMargin),
                  child: CardDisplay(
                    cardKey: _cardKey,
                    cardWidth: cardWidth,
                    cardHeight: cardHeight,
                    cardImages: _cardImages,
                    selectedCardIndex: _selectedCardIndex,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (_cardSelected && !_cardRevealed)
              ElevatedButton(
                onPressed: _revealCard,
                child: const Text('Reveal'),
              ),
            if (_cardSelected && _cardRevealed)
              ElevatedButton(
                onPressed: _reset,
                child: const Text('Back'),
              ),
          ],
        ),
      ),
    );
  }
}
