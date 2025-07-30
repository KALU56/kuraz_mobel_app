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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('What is to be done?', style: TextStyle(fontSize: 16)),
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Task title'),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Due Date', style: TextStyle(fontSize: 16)),
            ),
            TextField(
              controller: _dueDateController,
              decoration: const InputDecoration(hintText: 'Select date'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Add to List: ', style: TextStyle(fontSize: 16)),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
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
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _showAddCategoryDialog,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
