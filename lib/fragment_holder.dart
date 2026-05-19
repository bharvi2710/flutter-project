class StudentData {
  int id;
  String name;
  String bookName;
  DateTime dueDate;
  bool submitted;

  StudentData({
    required this.id,
    required this.name,
    required this.bookName,
    required this.dueDate,
    required this.submitted,
  });
}

class FragmentHolder {
  static List<StudentData> students = [
    StudentData(
      id: 101,
      name: "Dhanvi",
      bookName: "Harry Potter",
      dueDate: DateTime.now(),
      submitted: true,
    ),

    StudentData(
      id: 102,
      name: "Bharvi",
      bookName: "Flutter Basics",
      dueDate: DateTime.now(),
      submitted: false,
    ),

    StudentData(
      id: 103,
      name: "Maitri",
      bookName: "Flutter",
      dueDate: DateTime.now(),
      submitted: false,
    ),

    StudentData(
      id: 104,
      name: "Sara",
      bookName: "Java",
      dueDate: DateTime(2026, 6, 12),
      submitted: false,
    ),

    StudentData(
      id: 105,
      name: "Tanvi",
      bookName: "Java",
      dueDate: DateTime(2026, 6, 12),
      submitted: false,
    ),
  ];
}
