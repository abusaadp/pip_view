import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart';

import 'floating_manager.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatefulWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  bool alreadyAddedOverlays = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: LayoutBuilder(
        builder: (layoutContext, constraints) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            if (alreadyAddedOverlays) {
              return;
            }

            // use LayoutBuilder's context (LayoutBuilder)
            Overlay.of(layoutContext)?.insert(
              OverlayEntry(builder: (context) => const HomeScreen()),
            );

            alreadyAddedOverlays = true;
          });

          return const FirstScreen();
        },
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('This is the first page!'),
              const Text(
                  'If you tap on the floating screen, it stops floating.'),
              const Text('Navigation works as expected.'),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                child: const Text('Push to floating screen'),
                onPressed: () {
                  FloatingManager.showFull();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FloatingManager.listen(() {
      setState(() {
        // do something ..
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // hide floating screen when it is not shown
    if (!FloatingManager.isShown) {
      return const SizedBox.shrink();
    }

    return PIPView(
      builder: (context, isFloating) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text('This page will float!'),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text('Start floating!'),
                  onPressed: () {
                    FloatingManager.minimize(context);
                  },
                ),
                MaterialButton(
                  color: Colors.red,
                  child: const Text('End floating!'),
                  onPressed: () {
                    FloatingManager.close();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
