import 'package:flutter/material.dart';
import 'task_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Default';
  bool isSearching = false;

  final List<String> categories = [
    'Default',
    'Personal',
    'Shopping',
    'Wishlist',
    'Work',
    'Finished',
    'New List',
  ];

  final TextEditingController _searchController = TextEditingController();

  void _handleCategoryChange(String? newCategory) {
    if (newCategory == 'New List') {
      _showNewListDialog();
    } else {
      setState(() {
        selectedCategory = newCategory!;
      });
    }
  }

  void _showNewListDialog() {
    String newListName = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter New List Name'),
        content: TextField(
          onChanged: (value) => newListName = value,
          decoration: const InputDecoration(hintText: 'New List'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (newListName.isNotEmpty) {
                setState(() {
                  categories.insert(categories.length - 1, newListName);
                  selectedCategory = newListName;
                });
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: isSearching
            ? TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              )
            : Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.check, color: Colors.blue),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: selectedCategory,
                    dropdownColor: Colors.blue, // Blue dropdown background
                    style: const TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.white,
                    underline: const SizedBox(),
                    items: categories
                        .map((cat) => DropdownMenuItem<String>(
                              value: cat,
                              child: Text(cat),
                            ))
                        .toList(),
                    onChanged: _handleCategoryChange,
                  ),
                ],
              ),
        actions: [
          isSearching
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      _searchController.clear();
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
      body: TaskPage(category: selectedCategory),
    );
  }
}
