import 'package:elegant_notification/resources/arrays.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_task/app/repository/TaskRepository.dart';
import 'package:flutter_application_task/app/view/components/shape.dart';
import 'package:flutter_application_task/app/view/components/title.dart';
import 'package:flutter_application_task/app/models/task.dart';
import 'package:flutter_application_task/app/view/tasks/list/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:elegant_notification/elegant_notification.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TaskProvider()..fetchTasks(),
        child: Scaffold(
            appBar: AppBar(
              title: Text('Creación de tarea'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(),
                // Botón de salir
                Expanded(
                  child: _TaskList(),
                )
              ],
            ),
            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () => _showNewTaskModal(context),
                child: const Icon(Icons.add, size: 50),
              ),
            )));
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => ChangeNotifierProvider.value(
              value: context.read<TaskProvider>(),
              child: _NewTaskModal(),
            ));
  }
}

class _NewTaskModal extends StatelessWidget {
  _NewTaskModal({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 33, vertical: 23),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleApp("Nueva tarea"),
          SizedBox(height: 26),
          TextField(
            controller: _controller,
            onSubmitted: (value) {
              final task = Task(value);
              context.read<TaskProvider>().addNewTask(task);
              Navigator.of(context).pop();
              ElegantNotification.success(
                description: Text("Agregado correctament"),
                position: Alignment.bottomRight,
                height: 50,
              ).show(context);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              hintText: "Descripción de la tarea",
            ),
          )
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem(this.task, {super.key, this.onTap});

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 9, // Esto ocupa 10 partes del espacio total
          child: GestureDetector(
            onTap: onTap,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21)),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 18),
                  child: Row(
                    children: [
                      Icon(
                          task.done
                              ? Icons.check_box_rounded
                              : Icons.check_box_outline_blank,
                          color: Theme.of(context).colorScheme.primary),
                      SizedBox(width: 10),
                      Text(task.title)
                    ],
                  )),
            ),
          )),
      SizedBox(width: 10),
      Expanded(
        flex: 3, // Esto ocupa 2 partes del espacio total
        child: GestureDetector(
          onTap: onTap,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centrar en el eje horizontal
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Centrar en el eje vertical
                children: [
                  Center(
                    child: IconButton(
                        onPressed: () {
                          context.read<TaskProvider>().removeTask(task);
                          ElegantNotification.error(
                                  description: Text("Eliminado correctamente"),
                                  position: Alignment.bottomRight,
                                  height: 50)
                              .show(context);
                        },
                        icon: Icon(Icons.delete,
                            color: Theme.of(context).colorScheme.error)),
                  )
                ],
              )),
        ),
      ),
    ]);
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          Row(children: [Shape()]),
          Column(
            children: [
              Image.asset(
                'assets/images/tasks-list-image.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 16),
              TitleApp('Completa tus tareas', color: Colors.white),
              SizedBox(height: 16),
            ],
          )
        ],
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 12, // Esto ocupa 10 partes del espacio total
                  child: TitleApp('Lista de tareas'),
                ),
              ],
            ),
            Expanded(child: Consumer<TaskProvider>(builder: (_, provider, __) {
              if (provider.taskList.isEmpty) {
                return Center(child: Text("No hay tareas"));
              }
              return ListView.separated(
                itemCount: provider.taskList.length,
                separatorBuilder: (_, __) => SizedBox(height: 5),
                itemBuilder: (_, index) =>
                    _TaskItem(provider.taskList[index], onTap: () {
                  provider.onTaskDoneChange(provider.taskList[index]);
                }),
              );
            }))
          ],
        ));
  }
}
