import 'package:flutter/material.dart';

class SpecialColor extends InheritedWidget {
  const SpecialColor({super.key, required this.color, required super.child});

  final Color color;

  static SpecialColor of(BuildContext context){
    final result = context.dependOnInheritedWidgetOfExactType<SpecialColor>();
    if(result == null){
      throw Exception("SpecialColor not found");
    }
    return result;
  }

  @override
  bool updateShouldNotify(SpecialColor oldWidget) {
    return oldWidget.color != color;
  }
}
