import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_task/app/models/task.dart';
import 'package:flutter_application_task/app/repository/TaskRepository.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _taskList = [];
  final TaskRepository _taskRepository = TaskRepository();

  Future<void> fetchTasks() async {
    _taskList = await _taskRepository.getTasks();
    notifyListeners();
  }

  List<Task> get taskList => _taskList;

  onTaskDoneChange(Task task) {
    task.done = !task.done;
    _taskRepository.saveTasks(_taskList);
    notifyListeners();
  }

  void addNewTask(Task task) {
    _taskRepository.addTask(task);
    fetchTasks();
  }

  void removeTask(Task task) {
    _taskRepository.removeTask(task.title);
    fetchTasks();
  }

  void removeAllTasks() {
    _taskRepository.removeAllTasks();
    fetchTasks();
  }
}
