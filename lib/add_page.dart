import 'package:flutter/material.dart';
import 'fragment_holder.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController idController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController bookController = TextEditingController();

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
        id: int.parse(idController.text),
        name: nameController.text,
        bookName: bookController.text,
        dueDate: dueDate,
        submitted: false,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( iconTheme: const IconThemeData(
    color: Colors.white, 
  ),
        backgroundColor: Color(0xFF1C3A66),
        title:const Text("Add Student",style: TextStyle(color: Colors.white,),)),

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

            const SizedBox(height: 20),

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

            ElevatedButton(onPressed: addStudent, child: const Text("Add")),
          ],
        ),
      ),
    );
  }
}
