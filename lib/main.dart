import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  List<Widget> pages = [HomePage(), Placeholder(), Placeholder()];
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => StartTrainingPage()));
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
            child: Text('You have had 6 workouts this week'),
          )),
        )
      ],
    );
  }
}

class StartTrainingPage extends StatefulWidget {
  const StartTrainingPage({super.key});

  @override
  State<StartTrainingPage> createState() => _StartTrainingPageState();
}

class _StartTrainingPageState extends State<StartTrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DuringTrainingPage()),
                  );
                });
              },
              child: TransparentCard(
                  child: Column(
                children: [
                  Text('Start Training',
                      style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(height: 15.0),
                  Hero(
                    tag: 'startTrainingFAB',
                    child: Icon(
                      Icons.fitness_center_rounded,
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class DuringTrainingPage extends StatefulWidget {
  const DuringTrainingPage({super.key});

  @override
  State<DuringTrainingPage> createState() => _DuringTrainingPageState();
}

class _DuringTrainingPageState extends State<DuringTrainingPage> {
  bool paused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Text('hello'),
            Row(
              mainAxisAlignment: paused
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              children: [
                Visibility(
                    visible: paused,
                    child: FloatingActionButton(
                        onPressed: () {
                          print('go back');
                        },
                        child: Icon(Icons.stop_rounded))),
                FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        paused = !paused;
                      });
                    },
                    child: Icon(paused
                        ? Icons.play_arrow_rounded
                        : Icons.pause_rounded))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TransparentCard extends StatelessWidget {
  const TransparentCard({
    super.key,
    required this.child,
    this.elevation = 100.0,
  });

  final Widget child;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).shadowColor),
          borderRadius: BorderRadius.circular(25.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
