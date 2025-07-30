import 'package:flutter/material.dart';

class NewTaskScreen extends StatefulWidget {
  final String selectedCategory;

  const NewTaskScreen({super.key, required this.selectedCategory});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  final List<String> _categories = [
    'Default',
    'Personal',
    'Shopping',
    'Wishlist',
    'Work',
    'Finished'
  ];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  void _addNewCategory(String newCat) {
    setState(() {
      _categories.add(newCat);
      _selectedCategory = newCat;
    });
  }

  void _showAddCategoryDialog() {
    String newCategory = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('New List'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter category name'),
          onChanged: (val) => newCategory = val,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (newCategory.isNotEmpty) {
                _addNewCategory(newCategory);
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }

  void _saveTask() {
    final title = _titleController.text.trim();
    final dueDate = _dueDateController.text.trim();
    final category = _selectedCategory ?? 'Default';

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    final newTask = {
      'title': title,
      'dueDate': dueDate,
      'category': category,
    };

    Navigator.pop(context, newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ⬅️ Clean white background
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0,
        title: const Text('New Task'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is to be done?',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            _buildTextField(_titleController, 'Task title'),
            const SizedBox(height: 20),
            const Text(
              'Due Date',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            _buildTextField(_dueDateController, 'Select due date'),
            const SizedBox(height: 20),
            const Text(
              'Add to List',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      dropdownColor: Colors.blue[100],
                      isExpanded: true,
                      underline: const SizedBox(),
                      style: const TextStyle(color: Colors.black87),
                      iconEnabledColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                      items: _categories
                          .map((cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(cat),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onPressed: _showAddCategoryDialog,
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _saveTask,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Save',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
