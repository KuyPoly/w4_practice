import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final ColorService count = ColorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: count,
        builder: (context, _) {
          return _currentIndex == 0
              ? ColorTapsScreen(
                  tapCount: count.tapCount,
                  onTap: count._incrementTap,
                )
              : StatisticsScreen(tapCount: count.tapCount);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorService extends ChangeNotifier {
  final Map<CardType, int> _tapCount = {CardType.red: 0, CardType.blue: 0};

  Map<CardType, int> get tapCount => _tapCount;

  void _incrementTap(CardType type) {
    _tapCount[type] = _tapCount[type]! + 1;
    notifyListeners();
  }
}

class ColorTapsScreen extends StatelessWidget {
  final Map<CardType, int> tapCount;
  final void Function(CardType) onTap;

  const ColorTapsScreen({
    super.key,
    required this.tapCount,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ColorTap(
            type: CardType.red,
            tapCount: tapCount[CardType.red]!,
            onTap: () => onTap(CardType.red),
          ),
          ColorTap(
            type: CardType.blue,
            tapCount: tapCount[CardType.blue]!,
            onTap: () => onTap(CardType.blue),
          ),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  final Map<CardType, int> tapCount;

  const StatisticsScreen({super.key, required this.tapCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Red Taps: ${tapCount[CardType.red]}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Blue Taps: ${tapCount[CardType.blue]}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
