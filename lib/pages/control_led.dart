import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_control/connections/bluetooth_provider.dart';

class ControlLed extends StatelessWidget {
  const ControlLed({super.key});

  @override
  Widget build(BuildContext context) {
    final bluetoothProvider = Provider.of<BluetoothProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Control Led',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buttons(bluetoothProvider),
        ],
      ),
    );
  }

  Widget _buttons(BluetoothProvider bluetoothProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
      child: Column(
        children: [
          const SizedBox(height: 60.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.power_settings_new),
                    color: Colors.green,
                    iconSize: 100.0,
                    hoverColor: Colors.green,
                    onPressed: () => bluetoothProvider.sendColor(Colors.white),
                  ),
                  const Text(
                    'ON',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 90.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.power_settings_new),
                    color: Colors.red,
                    iconSize: 100.0,
                    hoverColor: Colors.red,
                    onPressed: () => bluetoothProvider.sendColor(Colors.black),
                  ),
                  const Text(
                    'OFF',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
