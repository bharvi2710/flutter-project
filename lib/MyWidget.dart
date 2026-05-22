import 'package:flutter/material.dart';
import 'edit_page.dart';
import 'fragment_holder.dart';

class MyWidget extends StatefulWidget {
  final List<StudentData> students;
  final VoidCallback onUpdate;

  const MyWidget({
    super.key,
    required this.students,
    required this.onUpdate,
  });

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  DateTime selectedDate = DateTime.now();

  List<StudentData> get filteredStudents {
    return widget.students.where((s) {
      return s.dueDate.day == selectedDate.day &&
          s.dueDate.month == selectedDate.month &&
          s.dueDate.year == selectedDate.year;
    }).toList();
  }

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: pickDate,
                child: Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: filteredStudents.isEmpty
              ? const Center(child: Text("No Data Found"))
              : ListView.builder(
                  itemCount: filteredStudents.length,
                  itemBuilder: (context, index) {
                    final student = filteredStudents[index];

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person,
                                    color: Colors.blue),
                                const SizedBox(width: 20),
                                Text(
                                  student.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text("ID : ${student.id}"),
                            Text("Book : ${student.bookName}"),
                            Text(
                              "Due Date : ${student.dueDate.day}/"
                              "${student.dueDate.month}/"
                              "${student.dueDate.year}",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            EditPage(student: student),
                                      ),
                                    );
                                    widget.onUpdate();
                                  },
                                ),
                                const Text("Submitted"),
                                Checkbox(
                                  value: student.submitted,
                                  onChanged: (v) {
                                    setState(() {
                                      student.submitted = v!;
                                    });
                                    widget.onUpdate();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}