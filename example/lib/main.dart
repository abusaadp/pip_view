import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
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

                    Overlay.of(context)?.insert(
                      OverlayEntry(builder: (context) => HomeScreen()),
                    );

                    alreadyAddedOverlays = true;
                  });

                  return FirstScreen();
                },
              ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('This is the first page!'),
              Text('If you tap on the floating screen, it stops floating.'),
              Text('Navigation works as expected.'),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                child: Text('Push to floating screen'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HomeScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PIPView(
      builder: (context, isFloating) {
        return Scaffold(
          resizeToAvoidBottomInset: !isFloating,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('This page will float!'),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('Start floating!'),
                    onPressed: () {
                      PIPView.of(context)?.present();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
