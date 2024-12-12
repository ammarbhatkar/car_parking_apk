import 'package:carproject/controller/car_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'car_details_screen.dart';

class SearchScreen extends StatelessWidget {
  final CarController carController = Get.find();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Cars')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Enter Car Number',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Perform search logic
                    Get.to(() =>
                        CarDetailsScreen(carNumber: searchController.text));
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              final filteredCars = carController.cars
                  .where((car) => car.carNumber.contains(searchController.text))
                  .toList();
              if (filteredCars.isEmpty) {
                return Center(child: Text("No cars found."));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: filteredCars.length,
                  itemBuilder: (context, index) {
                    final car = filteredCars[index];
                    return ListTile(
                      title: Text(car.carNumber),
                      onTap: () {
                        Get.to(
                            () => CarDetailsScreen(carNumber: car.carNumber));
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
