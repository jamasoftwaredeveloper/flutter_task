import 'dart:convert';

import 'package:flutter_application_task/app/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class TaskRepository {
  Future<bool> addTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];

    // Verificar si la tarea ya existe en la lista comparando los IDs
    final taskExists = jsonTasks.any((jsonTask) {
      final existingTask = Task.fromJson(jsonDecode(jsonTask));
      return existingTask.title == task.title; // Compara por el ID
    });

    // Si la tarea no existe, agregarla a la lista
    if (!taskExists) {
      jsonTasks.add(jsonEncode(task.toJson()));
      return prefs.setStringList('tasks', jsonTasks);
    }

    // Si la tarea ya existe, no hacer nada
    return Future.value(true);
  }

  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];
    return jsonTasks
        .map((jsonTask) => Task.fromJson(jsonDecode(jsonTask)))
        .toList();
  }

  Future<bool> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = tasks.map((e) => jsonEncode(e.toJson())).toList();
    return prefs.setStringList('tasks', jsonTasks);
  }

  // Método para eliminar una tarea
  Future<bool> removeTask(String title) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getStringList('tasks') ?? [];

    // Filtrar la lista de tareas, eliminando la tarea con el taskId proporcionado
    final updatedTasks = jsonTasks.where((jsonTask) {
      final task = Task.fromJson(jsonDecode(jsonTask));
      return task.title != title; // Compara el ID para eliminar la tarea
    }).toList();

    // Guardar la lista actualizada de tareas en SharedPreferences
    return prefs.setStringList('tasks', updatedTasks);
  }

  // Método para eliminar todas las tareas
  Future<bool> removeAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    // Elimina completamente la clave 'tasks' de SharedPreferences
    return prefs.remove('tasks');
  }
}
