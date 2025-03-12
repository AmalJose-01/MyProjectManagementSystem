Overview
MyProjectManagementSystem is a task management application designed to help users organize, prioritize, and track their tasks effectively. It follows an MVVM architecture and integrates SwiftData for data persistence.


Setup Instructions

Prerequisites
Xcode (latest stable version recommended)
iOS 16.0+ SDK
Swift 5.0+


Cloning the Repository

git clone https://github.com/your-repo/MyProjectManagementSystem.git
cd MyProjectManagementSystem


Installing Dependencies

This project uses SwiftData for data persistence. Ensure all required dependencies are installed.
Open the project in Xcode.
Select "File" → "Packages" → "Update to Latest Package Versions".
Clean the build folder using:
Command + Shift + K
Build the project using:
Command + B


Running the App

Select an iOS simulator or a connected device.
Click "Run" (Command + R).


Running Unit & UI Tests

Command + U


Alternatively, manually run tests in Xcode's Test Navigator (Command + 6).


Design Rationale

1. MVVM Architecture

The app follows the MVVM (Model-View-ViewModel) architecture for better separation of concerns:

Model: Defines data structures (e.g., TaskModel).

ViewModel: Handles business logic and data transformations.

View: UI layer that observes ViewModel updates.

2. SwiftData for Persistence

Uses ModelContainer and ModelContext for managing tasks.

Ensures efficient data storage and retrieval with FetchDescriptor<TaskModel>.

3. Unit & UI Testing

Unit tests validate ViewModel logic.

UI tests ensure accessibility and user interactions.

Accessibility identifiers (e.g., accessibilityIdentifier("AddTaskButton")) enable test automation.

4. Mock Data Source for Testing

A MockItemDataSource replaces ItemDataSource for unit testing, allowing tests to run without modifying real data.

Contribution Guidelines

Fork the repository and create a new branch.

Follow the coding style and naming conventions.

Write unit tests for new features.

Submit a pull request with a detailed description.

License

This project is licensed under the MIT License - see the LICENSE file for details.
