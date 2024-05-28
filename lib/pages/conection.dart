import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_control/connections/bluetooth_provider.dart';

class Conection extends StatelessWidget {
  const Conection({super.key});

  @override
  Widget build(BuildContext context) {
    final bluetoothProvider = Provider.of<BluetoothProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Bluetooth Connection',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _controlBT(bluetoothProvider),
          _infoDevice(bluetoothProvider),
          Expanded(child: _listDevices(bluetoothProvider)),
        ],
      ),
    );
  }

  Widget _controlBT(BluetoothProvider bluetoothProvider) {
    return SwitchListTile(
      value: bluetoothProvider.isBluetoothOn,
      onChanged: (bool value) async {
        if (value) {
          await bluetoothProvider.bluetooth.requestEnable();
        } else {
          await bluetoothProvider.bluetooth.requestDisable();
        }
      },
      tileColor: Colors.white,
      title: Text(
        bluetoothProvider.isBluetoothOn ? "Bluetooth: ON" : "Bluetooth: OFF",
      ),
    );
  }

  Widget _infoDevice(BluetoothProvider bluetoothProvider) {
    return ListTile(
      tileColor: Colors.white,
      title: Text("Conectado a: ${bluetoothProvider.deviceConnected?.name ?? "ninguno"}"),
      trailing: bluetoothProvider.connection?.isConnected ?? false
          ? TextButton(
              onPressed: () async {
                bluetoothProvider.disconnect();
              },
              child: const Text("Desconectar"),
            )
          : TextButton(
              onPressed: bluetoothProvider.getDevices,
              child: const Text("Ver dispositivos"),
            ),
    );
  }

  Widget _listDevices(BluetoothProvider bluetoothProvider) {
    return bluetoothProvider.isConnecting
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  ...[
                    for (final device in bluetoothProvider.devices)
                      ListTile(
                        title: Text(device.name ?? device.address),
                        trailing: TextButton(
                          child: const Text('conectar'),
                          onPressed: () {
                            bluetoothProvider.connectToDevice(device);
                          },
                        ),
                      )
                  ]
                ],
              ),
            ),
          );
  }
}
