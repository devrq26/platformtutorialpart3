# platformtutorialpart3

This Flutter project demonstrates how to make platform specific API calls, 
as well as how to call your own platform-specific function to process arbitrary 
data passed into the platform function and have a value returned.

It is based on my LinkedIn article "Interfacing Flutter With Native Platforms - Parts 1 and 2"
URL: https://www.linkedin.com/pulse/interfacing-flutter-native-platforms-parts-1-2-reinhold-quillen-foe0c

This project is part 3 of the above-mentioned article and it shows how you could use a single platform channel name to call multiple platform methods. There is a big GOTCHA however and you should read below:

IMPORTANT NOTE: Flutter method channels only support sending a single message at
a time - it doesn't support the streaming of data - use EventChannel or StreamChannel for this.

In this demo project we are using THE SAME MethodChannel name to call two different platform
functions - this only works when we only call ONE function at a time and wait for its
Future to be returned, otherwise this is a big NO-NO.

If you call two or more platform methods at the same time or calling the second method before
the first has returned a Future, then there is no guarantee that you will receive the expected
channel messages. YOU HAVE BEEN WARNED!