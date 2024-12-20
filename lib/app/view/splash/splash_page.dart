import 'package:flutter/material.dart';
import 'package:flutter_application_task/app/view/components/shape.dart';
import 'package:flutter_application_task/app/view/components/title.dart';
import 'package:flutter_application_task/app/view/home/inherited_widhets.dart';
import 'package:flutter_application_task/app/view/tasks/list/task_list_page.dart';

// Para pantalla completa usar ...Page
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
//Para una pantalla
    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            Shape(),
          ],
        ),
        SizedBox(height: 79),
        Image.asset("assets/images/onboarding-image.png",
            width: 180, height: 168),
        SizedBox(height: 99),
        TitleApp('Lista de Tareas'),
        Text('Por favor darle click al texto de abajo', style: TextStyle(
          color: SpecialColor.of(context).color
        )),
        SizedBox(height: 21),
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder:(context){
              return TaskListPage();
            } ));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
                'La mejor forma para que no se te olvide nada es anotarlo, Guardar tus tareas y ve completando poco a poco para aumentar tu productividad.',
                textAlign: TextAlign.center),
          ),
        )
      ],
    ));
  }
}
