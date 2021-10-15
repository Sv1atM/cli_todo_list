enum DayOfTheWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension DayOfTheWeekString on DayOfTheWeek {
  String get name {
    switch (this) {
      case DayOfTheWeek.monday:
        return 'Monday';
      case DayOfTheWeek.tuesday:
        return 'Tuesday';
      case DayOfTheWeek.wednesday:
        return 'Wednesday';
      case DayOfTheWeek.thursday:
        return 'Thursday';
      case DayOfTheWeek.friday:
        return 'Friday';
      case DayOfTheWeek.saturday:
        return 'Saturday';
      case DayOfTheWeek.sunday:
        return 'Sunday';
    }
  }
}

abstract class SomeInterfaceClass {
  void show();
}

abstract class Task implements SomeInterfaceClass {
  final int id;
  final String name;
  final String category;

  Task({
    required this.id,
    required this.name,
    required this.category,
  });

  @override
  String toString() => '$id\t$name';
}

class ToDo extends Task {
  ToDo({
    required int id,
    required String name,
    required String category,
  }) : super(
    id: id,
    name: name,
    category: category,
  );

  @override
  void show() => print("Don't forget to $name");
}

class Remind extends Task {
  final DayOfTheWeek dayOfTheWeek;

  Remind({
    required int id,
    required String name,
    required String category,
    required this.dayOfTheWeek,
  }) : super(
          id: id,
          name: name,
          category: category,
        );

  @override
  void show() => print('On ${dayOfTheWeek.name} you should $name');
}

class Repeat extends Remind {
  Repeat({
    required int id,
    required String name,
    required String category,
    required DayOfTheWeek dayOfTheWeek,
  }) : super(
          id: id,
          name: name,
          category: category,
          dayOfTheWeek: dayOfTheWeek,
        );

  @override
  void show() => print('Remember to $name every ${dayOfTheWeek.name}');
}
