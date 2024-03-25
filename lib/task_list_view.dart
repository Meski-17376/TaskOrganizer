import 'package:flutter/material.dart';
import 'models/task_model.dart'; // Import your Task model
import 'task_controller.dart'; // Import your TaskController
import 'firebase_service.dart'; // Import your FirebaseService

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});
  @override
  TaskListViewState createState() => TaskListViewState();
}

class TaskListViewState extends State<TaskListView> {
  late final TaskController taskController;

  @override
  void initState() {
    super.initState();
    // Assuming FirebaseService is already initialized and accessible
    taskController = TaskController(FirebaseService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: StreamBuilder<List<Task>>(
        stream: taskController.tasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Task task = snapshot.data![index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                // Add more UI elements or actions here as needed
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add action to add a new task
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
