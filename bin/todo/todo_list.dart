import 'dart:io';

import 'todo.dart';

class ToDoList {
  final _items = <Task>[
    ToDo(
      id: 0,
      name: 'buy bread',
      category: 'goods',
    ),
    ToDo(
      id: 1,
      name: 'buy some sweets',
      category: 'goods',
    ),
    Remind(
      id: 2,
      name: 'wake up earlier',
      category: 'routine',
      dayOfTheWeek: DayOfTheWeek.monday,
    ),
    Repeat(
      id: 3,
      name: 'clean the house',
      category: 'routine',
      dayOfTheWeek: DayOfTheWeek.saturday,
    ),
    ToDo(
      id: 5,
      name: 'test it',
      category: '',
    ),
  ];

  void printCategories() {
    final categories = <String, List<Task>>{};
    for (var task in _items) {
      categories[task.category] ??= [];
      categories[task.category]!.add(task);
    }
    final sortedCategories = categories.keys.toList()..sort();

    for (var i = 0; i < sortedCategories.length; i++) {
      final category = sortedCategories[i];
      final itemCount = categories[category]!.length;
      final string = category.isEmpty
          ? 'Tasks without category: $itemCount'
          : "'$category' contains $itemCount tasks";
      print(string);
    }
  }

  void printTaskList() {
    if (_items.isEmpty) return;

    stdout.write("Input category name or 'a' for watching all: ");
    final category = stdin.readLineSync();
    final tasks = (category != 'a')
        ? _items.where((task) => task.category == category).toList()
        : _items..sort((one, other) => one.category.compareTo(other.category));

    print('ID\tTask');
    var currentCategory = category ?? '';
    for (var task in tasks) {
      if (task.category != currentCategory) {
        currentCategory = task.category;
        if (currentCategory.isNotEmpty) print(currentCategory);
      }
      print(task);
    }
  }

  void showTasks() {
    if (_items.isEmpty) return;

    stdout.write("Input category name or 'a' for watching all: ");
    final category = stdin.readLineSync();
    final tasks = (category != 'a')
        ? _items.where((task) => task.category == category).toList()
        : _items;
    tasks.sort((one, other) => one.category.compareTo(other.category));

    var currentCategory = category ?? '';
    for (var task in tasks) {
      if (task.category != currentCategory) {
        currentCategory = task.category;
        if (currentCategory.isNotEmpty) print('* $currentCategory:');
      }
      task.show();
    }
  }

  void addTasks() {
    do {
      final newTask = _taskCreator();
      if (newTask == null) {
        stdout.write('* ERROR! Try again? ( Y / N ): ');
      } else {
        _items.add(newTask);
        stdout.write('* DONE! Add one more? ( Y / N ): ');
      }
    } while (stdin.readLineSync()?.toUpperCase() == 'Y');
  }

  void removeTask() {
    stdout.write('Input task ID: ');
    final id = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
    _items.removeWhere((item) => item.id == id);
  }

  Task? _taskCreator() {
    final newId = _items.isEmpty ? 0 : _items.last.id + 1;

    stdout.write('Input task: ');
    final taskName = stdin.readLineSync();
    if (taskName == null) return null;

    stdout.write('Input category: ');
    final taskCategory = stdin.readLineSync();

    stdout.write('Need to be reminded of it? ( Y / N ): ');
    final needRemind = stdin.readLineSync()?.toUpperCase();

    if (needRemind == 'N') {
      return ToDo(
        id: newId,
        name: taskName,
        category: taskCategory ?? '',
      );
    }

    if (needRemind == 'Y') {
      for (var day in DayOfTheWeek.values) {
        print(' ${day.index + 1} ${day.name}');
      }

      stdout.write('Input the number of day: ');
      final day = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
      if (day < 1 || day > 7) return null;

      stdout.write('Remind every ${DayOfTheWeek.values[day - 1].name}? ( Y / N ): ');
      switch (stdin.readLineSync()?.toUpperCase()) {
        case 'Y':
          return Repeat(
            id: newId,
            name: taskName,
            category: taskCategory ?? '',
            dayOfTheWeek: DayOfTheWeek.values[day - 1],
          );
        case 'N':
          return Remind(
            id: newId,
            name: taskName,
            category: taskCategory ?? '',
            dayOfTheWeek: DayOfTheWeek.values[day - 1],
          );
      }
    }
    return null;
  }
}
