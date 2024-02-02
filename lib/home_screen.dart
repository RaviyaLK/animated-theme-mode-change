import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:theme_mode_change/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  static const path = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var animationLink = 'assets/day.riv';
  SMITrigger? themeTrigger;
  Artboard? artboard;
  StateMachineController? stateMachineController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    rootBundle.load(animationLink).then((value) {
      final file = RiveFile.import(value);
      final art = file.mainArtboard;
      stateMachineController =
          StateMachineController.fromArtboard(art, "State Machine 1");

      if (stateMachineController != null) {
        art.addController(stateMachineController!);

        for (var element in stateMachineController!.inputs) {
          if (element.name == "Button Click") {
            themeTrigger = element as SMITrigger;
          }
        }
      }
      setState(() => artboard = art);
    });
    super.initState();
  }

  void themeChange() {
    if (themeTrigger != null) {
      themeTrigger!.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    AdaptiveThemeMode currentMode = AdaptiveTheme.of(context).mode;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (artboard != null)
              Container(
                decoration: const BoxDecoration(color: Colors.black),
                width: double.infinity,
                height: 250,
                child: GestureDetector(
                  onTap: () {
                    themeChange();
                    if (currentMode == AdaptiveThemeMode.light ||
                        currentMode == AdaptiveThemeMode.system) {
                      Future.delayed(StaticDurations.pageTransition)
                          .then((value) {
                        AdaptiveTheme.of(context).setDark();
                      });
                    } else {
                      Future.delayed(StaticDurations.pageTransition)
                          .then((value) {
                        AdaptiveTheme.of(context).setLight();
                      });
                    }
                  },
                  child: Rive(
                    artboard: artboard!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Expanded(
              flex: 2,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const SizedBox(
                    height: 90,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: CupertinoColors.secondaryLabel,
                      ),
                      child: Text(
                        'Welcome John',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Profile'),
                    hoverColor: Colors.grey[300],
                    leading: const Icon(Icons.person),
                    onTap: () {
                      // Add navigation logic here
                    },
                  ),
                  ListTile(
                    hoverColor: Colors.grey[300],
                    title: const Text('Settings'),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      // Add navigation logic here
                    },
                  ),
                  ListTile(
                    hoverColor: Colors.grey[300],
                    title: const Text('About Us'),
                    leading: const Icon(Icons.read_more),
                    onTap: () {
                      // Add navigation logic here
                    },
                  ),
                  // Add more list tiles as needed
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 450), // Adjust this value as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Home Screen"),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 0,
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                width: 40,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
