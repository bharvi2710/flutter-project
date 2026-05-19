import 'package:flutter/material.dart';
import 'fragment_holder.dart';

class EditPage extends StatefulWidget {
  final StudentData student;

  const EditPage({super.key, required this.student});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController idController;

  late TextEditingController nameController;

  late TextEditingController bookController;

  late DateTime dueDate;

  @override
  void initState() {
    super.initState();

    idController = TextEditingController(text: widget.student.id.toString());

    nameController = TextEditingController(text: widget.student.name);

    bookController = TextEditingController(text: widget.student.bookName);

    dueDate = widget.student.dueDate;
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        dueDate = picked;
      });
    }
  }

  void updateStudent() {
    setState(() {
      widget.student.id = int.parse(idController.text);

      widget.student.name = nameController.text;

      widget.student.bookName = bookController.text;

      widget.student.dueDate = dueDate;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Student")),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: "Student ID",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nameController,

              decoration: const InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: bookController,

              decoration: const InputDecoration(
                labelText: "Book Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: pickDate,
              child: Text("${dueDate.day}/${dueDate.month}/${dueDate.year}"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: updateStudent,
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
