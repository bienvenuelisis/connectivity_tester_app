import 'package:flutter/material.dart';

import 'connectivity_plus_tester_page.dart';
import 'cross_connectivity_tester_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'This app implements connectivity test with two different methods',
                ),
                const _Gap(
                  height: 15,
                ),
                const Text(
                  'Navigate to one of the pages to toggle your connectivity status.',
                ),
                const _Gap(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _pushTo(context, const ConnectivityPlusTesterPage());
                  },
                  child: const Text(
                    "With connectivity_plus package",
                  ),
                ),
                const _Gap(),
                ElevatedButton(
                  onPressed: () {
                    _pushTo(context, const CrossConnectivityTesterPage());
                  },
                  child: const Text(
                    "With cross_connectivity package",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _pushTo(BuildContext context, Widget page) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

class _Gap extends StatelessWidget {
  const _Gap({
    this.height = 10,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
