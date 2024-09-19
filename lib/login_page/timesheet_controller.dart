import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimesheetController extends GetxController {
  RxString checkInTime = ''.obs;
  RxString checkOutTime = ''.obs;
  RxBool isSaveEnabled = false.obs;
  RxList<Map<String, String>> timesheets = <Map<String, String>>[].obs;

  void setCheckInTime() {
    checkInTime.value =
        DateFormat('hh:mm a, EEEE, dd MMMM yyyy').format(DateTime.now());
    isSaveEnabled.value = false;
  }

  void setCheckOutTime() {
    checkOutTime.value =
        DateFormat('hh:mm a, EEEE, dd MMMM yyyy').format(DateTime.now());
    isSaveEnabled.value = true;
  }

  void saveTimesheet() {
    timesheets.add({
      'date': DateFormat('dd MMMM yyyy').format(DateTime.now()),
      'checkIn': checkInTime.value,
      'checkOut': checkOutTime.value,
    });
    checkInTime.value = '';
    checkOutTime.value = '';
    isSaveEnabled.value = false;
  }

  // Calculate total working hours
  String get totalWorkingHours {
    int totalHours = 0;
    for (var timesheet in timesheets) {
      if (timesheet['checkIn'] != null && timesheet['checkOut'] != null) {
        DateTime checkIn = DateFormat('hh:mm a, EEEE, dd MMMM yyyy')
            .parse(timesheet['checkIn']!);
        DateTime checkOut = DateFormat('hh:mm a, EEEE, dd MMMM yyyy')
            .parse(timesheet['checkOut']!);
        totalHours += checkOut.difference(checkIn).inHours;
      }
    }
    return totalHours.toString();
  }
}
