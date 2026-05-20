import 'package:flutter/material.dart';
import 'fragment_holder.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController idr = TextEditingController();
  TextEditingController namer = TextEditingController();
  TextEditingController bookr = TextEditingController();
  DateTime dueDate = DateTime.now();

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

  void addStudent() {
    FragmentHolder.students.add(
      StudentData(
        id: int.parse(idr.text),
        name: namer.text,
        bookName: bookr.text,
        dueDate: dueDate,
        submitted: false,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1C3A66),
        title: const Text("Add Student", style: TextStyle(color: Colors.white)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(45),

        child: Column(
          children: [
            TextField(
              controller: idr,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Student ID",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: namer,
              decoration: const InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: bookr,
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

            ElevatedButton(onPressed: addStudent, child: const Text("Add")),
          ],
        ),
      ),
    );
  }
}
