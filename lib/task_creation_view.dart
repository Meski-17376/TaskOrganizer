import 'package:flutter/material.dart';
import 'models/task_model.dart'; // Your Task model
import 'task_controller.dart'; // Your TaskController
import 'firebase_service.dart';
class TaskCreationView extends StatefulWidget {
  const TaskCreationView({super.key});
  @override
  TaskCreationViewState createState() => TaskCreationViewState();
}

class TaskCreationViewState extends State<TaskCreationView> {
  final TaskController taskController = TaskController(FirebaseService());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  DateTime? _dueDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dueDate){
      setState(() {
        _dueDate = picked;
      });
  }
  }

  void _createTask() async {
    // Create a new task object
    Task newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate a unique ID
      title: _titleController.text,
      description: _descriptionController.text,
      dueDate: _dueDate ?? DateTime.now(), // Default to current date if not selected
      priority: _priorityController.text,
    );

    // Use taskController to add the task
    String result = await taskController.createTask(newTask);
    // Check if the widget is still in the tree
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
  }
    // Optionally, clear the fields or navigate away after task creation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _priorityController,
              decoration: const InputDecoration(labelText: 'Priority'),
            ),
            const SizedBox(height: 8),
            ListTile(
              title: Text('Due Date: ${_dueDate?.toString().substring(0, 10) ?? 'Not Set'}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDueDate(context),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createTask,
              child: const Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}
