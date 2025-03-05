import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:todo_app/views/widgets/icon_button.dart';

import '../../controllers/todo/todo_controller.dart';
import '../widgets/custom_button.dart';

class GetxTodoPage extends StatelessWidget {

  final TodoController todoController = Get.put(TodoController());
  final TextEditingController task_name = TextEditingController();
  GetxTodoPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo using Getx'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child : 
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: task_name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Create Task'
                      ),
                    )
                  ),
                  SizedBox(height: 10, width: 8),
                  Obx(() {
                    return CustomButton(
                      name: todoController.isEdit.value ? 'Update' : 'Add', 
                      method: () async {
                        await todoController.createOrUpdateTasks({ "name": task_name.text.trim()});
                        task_name.clear();
                      } 
                    );
                  })
                ],
              ),
              Expanded(
                child: Obx(() {
                  print('todoController.tasks: ${todoController.tasks}');
                  if(todoController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if(todoController.tasks.isEmpty) {
                    return Center(child: Text('No tasks exists'));
                  }

                  return ListView.builder(
                    itemCount: todoController.tasks.length,
                    itemBuilder: (context, index) {
                      final task = todoController.tasks[index];
                      print('task: ${task}');
                      return ListTile(
                        title: Text(task['name']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconButton(
                              icon: Icon(Icons.edit, color: Colors.blue), 
                              method: () {
                                todoController.isEdit.value = true;
                                todoController.existingId.value = task['id'];
                                task_name.text = task['name'];
                              } 
                            ),
                            CustomIconButton(
                              icon: Icon(Icons.delete, color: Colors.red), 
                              method: () => todoController.deleteTask(task['id'])
                            ),
                          ],
                        ),
                      );
                    }
                  );
                }),
              ),
            ],
          ),
      )
    );
  }
}