import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/car_controller.dart';

class CheckedOutCarsScreen extends StatelessWidget {
  final CarController carController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checked-in Cars')),
      body: Obx(() {
        if (carController.cars.isEmpty) {
          return Center(child: Text("No cars checked in."));
        }
        return ListView.builder(
          itemCount: carController.cars.length,
          itemBuilder: (context, index) {
            final car = carController.cars[index];
            return ListTile(
              title: Text(car.carNumber),
              subtitle: Text('Checked in at: ${car.checkInTime}'),
              trailing: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  carController.checkOut(car);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
