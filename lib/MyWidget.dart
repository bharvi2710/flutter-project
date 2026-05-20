import 'package:flutter/material.dart';

import 'fragment_holder.dart';
import 'edit_page.dart';

class MyWidget extends StatefulWidget {
  final VoidCallback refresh;

  const MyWidget({super.key, required this.refresh});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<StudentData> students = FragmentHolder.students;

  DateTime selectedDate = DateTime.now();

  List<StudentData> get filteredStudents {
    return students.where((student) {
      return student.dueDate.day == selectedDate.day &&
          student.dueDate.month == selectedDate.month &&
          student.dueDate.year == selectedDate.year;
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
      setState(() {
        selectedDate = pickedDate;
      });
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
                    return Card(
                      margin: const EdgeInsets.all(10),

                      child: Padding(
                        padding: const EdgeInsets.all(10),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person, color: Colors.blue),

                                const SizedBox(width: 20),

                                Text(
                                  filteredStudents[index].name,

                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Text("ID : ${filteredStudents[index].id}"),

                            Text("Book : ${filteredStudents[index].bookName}"),

                            Text(
                              "Due Date : "
                              "${filteredStudents[index].dueDate.day}/"
                              "${filteredStudents[index].dueDate.month}/"
                              "${filteredStudents[index].dueDate.year}",
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditPage(
                                          student: filteredStudents[index],
                                        ),
                                      ),
                                    );

                                    setState(() {});
                                    widget.refresh();
                                  },

                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),

                                const Text("Submitted"),

                                Checkbox(
                                  value: filteredStudents[index].submitted,

                                  onChanged: (value) {
                                    setState(() {
                                      filteredStudents[index].submitted =
                                          value!;
                                    });
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
