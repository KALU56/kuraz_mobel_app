import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Personal',
    'Shopping',
    'Wishlist',
    'Work',
    'Finished',
    'New List',
  ];

  void _onCategorySelected(String? value) {
    if (value == 'New List') {
      _showNewListDialog();
    } else if (value != null) {
      setState(() {
        selectedCategory = value;
      });
      print('Navigate to: $value');
    }
  }

  void _showNewListDialog() {
    String newListName = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("New List"),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: "Enter list name"),
            onChanged: (value) {
              newListName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (newListName.isNotEmpty) {
                  setState(() {
                    selectedCategory = newListName;
                    categories.insert(categories.length - 1, newListName);
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Create"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100], // Blue screen background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 16,
        title: Row(
          children: [
            // Blue circle with check icon
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.check, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),

            // Dropdown menu
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedCategory,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                onChanged: _onCategorySelected,
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              print('Search clicked');
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              print("Selected menu: $value");
            },
            itemBuilder: (BuildContext context) {
              return ['Settings', 'Help', 'About'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Showing tasks for: $selectedCategory',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
