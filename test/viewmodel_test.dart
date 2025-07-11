import 'package:flutter_test/flutter_test.dart';
import 'package:taskify/viewmodels/task_viewmodel.dart';

void main() {
  group('TaskViewModel Tests', () {
    late TaskViewModel viewModel;

    setUp(() {
      viewModel = TaskViewModel();
    });

    test('should start with empty tasks', () {
      expect(viewModel.tasks.isEmpty, true);
      expect(viewModel.totalTasks, 0);
      expect(viewModel.activeTasks, 0);
      expect(viewModel.completedTasks, 0);
    });

    test('should add tasks correctly', () async {
      await viewModel.addTask('Test Task 1');
      await viewModel.addTask('Test Task 2');
      
      expect(viewModel.totalTasks, 2);
      expect(viewModel.activeTasks, 2);
      expect(viewModel.completedTasks, 0);
      expect(viewModel.tasks.length, 2);
    });

    test('should filter tasks correctly', () async {
      // Add tasks
      await viewModel.addTask('Task 1');
      await viewModel.addTask('Task 2');
      await viewModel.addTask('Task 3');
      
      // Complete one task
      final firstTaskId = viewModel.tasks.first.id;
      await viewModel.toggleTaskCompletion(firstTaskId);
      
      expect(viewModel.totalTasks, 3);
      expect(viewModel.activeTasks, 2);
      expect(viewModel.completedTasks, 1);
      
      // Test All filter
      viewModel.setFilter(TaskFilter.all);
      expect(viewModel.tasks.length, 3);
      
      // Test Active filter
      viewModel.setFilter(TaskFilter.active);
      expect(viewModel.tasks.length, 2);
      expect(viewModel.tasks.every((task) => !task.isCompleted), true);
      
      // Test Completed filter
      viewModel.setFilter(TaskFilter.completed);
      expect(viewModel.tasks.length, 1);
      expect(viewModel.tasks.every((task) => task.isCompleted), true);
    });

    test('should toggle task completion correctly', () async {
      await viewModel.addTask('Test Task');
      final task = viewModel.tasks.first;
      
      expect(task.isCompleted, false);
      
      await viewModel.toggleTaskCompletion(task.id);
      expect(viewModel.tasks.first.isCompleted, true);
      
      await viewModel.toggleTaskCompletion(task.id);
      expect(viewModel.tasks.first.isCompleted, false);
    });

    test('should delete tasks correctly', () async {
      await viewModel.addTask('Task to delete');
      expect(viewModel.totalTasks, 1);
      
      final taskId = viewModel.tasks.first.id;
      await viewModel.deleteTask(taskId);
      
      expect(viewModel.totalTasks, 0);
      expect(viewModel.tasks.isEmpty, true);
    });
  });
}