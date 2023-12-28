import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'transparentcard.dart';

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

class _DuringTrainingPageState extends State<DuringTrainingPage>
    with SingleTickerProviderStateMixin {
  bool paused = false;
  late AnimationController playPauseController;
  final exercises = <String>[
    "Abduktion",
    "Adduktion",
    "Beinbeuger",
    "Beinstrecker",
    "Squats",
    "Hack Squats",
    "Wadenheben",
    "Shrugs"
  ];

  @override
  void initState() {
    super.initState();

    playPauseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DropdownSearch<String>(
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: exercises,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Exercise",
                    hintText: "choose exercise",
                  ),
                ),
                onChanged: print,
                selectedItem: exercises[0],
              ),
            ),
            Text('hello'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimatedOpacity(
                  opacity: paused ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: FloatingActionButton(
                      onPressed: paused
                          ? () {
                              Navigator.pop(context);
                            }
                          : null,
                      child: Icon(Icons.stop_rounded)),
                ),
                FloatingActionButton(
                    onPressed: () {
                      togglePlayPause();
                    },
                    heroTag: 'startTrainingFAB',
                    child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: playPauseController))
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void togglePlayPause() => setState(() {
        paused = !paused;
        paused ? playPauseController.forward() : playPauseController.reverse();
      });
}
