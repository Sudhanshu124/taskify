# Taskify - To-Do Manager App

A beautiful and intuitive task management application built with Flutter, featuring modern UI design, smooth animations, and comprehensive task management capabilities.

## Features

- **Task Management**: Add, edit, delete, and organize your tasks
- **Task Status**: Mark tasks as complete or incomplete with visual feedback
- **Smart Filtering**: Filter tasks by All, Active, or Completed status
- **Data Persistence**: Tasks are saved locally using SharedPreferences
- **Modern UI**: Clean Material Design 3 interface with custom theming
- **Smooth Animations**: Engaging animations for task interactions
- **Custom Typography**: Inter font family for enhanced readability
- **Responsive Design**: Optimized for mobile devices
- **Custom Branding**: Professional launcher icons for Android and iOS

## Screenshots

The app features a modern interface with:
- Purple gradient theme (#6C63FF primary color)
- Clean task cards with completion indicators
- Floating action button for quick task creation
- Task statistics and filter tabs
- Smooth animations and transitions

## Architecture

Built using the **MVVM (Model-View-ViewModel)** pattern:

- **Model**: Task data structure with JSON serialization
- **View**: UI components and screens
- **ViewModel**: Business logic and state management using the Provider pattern

### Key Components

- `Task` - Core data model
- `TaskViewModel` - State management with ChangeNotifier
- `TaskListView` - Main screen with task list and filters
- `AddTaskView` - Task creation and editing screen
- `AppTheme` - Comprehensive theming system



## Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd taskify
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Building for Release

### Android APK
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```
## Features in Detail

### Task Management
- Create tasks with title and description
- Edit existing tasks
- Delete tasks with confirmation
- Mark tasks as complete/incomplete
- View task creation and completion timestamps

### Filtering System
- **All Tasks**: View all tasks regardless of status
- **Active Tasks**: View only incomplete tasks
- **Completed Tasks**: View only completed tasks
- Real-time task counters for each filter

### Data Persistence
- Tasks are automatically saved to local storage
- Data persists across app restarts
- Uses SharedPreferences for reliable storage

### UI/UX Features
- Custom color scheme with purple gradients
- Smooth animations for task interactions
- Visual feedback for task completion
- Professional typography with Inter font
- Responsive design for different screen sizes


### State Management
Uses Provider pattern with ChangeNotifier for reactive state management:
- Automatic UI updates when task data changes
- Efficient rebuilding of only affected widgets
- Clean separation of business logic and UI

### Theme System
Comprehensive theming with custom color extensions:
- Consistent color palette across the app
- Custom gradient implementations
- Material Design 3 compatibility

### Build Configuration
Optimized for both debug and release builds:
- Code shrinking only in release mode
- Efficient dependency management
- Platform-specific optimizations
### APK Link
- https://drive.google.com/file/d/12ioDPCYEc7T13WjcsYhVc6sD59KK5Rj5/view?usp=sharing

**Built with ❤️❤️❤️❤️❤️❤️❤️ using Flutter**
