import 'package:get/state_manager.dart';
import '../../api/interceptor.dart';

class TodoController extends GetxController {
  
  RxList<dynamic> tasks = <dynamic>[].obs;
  final isEdit = false.obs;
  final existingId = RxString('-1');
  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchTasks();
  }

  Future<dynamic> fetchTasks() async {
    isLoading.value = true;
    try {
      final response = await dio.get('/categories');
      if(response.statusCode == 200) {
        if(response.data is Map <String, dynamic>) {
          tasks.assignAll(response.data['results']); 
        }
      }
      print('response: ${response.statusCode}');
    } catch (error) {
      print('error: ${error}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrUpdateTasks(Map<String, dynamic> payload) async {
    try {
      if(isEdit.value) {
        await dio.post('/categories/${existingId.value}?_method=PUT', data: payload);
        final index = tasks.indexWhere((task) => task['id'] == existingId.value);
        if(index != -1) tasks[index] = {...tasks[index], "name": payload['name']};
        tasks.refresh();
      }
      final newTask = await dio.post('/categories', data: payload);
      print('newTask: ${newTask}');
      if(newTask.data is Map <String, dynamic>) {
        tasks.add(newTask.data['results']);
      }
    } catch(error) {
      print(error);
    } finally {
      isEdit.value = false;
      existingId.value = '-1';
    }
  } 

  Future<void> deleteTask(String taskId) async {
    try {
      final response = await dio.delete('/categories/${taskId}');
      print('tasks: ${tasks}');
      tasks.removeWhere((task) => task['id'] == taskId);
    } catch (error) {
      print(error);
    }
  }
}