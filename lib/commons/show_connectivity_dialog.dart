import 'package:flutter/material.dart';

Future<void> showConnectivityDialog(BuildContext context) async {
  Size size = MediaQuery.of(context).size;

  await showDialog<Object?>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: size.width * 0.95,
          height: size.height * 0.36,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Connection lost',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '''It appears that you are not connected to the Internet. Please check your connection settings.''',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  // Go to settings using app_settings package.
                  // AppSettings.openAppSettings(
                  //   type: AppSettingsType.wifi,
                  // );
                  onPressed: null,
                  child: const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
