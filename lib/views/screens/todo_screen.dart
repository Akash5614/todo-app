import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/icon_button.dart';
import '../../api/interceptor.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenPage();
}

class _TodoScreenPage extends State<TodoScreen> {
  final TextEditingController _taskController = TextEditingController();
  final StreamController <List<dynamic>> _streamController = StreamController<List<dynamic>>();

  bool _isEditing = false;
  String? _taskId;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _taskController.dispose();
    _streamController.close();
    super.dispose();
  }

  Future<dynamic> fetchData() async {
    try {
      final response = await dio.get('/categories/lists');
      if(response.data is Map <String, dynamic> && response.data['results'] != null) {
        final List<dynamic> tasks = response.data['results'];
        _streamController.add(tasks);
      }  else {
        _streamController.add([]);
      }
      print('responsess: ${response.data}');
    } catch(err) {
      print('err: ${err}');
    }
  }

  Future<dynamic> _addTask() async {
    String task = _taskController.text.trim();
    if (task.isNotEmpty) {
      if(_isEditing && _taskId != null) {
        await dio.post('/categories/${_taskId}?_method=PUT', data: { 'name': task});
      } else {
        final response = await dio.post('/categories', data: { 'name': task });
        print('response: ${response}');
      }
      fetchData();
      _taskController.clear();
      setState(() {
        _isEditing = false;
        _taskId = null;
      });
    } else {
      print('Task cannot be empty');
    }
  }

  void _editTask(id,label) {
    setState(() {
      _isEditing = true;
      _taskId = id;
      _taskController.text = label;
    });
  }

  Future<dynamic> _deleteTask(id) async {
    try {
      final response = await dio.delete('/categories/${id}');
      fetchData();
    } catch(err) {
      print('err: ${err}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: 'Create Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CustomButton(name: _isEditing ? 'Update' : 'Add', method: _addTask),
              ],
            ),
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                stream: _streamController.stream, 
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if(snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } 

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No tasks available'));
                  }

                  final tasks = snapshot.data!;
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tasks[index]['label']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              method: () =>  _editTask(tasks[index]['value'], tasks[index]['label']),
                            ),
                            CustomIconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              method: () => _deleteTask(tasks[index]['value']),
                            )
                          ],
                        ),
                      );
                    }
                  );
                }
              )
            )
          ],
        ),
      ),
    );
  }
}
