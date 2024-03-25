import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/task_model.dart'; // Your Task model class

class FirebaseService {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');

  // Add a new task
  Future<void> addTask(Task task) async {
    await _tasksCollection.doc(task.id).set(task.toMap());
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    await _tasksCollection.doc(task.id).update(task.toMap());
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    await _tasksCollection.doc(taskId).delete();
  }

  // Get a single task by id
  Future<Task?> getTaskById(String taskId) async {
    var doc = await _tasksCollection.doc(taskId).get();
    return doc.exists ? Task.fromMap(doc.data() as Map<String, dynamic>) : null;
  }

  // Stream of tasks list, useful for real-time updates in the UI
  Stream<List<Task>> get tasksStream {
    return _tasksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }
}
