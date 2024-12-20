import 'package:flutter/material.dart';
import 'package:flutter_application_task/app/view/home/inherited_widhets.dart';
import 'package:flutter_application_task/app/view/splash/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF40B7AD);
    const textColor = Color(0xFF4A4A4A);
    const backgroundColor = Color(0xFFF5F5F5);
    return SpecialColor(
      color:Colors.redAccent,
      child:      MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primary),
            scaffoldBackgroundColor: backgroundColor,
            textTheme: Theme.of(context).textTheme.apply(
                fontFamily: "Poppins",
                bodyColor: textColor,
                displayColor: textColor),
            useMaterial3: true,
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor:  Colors.transparent
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                    )
                )
            )
        ),
        home: SplashPage(),
      )
    );
  }
}
