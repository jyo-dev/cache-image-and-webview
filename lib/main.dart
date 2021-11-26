import 'package:bsbt/screens/listing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp()
      // MultiProvider(
      //   providers: [ChangeNotifierProvider.value(value: dataProvider())],
      //   child: MyApp(),
      // ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () {
        
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: TextTheme(
                //To support the following, you need to use the first initialization method
                button: TextStyle(fontSize: 45.sp)),
            primarySwatch: Colors.blue,
          ),
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => const ListingScreen(),
            // When navigating to the "/second" route, build the SecondScreen widget.
          },
        );
      },
    );
  }
}
