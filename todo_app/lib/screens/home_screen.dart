import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

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
              onPressed: () => Navigator.pop(context),
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

  Widget _buildNormalAppBar() {
    return Row(
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

        // Dropdown for categories
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
    );
  }

  Widget _buildSearchAppBar() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            setState(() {
              isSearching = false;
              searchController.clear();
            });
          },
        ),
        const Icon(Icons.search, color: Colors.black),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 16),
            onChanged: (value) {
              print("Searching for: $value");
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 16,
        title: isSearching ? _buildSearchAppBar() : _buildNormalAppBar(),
        actions: isSearching
            ? null
            : [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
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
