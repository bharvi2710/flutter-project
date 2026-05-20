import 'package:flutter/material.dart';
import 'fragment_holder.dart';

class EditPage extends StatefulWidget {
  final StudentData student;

  const EditPage({super.key, required this.student});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController ide;
  late TextEditingController namee;
  late TextEditingController booke;
  late DateTime dueDate;

  @override
  void initState() {
    super.initState();

    ide = TextEditingController(text: widget.student.id.toString());
    namee = TextEditingController(text: widget.student.name);
    booke = TextEditingController(text: widget.student.bookName);
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
      widget.student.id = int.parse(ide.text);
      widget.student.name = namee.text;
      widget.student.bookName = booke.text;
      widget.student.dueDate = dueDate;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1C3A66),
        title: const Text(
          "Edit Student",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(45),

        child: Column(
          children: [
            TextField(
              controller: ide,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Student ID",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: namee,
              decoration: const InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: booke,
              decoration: const InputDecoration(
                labelText: "Book Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

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
