import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../commons/show_connectivity_dialog.dart';

class ConnectivityPlusTesterPage extends StatefulWidget {
  const ConnectivityPlusTesterPage({super.key});

  @override
  State<ConnectivityPlusTesterPage> createState() =>
      _ConnectivityPlusTesterPageState();
}

class _ConnectivityPlusTesterPageState
    extends State<ConnectivityPlusTesterPage> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _dialogVisible = false;
  ConnectivityResult _status = ConnectivityResult.none;

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
          (_) {},
        );
    _connectivitySubscription.onData(_listenToConnectivityResult);
  }

  bool get isConnected => !isNotConnected;
  bool get isNotConnected =>
      _status == ConnectivityResult.none || _status == ConnectivityResult.other;

  ConnectivityResult get status => _status;

  void _listenToConnectivityResult(ConnectivityResult result) {
    setState(() {
      _status = result;
    });

    debugPrint('Connectivity status changed: $status.');
    debugPrint('Is connected: $isConnected.');

    if (isConnected) {
      if (_dialogVisible) {
        _dialogVisible = false;
        if (context.mounted) {
          Future.delayed(
            Duration.zero,
            () {
              Navigator.of(context).pop('dialog');
            },
          );
        }
      }
    } else {
      if (!_dialogVisible) {
        _dialogVisible = true;

        if (context.mounted) {
          Future.delayed(
            Duration.zero,
            () {
              unawaited(_showConnectivityDialog(context));
            },
          );
        }
      }
    }
  }

  Future<void> _showConnectivityDialog(BuildContext context) async {
    Future.delayed(
      Duration.zero,
      () async {
        await showConnectivityDialog(context);

        if (isConnected) {
          setState(() {
            _dialogVisible = false;
          });
        } else if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Connectivity: $status"),
      ),
    );
  }
}
