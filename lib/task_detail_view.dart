import 'package:flutter/material.dart';
import 'models/task_model.dart'; // Your Task model
import 'task_controller.dart'; // Your TaskController
import 'firebase_service.dart';
class TaskDetailView extends StatefulWidget {
   final Task task; // The task to display and edit

const TaskDetailView({super.key, required this.task});


  @override
  TaskDetailViewState createState() => TaskDetailViewState();
}

class TaskDetailViewState extends State<TaskDetailView> {
  late final TaskController taskController;
  late Task editableTask;

  @override
  void initState() {
    super.initState();
    taskController = TaskController(FirebaseService());
    editableTask = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title: ${editableTask.title}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Description: ${editableTask.description}'),
            const SizedBox(height: 8),
            // Add more task details here
            // Optionally include edit fields or buttons for updating task details
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add actions for editing/updating the task
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
