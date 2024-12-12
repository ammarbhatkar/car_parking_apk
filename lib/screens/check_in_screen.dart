import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../controller/car_controller.dart';

class CheckInScreen extends StatelessWidget {
  final CarController carController;

  CheckInScreen({Key? key})
      : carController = Get.put(CarController(Isar.getInstance()!)),
        super(key: key);

  final TextEditingController carNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car Check-in')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: carNumberController,
              decoration: InputDecoration(labelText: 'Car Number'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                carController.checkIn(carNumberController.text);
                carNumberController.clear();
                // Get.to(() => CheckInScreen());
              },
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Check in ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
