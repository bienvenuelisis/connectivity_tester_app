import 'dart:async';

import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';

import '../commons/show_connectivity_dialog.dart';

class CrossConnectivityTesterPage extends StatefulWidget {
  const CrossConnectivityTesterPage({super.key});

  @override
  State<CrossConnectivityTesterPage> createState() =>
      _CrossConnectivityTesterPageState();
}

class _CrossConnectivityTesterPageState
    extends State<CrossConnectivityTesterPage> {
  bool _dialogVisible = false;
  ConnectivityStatus _status = ConnectivityStatus.none;
  late StreamSubscription<ConnectivityStatus> _connectivitySubscription;

  @override
  void initState() {
    ConnectivitySettings.init(lookupDuration: const Duration(seconds: 30));

    super.initState();

    Future.delayed(
      Duration.zero,
      () async {
        _connectivitySubscription =
            Connectivity().onConnectivityChanged.listen((_) {});

        _connectivitySubscription.onData(_listenToConnectivityResult);

        if (!isConnected) {
          await _showConnectivityDialog(context);
        }
      },
    );
  }

  void _listenToConnectivityResult(ConnectivityStatus result) {
    if (context.mounted) {
      setState(() {
        _status = result;
      });
    }

    debugPrint('Connectivity status changed: $status.');
    debugPrint('Is connected: $isConnected.');

    if (isConnected) {
      if (_dialogVisible) {
        _dialogVisible = false;

        Future.delayed(
          Duration.zero,
          () {
            Navigator.of(context).pop('dialog');
          },
        );
      }
    } else {
      if (!_dialogVisible) {
        _dialogVisible = true;

        unawaited(_showConnectivityDialog(context));
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  bool get isConnected => _status != ConnectivityStatus.unknown;
  ConnectivityStatus get status => _status;

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
