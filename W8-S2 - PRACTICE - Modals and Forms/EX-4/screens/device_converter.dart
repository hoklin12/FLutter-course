// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:new_flutter_app/W8-S2/EX-4/models/expense.dart';
// // import 'package:new_flutter_app/W8-S2/EX-4/screens/expenses_item.dart';
//
//
//
// class DeviceConverter extends StatefulWidget {
//   const DeviceConverter({super.key});
//
//   @override
//   State<DeviceConverter> createState() => _DeviceConverterState();
// }
//
// class _DeviceConverterState extends State<DeviceConverter> {
//
//   // final BoxDecoration textDecoration = BoxDecoration(
//   //   color: Colors.white,
//   //   borderRadius: BorderRadius.circular(12),
//   //);
//
//   final _converterController = TextEditingController();
//   Device? selectDevice;
//   String _result = '';
//
//   void _calculateAmount() {
//     final amount = double.tryParse(_converterController.text);
//     if (amount != null) {
//       final calculatedAmount = amount * 2; // Your calculation here
//       setState(() {
//         _result = 'Result: \$${calculatedAmount.toStringAsFixed(2)}';
//       });
//     } else {
//       setState(() {
//         _result = 'Please enter a valid amount.';
//       });
//     }
//   }
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   // }
//   @override
//   void dispose() {
//     _converterController.dispose();
//     super.dispose();
//   }
//
//   // final expense = Expense(
//   //   amount: amount,
//   //   device: selectedevice!,
//   // );
// // Future<double> convertAmount() async {
// //
// // }
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(40.0),
//       child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Icon(
//                 Icons.money,
//                 size: 60,
//                 color: Colors.white,
//               ),
//               const Center(
//                 child: Text(
//                   "Converter",
//                   style: TextStyle(color: Colors.white, fontSize: 30),
//                 ),
//               ),
//               const SizedBox(height: 50),
//               const Text("Amount in dollars:"),
//               const SizedBox(height: 10),
//
//               TextField(
//                 keyboardType: TextInputType.number,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.digitsOnly,
//                 ],
//                 controller: _converterController,
//                 decoration: const InputDecoration(
//                   labelText: 'Amount',
//                   prefix: Text('\$'),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//               const Text("Device:"),
//               DropdownButtonFormField<Device>(
//                 value: selectDevice,
//                 hint: const Text('Select device'),
//                 items: Device.values.map((device) {
//                   return DropdownMenuItem<Device>(
//                     value: device,
//                     child: Row(
//                       children: [
//                         const SizedBox(width: 10),
//                         Text(device.name),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: (Device? value) {
//                   setState(() {
//                     selectDevice = value;
//                   });
//                 },
//               ),
//
//
//               const SizedBox(height: 30),
//               const Text("Amount in selected device:"),
//               const SizedBox(height: 10),
//               Container(
//                   padding: const EdgeInsets.all(10),
//                   // decoration: textDecoration,
//                 // child: ExpenseItem(convertAmount()))
//                 child: Text($amount))
//
//             ],
//           )),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_flutter_app/W8-S2/EX-4/models/expense.dart';

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  final _converterController = TextEditingController();
  Device? selectedDevice;
  String _result = '';

  // Define conversion rates (example rates, update as necessary)
  final Map<Device, double> conversionRates = {
    Device.euro: 0.95, // Example: 1 USD = 0.85 Euro
    Device.riel: 4038, // Example: 1 USD = 4080 Riel
    Device.yuan: 6.45, // Example: 1 USD = 6.45 Yuan
  };

  void _calculateAmount() {
    final amount = double.tryParse(_converterController.text);
    if (amount != null && selectedDevice != null) {
      final conversionRate = conversionRates[selectedDevice]!;
      final calculatedAmount = amount * conversionRate;

      setState(() {
        _result = '${calculatedAmount.toStringAsFixed(2)} ${selectedDevice!.name.toUpperCase()}';
      });
    } else {
      setState(() {
        _result = 'Please enter a valid amount and select a currency.';
      });
    }
  }

  @override
  void dispose() {
    _converterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.money,
              size: 60,
              color: Colors.white,
            ),
            const Center(
              child: Text(
                "Converter",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            const SizedBox(height: 50),
            const Text("Amount in USD:"),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: _converterController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefix: Text('\$'),
              ),
              onChanged: (value) {
                if (selectedDevice != null) {
                  _calculateAmount();
                }
              },
            ),
            const SizedBox(height: 20),
            const Text("Select Currency:"),
            DropdownButtonFormField<Device>(
              value: selectedDevice,
              hint: const Text('Select currency'),
              items: Device.values.map((currency) {
                return DropdownMenuItem<Device>(
                  value: currency,
                  child: Text(currency.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (Device? value) {
                setState(() {
                  selectedDevice = value;
                });
                _calculateAmount();
              },
            ),
            const SizedBox(height: 30),
            const Text("Amount in selected device:"),
            const SizedBox(height: 10),
            // Text(
            //   _result,
            //   style: const TextStyle(fontSize: 20, color: Colors.black),
            // ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.white, // Border color
                  width: 1.0,
                ),
              ),
              child: Text(
                _result, // Replace with your dynamic output
                style: const TextStyle(
                  fontSize: 18, // Font size of the output text
                  color: Colors.black, // Text color
                  fontWeight: FontWeight.w500, // Font weight
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
