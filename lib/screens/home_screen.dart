import 'package:carproject/controller/car_controller.dart';
import 'package:carproject/screens/car_details_screen.dart';
import 'package:carproject/screens/check_in_screen.dart';
import 'package:carproject/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatelessWidget {
  final CarController carController =
      Get.put(CarController(Isar.getInstance()!));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Check-in System'),
      ),
      body: Stack(
        children: [
          Obx(
            () => Visibility(
              visible: carController.isLoading.isTrue,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: carController.isLoading.isFalse,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Obx(() {
                        if (carController.cars.isEmpty) {
                          return Center(
                            child: Image.asset(
                              'resourcses/images/no-data.png',
                              height: 100,
                              width: 200,
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: carController.cars.length,
                          itemBuilder: (context, index) {
                            final car = carController.cars[index];
                            return Card(
                              margin: EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => CarDetailsScreen(
                                      carNumber: car.carNumber));
                                },
                                title: Text(car.carNumber,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    'Checked in at: ${DateFormat('dd MMM, yyyy h:mm a').format(car.checkInTime)}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.exit_to_app),
                                  onPressed: () {
                                    carController.checkOut(car);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CheckInScreen());
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
