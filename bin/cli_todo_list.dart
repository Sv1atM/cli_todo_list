import 'dart:io';

import 'todo/todo_list.dart';

void main() {
  final list = ToDoList();
  final routes = {
    'Print categories': list.printCategories,
    'Print task list': list.printTaskList,
    'Show tasks': list.showTasks,
    'Add tasks': list.addTasks,
    'Remove task': list.removeTask,
  };
  String userAnswer;

  print('DART CLI ToDo List');
  stdout.writeln();
  do {
    for (var i = 0; i < routes.length; i++) {
      print('${i + 1}\t${routes.keys.elementAt(i)}');
    }
    print('e\tExit');

    userAnswer = stdin.readLineSync() ?? '';
    final index = int.tryParse(userAnswer) ?? 0;
    if (index > 0 && index <= routes.length) {
      stdout.writeln();
      routes.values.elementAt(index - 1).call();
    }

    stdout.writeln();
  } while (userAnswer != 'e');
}
