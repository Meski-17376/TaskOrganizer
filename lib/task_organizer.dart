import 'models/task_model.dart'; // Your Task model class

class TaskOrganizer {
  List<Task> sortTasksByDate(List<Task> tasks) {
    // Sorts tasks by due date
    tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return tasks;
  }

  List<Task> sortTasksByPriority(List<Task> tasks) {
    // Sorts tasks by priority
    // Assuming priority: 'High', 'Medium', 'Low'
    const priorityOrder = ['High', 'Medium', 'Low'];
    tasks.sort((a, b) => priorityOrder.indexOf(a.priority).compareTo(priorityOrder.indexOf(b.priority)));
    return tasks;
  }

  List<Task> filterTasksByPriority(List<Task> tasks, String priority) {
    // Filters tasks by a specific priority
    return tasks.where((task) => task.priority == priority).toList();
  }

  // Add more methods as needed for different sorting or filtering criteria
}
