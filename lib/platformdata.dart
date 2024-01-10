import 'package:flutter/services.dart';

class PlatformData {
  // Set the method channel name.
  // Since it uses a domain name
  // it's more likely to be unique.
  // NOTE: Replace au.com.mydomain with your own domain name.

  static const _platformName = MethodChannel('au.com.mydomain.platformtutorialpart3/platforminfo');

  // IMPORTANT NOTE: Flutter method channels only support sending a single message at
  // a time - it doesn't support the streaming of data - use EventChannel or StreamChannel for this.
  //
  // In this demo project we are using THE SAME MethodChannel name to call two different platform
  // functions - this only works when we only call ONE function at a time and wait for its
  // Future to be returned, otherwise this is a big NO-NO.
  //
  // If you call two or more platform methods at the same time or calling the second method before
  // the first has returned a Future, then there is no guarantee that you will receive the expected
  // channel messages. YOU HAVE BEEN WARNED!

  // This method gets called when the 'Get Battery Level' button is pressed.
  static Future<String> getBatteryLevel() async {
    String batteryLevel = 'Unknown battery level.';
    try {
      // Here we are calling asynchronously
      // the platform method "getBatteryLevel" and
      // hoping to get a result indicating
      // the battery level percentage.
      final result =
        await _platformName.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      // Something went off the rails.
      // Display error message.
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    return(batteryLevel);
  }

  // This method gets called when the 'Get Computation Result'
  // button is pressed.
  // We are passing in two integer values which will be
  // put into a JSON structure which will then be passed
  // to the platform method 'getComputationResult'.
  static Future<String> getComputationResult(int x, int y) async {
    String computationResult = 'Unknown computation result.';
    try {
      // Computation  data passed to the platform code
      // as JSON structure.
      Map<String, dynamic> compData = {
        'compData_1': x,
        'compData_2': y,
      };

      // Here we are calling asynchronously
      // the platform method "getComputationResult" and
      // hoping to get a result indicating
      // the computation result.
      final result =
        await _platformName.invokeMethod<int>('getComputationResult', compData);
      computationResult = 'Computation result is $result';
    } on PlatformException catch (e) {
      // Something went off the rails.
      // Display error message.
      computationResult = "Failed to computation result: '${e.message}'.";
    }
    return( computationResult);
  }

}