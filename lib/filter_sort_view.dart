import 'package:flutter/material.dart';
import 'task_controller.dart'; // Your TaskController
import 'firebase_service.dart';
import 'models/task_model.dart';
class FilterSortTaskListView extends StatefulWidget {
  const FilterSortTaskListView({super.key});
  @override
  FilterSortTaskListViewState createState() => FilterSortTaskListViewState();
}

class FilterSortTaskListViewState extends State<FilterSortTaskListView> {
  Stream<List<Task>>? _filteredSortedTasks;
  final TaskController taskController = TaskController(FirebaseService());
  String _selectedSort = 'date'; // Default sort option
  String? _selectedFilter; // Default filter option

  @override
  void initState() {
    super.initState();
    _applyFilterAndSort(_selectedFilter, _selectedSort);
  }

  void _applyFilterAndSort(String? filter, String sort) {
    setState(() {
      _selectedFilter = filter;
      _selectedSort = sort;
      _filteredSortedTasks = taskController.getFilteredAndSortedTasks(filter, sort);
    });
  }

  void _showFilterSortDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Filter and Sort"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dropdown or other widgets for selecting sort and filter options
              DropdownButton<String>(
                value: _selectedSort,
                onChanged: (newValue) => setState(() => _selectedSort = newValue!),
                items: ['date', 'priority'].map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('Sort by $value'),
                  );
                }).toList(),
              ),
              DropdownButton<String?>(
                value: _selectedFilter,
                onChanged: (newValue) => setState(() => _selectedFilter = newValue),
                items: <String?>['High', 'Medium', 'Low', null]
                    .map<DropdownMenuItem<String?>>((value) {
                  return DropdownMenuItem<String?>(
                    value: value,
                    child: Text('Filter by priority: ${value ?? "None"}'),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Apply'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _applyFilterAndSort(_selectedFilter, _selectedSort);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterSortDialog,
          ),
        ],
      ),
       body: StreamBuilder<List<Task>>(
        stream: _filteredSortedTasks, // Using the filtered and sorted tasks stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks found'));
          }

          List<Task> tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                // Implement other list tile properties and actions
              );
            },
          );
        },
      ),
    );
  }
}
