import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import '../models/car.dart';

class CarController extends GetxController {
  final Isar isar;

  CarController(this.isar);

  var cars = <Car>[].obs;
  final RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadCars();
  }

  Future<void> checkIn(String carNumber) async {
    // Check if the car exists in the database
    final existingCar =
        await isar.cars.filter().carNumberEqualTo(carNumber).findFirst();

    if (existingCar == null) {
      // If the car does not exist, create a new entry
      final car = Car()
        ..carNumber = carNumber
        ..checkInTime = DateTime.now();
      await isar.writeTxn(() async {
        await isar.cars.put(car);
      });
      cars.add(car);
    } else {
      showCarDetailsBottomsheet(existingCar);
    }
  }

  Future<void> checkOut(Car car) async {
    car.checkOutTime = DateTime.now();
    await isar.writeTxn(() async {
      await isar.cars.put(car);
    });
    cars.remove(car);
  }

  Future<void> loadCars() async {
    isLoading.value = true;

    cars.value = await isar.cars.filter().checkOutTimeIsNull().findAll();
    Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
  }

  void showCarDetailsBottomsheet(Car car) {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Car Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Car Number: ${car.carNumber}'),
              Text(
                  'Checked In At: ${DateFormat('dd MMM, yyyy h:mm a').format(car.checkInTime)}'),
              Text(
                  'Checked Out At: ${car.checkOutTime != null ? DateFormat('dd MMM, yyyy h:mm a').format(car.checkOutTime!) : "Not checked out yet"}'),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  checkOut(car);
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
    );
  }
}
