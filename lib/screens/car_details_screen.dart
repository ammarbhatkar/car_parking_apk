import 'package:carproject/controller/car_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart'; // Import intl for date formatting

class CarDetailsScreen extends StatelessWidget {
  final String carNumber;
  final CarController carController = Get.find();

  CarDetailsScreen({required this.carNumber});

  @override
  Widget build(BuildContext context) {
    final car =
        carController.cars.firstWhere((car) => car.carNumber == carNumber);

    return Scaffold(
      appBar: AppBar(title: Text('Car Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Car Number: ${car.carNumber}',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(
                    'Checked In At: ${DateFormat('dd MMM, yyyy h:mm a').format(car.checkInTime)}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text(
                    'Checked Out At: ${car.checkOutTime != null ? DateFormat('dd MMM, yyyy h:mm a').format(car.checkOutTime!) : "Not checked out yet"}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    carController.checkOut(car);
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Check out ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
