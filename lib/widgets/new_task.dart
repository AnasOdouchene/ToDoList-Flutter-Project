import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this for date formatting
import 'package:todolist_app/models/task.dart'; // Import your task model

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Method to show date picker
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitTaskData() {
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text(
              'Merci de remplir tous les champs avant de sauvegarder la tâche'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    // Add logic to handle submission
    // Example: You could call a function passed from the parent widget to add the task

    Navigator.pop(context); // Close the modal after saving
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: _descriptionController,
            maxLength: 200,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'Aucune date nest choisie !'
                      : ' ${DateFormat.yMd().format(_selectedDate!)}',
                ),
              ),
              TextButton(
                onPressed: _presentDatePicker,
                child: const Text(
                  'Choisir une date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButton<Category>(
            value: _selectedCategory,
            items: Category.values.map((Category category) {
              return DropdownMenuItem<Category>(
                value: category,
                child: Text(category.name.toUpperCase()),
              );
            }).toList(),
            onChanged: (Category? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitTaskData,
            child: const Text('Save Task'),
          ),
        ],
      ),
    );
  }
}
