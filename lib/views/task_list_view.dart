import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';
import 'add_task_view.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskViewModel>().loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taskify',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: Theme.of(context).colorScheme.primaryGradient,
          ),
        ),
        foregroundColor: Colors.white,
        actions: [
          Consumer<TaskViewModel>(
            builder: (context, viewModel, child) {
              return PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (value) {
                  if (value == 'clear_completed') {
                    viewModel.clearCompleted();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'clear_completed',
                    child: Row(
                      children: [
                        Icon(Icons.clear_all, color: Theme.of(context).colorScheme.activeTaskColor),
                        const SizedBox(width: 8),
                        const Text('Clear Completed'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              Column(
                children: [
                  _buildFilterTabs(viewModel),
                  _buildTaskStats(viewModel),
                  Expanded(
                    child: viewModel.tasks.isEmpty
                        ? _buildEmptyState()
                        : _buildTaskList(viewModel),
                  ),
                ],
              ),
              // Celebration overlay
              if (viewModel.showCompletionCelebration)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.elasticOut,
                  top: MediaQuery.of(context).size.height * 0.3,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 500),
                      scale: viewModel.showCompletionCelebration ? 1.2 : 0.0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.successColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.successColor.withValues(alpha: 0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.celebration, color: Colors.white, size: 24),
                            SizedBox(width: 8),
                            Text(
                              'Task Completed!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: 1.0,
        child: FloatingActionButton(
          onPressed: () => _showAddTaskDialog(context),
          child: const Icon(Icons.add, size: 28),
        ),
      ),
    );
  }

  Widget _buildFilterTabs(TaskViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        gradient: Theme.of(context).colorScheme.surfaceGradient,
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterTab(
              'All',
              TaskFilter.all,
              viewModel.currentFilter == TaskFilter.all,
              viewModel,
            ),
          ),
          Expanded(
            child: _buildFilterTab(
              'Active',
              TaskFilter.active,
              viewModel.currentFilter == TaskFilter.active,
              viewModel,
            ),
          ),
          Expanded(
            child: _buildFilterTab(
              'Completed',
              TaskFilter.completed,
              viewModel.currentFilter == TaskFilter.completed,
              viewModel,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(
    String label,
    TaskFilter filter,
    bool isSelected,
    TaskViewModel viewModel,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: InkWell(
        onTap: () => viewModel.setFilter(filter),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.textSecondary,
              fontSize: isSelected ? 16 : 14,
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskStats(TaskViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total', viewModel.totalTasks, Theme.of(context).colorScheme.totalTaskColor),
          _buildStatItem('Active', viewModel.activeTasks, Theme.of(context).colorScheme.activeTaskColor),
          _buildStatItem('Completed', viewModel.completedTasks, Theme.of(context).colorScheme.completedTaskColor),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.elasticOut,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              child: Text(count.toString()),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 64,
            color: Theme.of(context).colorScheme.textHint,
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks yet',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add your first task',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(TaskViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.tasks.length,
      itemBuilder: (context, index) {
        final task = viewModel.tasks[index];
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 100)),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translate(0.0, 0.0)
            ..scale(1.0),
          child: _buildTaskItem(task, viewModel),
        );
      },
    );
  }

  Widget _buildTaskItem(Task task, TaskViewModel viewModel) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: task.isCompleted ? 2 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: task.isCompleted 
                ? Theme.of(context).colorScheme.completedTaskColor.withValues(alpha: 0.3)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: task.isCompleted
                ? Theme.of(context).colorScheme.completedGradient
                : null,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: task.isCompleted ? 1.1 : 1.0,
              child: Checkbox(
                value: task.isCompleted,
                onChanged: (_) => viewModel.toggleTaskCompletion(task.id),
                activeColor: Theme.of(context).colorScheme.completedTaskColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            title: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: task.isCompleted 
                    ? Theme.of(context).colorScheme.textSecondary 
                    : Theme.of(context).colorScheme.textPrimary,
                fontWeight: task.isCompleted 
                    ? FontWeight.normal 
                    : FontWeight.w600,
                fontSize: 16,
              ),
              child: Text(task.title),
            ),
            subtitle: task.description.isNotEmpty
                ? AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: task.isCompleted 
                          ? Theme.of(context).colorScheme.textHint 
                          : Theme.of(context).colorScheme.textSecondary,
                    ),
                    child: Text(task.description),
                  )
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => _showEditTaskDialog(context, task),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _showDeleteConfirmation(context, task, viewModel),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.activeTaskColor.withValues(alpha: 0.1),
                    foregroundColor: Theme.of(context).colorScheme.activeTaskColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const AddTaskView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  void _showEditTaskDialog(BuildContext context, Task task) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AddTaskView(task: task),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    Task task,
    TaskViewModel viewModel,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              viewModel.deleteTask(task.id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}