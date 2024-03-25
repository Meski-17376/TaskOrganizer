import 'models/task_model.dart';  // Your Task model class
import 'firebase_service.dart';  // Your FirebaseService class

class TaskController {
  final FirebaseService _firebaseService;

  TaskController(this._firebaseService);

  Stream<List<Task>> get tasks => _firebaseService.tasksStream;

  Future<String> createTask(Task task) async {
    try {
      await _firebaseService.addTask(task);
      return 'Task created successfully';
    } catch (e) {
      return 'Error creating task: $e';
    }
  }

  Future<String> updateTask(Task task) async {
    try {
      await _firebaseService.updateTask(task);
      return 'Task updated successfully';
    } catch (e) {
      return 'Error updating task: $e';
    }
  }

  Future<String> deleteTask(String taskId) async {
    try {
      await _firebaseService.deleteTask(taskId);
      return 'Task deleted successfully';
    } catch (e) {
      return 'Error deleting task: $e';
    }
  }

  Future<Task?> getTaskById(String taskId) async {
    try {
      return await _firebaseService.getTaskById(taskId);
    } catch (e) {
      print('Error getting task: $e');
      return null;
    }
  }

  // Sort tasks by date or priority
  List<Task> sortTasks(List<Task> tasks, String sortBy) {
    if (sortBy == 'date') {
      tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } else if (sortBy == 'priority') {
      const priorityOrder = ['High', 'Medium', 'Low'];
      tasks.sort((a, b) => priorityOrder.indexOf(a.priority).compareTo(priorityOrder.indexOf(b.priority)));
    }
    return tasks;
  }

  // Filter tasks by priority
  List<Task> filterTasksByPriority(List<Task> tasks, String? priority) {
    if (priority == null) return tasks;
    return tasks.where((task) => task.priority == priority).toList();
  }

  // Add methods for createTask, updateTask, deleteTask, getTaskById...

  // Example method that combines filtering and sorting
  Stream<List<Task>> getFilteredAndSortedTasks(String? filterPriority, String sortBy) {
    return _firebaseService.tasksStream.map((tasks) {
      var filteredTasks = filterTasksByPriority(tasks, filterPriority);
      return sortTasks(filteredTasks, sortBy);
    });
  }
}
