import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostDescriptionScreen extends StatefulWidget {
  final XFile image;

  const PostDescriptionScreen({super.key, required this.image});

  @override
  _PostDescriptionScreenState createState() => _PostDescriptionScreenState();
}

class _PostDescriptionScreenState extends State<PostDescriptionScreen> {
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  List<String> hashtags = [
    "#floor",
    "#flooringTile",
    "#flooring",
    "#tiles",
    "#tileWork",
    "#marble",
    "#pattern",
    "#marbleFloor",
    "#tilesLayout",
  ];

  Set<String> selectedHashtags = {};

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text("Post Picture",
            style: TextStyle(color: Colors.black, fontSize: 18))),
        backgroundColor: Colors.white,
        elevation: 1, // Light Border Bottom
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Back button functionality
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Image Display
            Image.file(
              File(widget.image.path),
              width: 148,
              height: 299,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 18),

            // ✅ Caption Input
            TextField(
              controller: _captionController,
              maxLines: 2,
              style: TextStyle(fontSize: 12, color: Colors.black), // Set text size to 12
              decoration: InputDecoration(
                hintText: "Write a caption and add hashtags...",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (text) {
                setState(() {});
              },
            ),
            const SizedBox(height: 10),

            // ✅ Hashtags
            const Text("Hashtags:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black)),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300), // Add border
                borderRadius: BorderRadius.circular(16), // Rounded corners
              ),
              padding: const EdgeInsets.all(8), // Padding inside the container
              child: Wrap(
                spacing: 8,
                children: hashtags.map((tag) {
                  bool isSelected = selectedHashtags.contains(tag);
                  return ChoiceChip(
                    label: Text(
                      tag,
                      style: TextStyle(fontSize: 12),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedHashtags.add(tag);
                        } else {
                          selectedHashtags.remove(tag);
                        }
                      });
                    },
                    selectedColor: Colors.black,
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),

            // ✅ Category Dropdown
            const Text("Select Category:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
            
            Row(
              children: [
                const Icon(Icons.list, color: Colors.black), // Page icon
                const SizedBox(width: 8), // Space between icon and dropdown
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    hint: const Text("(None)", style: TextStyle(fontSize: 14, color: Color(0xffBAB9B6))),
                    items: ["Architecture", "Construction", "Interior Design", "Others"]
                        .map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black), // Added dropdown icon
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ✅ Location Input
            const Text("Add Location:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
            TextField(
              controller: _locationController,
              style: TextStyle(fontSize: 12), 
              decoration: InputDecoration(
                hintText: "Add location...",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                prefixIcon: const Icon(Icons.location_on, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Add your location and unlock connections with people nearby",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // ✅ Confirm Button
            ElevatedButton(
              onPressed: _captionController.text.isNotEmpty ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFFCE00),
                disabledBackgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Confirm", style: TextStyle(color: Colors.black, fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }
}
