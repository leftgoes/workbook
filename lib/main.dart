import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'training.dart';

void main() {
  runApp(WorkbookApp());
}

class WorkbookApp extends StatelessWidget {
  const WorkbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme(
      displayLarge: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
      // ···
      titleLarge: GoogleFonts.oswald(
        fontSize: 30,
        fontStyle: FontStyle.italic,
      ),
      headlineLarge: TextStyle(fontFamily: 'MajorMonoDisplay'),
      headlineMedium: TextStyle(fontFamily: 'MajorMonoDisplay'),
      headlineSmall: TextStyle(fontFamily: 'MajorMonoDisplay'),
      bodyMedium: GoogleFonts.merriweather(),
      displaySmall: GoogleFonts.pacifico(),
    );

    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: textTheme,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.dark(),
        textTheme: textTheme,
      ),
      themeMode: ThemeMode.light,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  List<Widget> pages = [
    HomePage(),
    Placeholder(),
    Placeholder(),
    Placeholder()
  ];
  List<int> showTrainingFABPageIndices = [0, 1];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: pages[currentPageIndex],
      floatingActionButton: AnimatedOpacity(
        opacity:
            showTrainingFABPageIndices.contains(currentPageIndex) ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 100),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StartTrainingPage()));
          },
          splashColor: theme.splashColor,
          hoverColor: theme.hoverColor,
          focusElevation: 6,
          highlightElevation: 10,
          heroTag: 'startTrainingFAB',
          child: Icon(Icons.fitness_center_rounded),
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(theme.textTheme.bodyMedium),
        ),
        child: NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.list_alt_rounded), label: 'Training Plan'),
            NavigationDestination(
                icon: Icon(Icons.straighten_rounded), label: 'Body'),
            NavigationDestination(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
            ),
          ],
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 200),
        Center(
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text('You have had 0 workouts this week'),
          )),
        )
      ],
    );
  }
}
