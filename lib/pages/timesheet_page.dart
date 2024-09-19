import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_page/timesheet_controller.dart'; // Import the controller

class TimesheetPage extends StatelessWidget {
  final TimesheetController controller = Get.put(TimesheetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              color: Colors.blue, // Customize the container color as needed
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Navigate to the previous page
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Timesheet Page',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Welcome, Pradeep-JT08',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: controller.setCheckInTime,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Obx(
                                () => Text(
                                  controller.checkInTime.isEmpty
                                      ? "Check-In"
                                      : controller.checkInTime.value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.setCheckOutTime,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Obx(
                                () => Text(
                                  controller.checkOutTime.isEmpty
                                      ? "Check-Out"
                                      : controller.checkOutTime.value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Space between containers and button
                    Obx(
                      () => ElevatedButton(
                        onPressed: controller.isSaveEnabled.value
                            ? controller.saveTimesheet
                            : null, // Enable or disable button
                        child: Text('Save'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          disabledForegroundColor:
                              Colors.grey.withOpacity(0.38),
                          disabledBackgroundColor:
                              Colors.grey.withOpacity(0.12), // Disabled color
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Space before the table
                    Expanded(
                      child: SingleChildScrollView(
                        child: Obx(
                          () => DataTable(
                            columns: const [
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Check-In')),
                              DataColumn(label: Text('Check-Out')),
                            ],
                            rows: controller.timesheets.map((timesheet) {
                              return DataRow(cells: [
                                DataCell(
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(timesheet['date'] ?? ''),
                                  ),
                                ),
                                DataCell(
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(timesheet['checkIn'] ?? ''),
                                  ),
                                ),
                                DataCell(
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(timesheet['checkOut'] ?? ''),
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Obx(
                                () => Text(
                                  "Total Working Hours: ${controller.totalWorkingHours}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
