// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:instagram_image_picker/widgets/media_upload_widget.dart';
// import 'package:video_player/video_player.dart';
// import 'package:image_picker/image_picker.dart';

// class ReelDescriptionScreen extends StatefulWidget {
//   final XFile video;

//   const ReelDescriptionScreen({Key? key, required this.video})
//       : super(key: key);

//   @override
//   State<ReelDescriptionScreen> createState() => _ReelDescriptionScreenState();
// }

// class _ReelDescriptionScreenState extends State<ReelDescriptionScreen> {
//   late VideoPlayerController _videoController;
//   final TextEditingController _captionController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   String? _selectedCategory;
//   bool _isButtonEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _videoController = VideoPlayerController.file(File(widget.video.path))
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     super.dispose();
//   }

//   void _updateButtonState() {
//     setState(() {
//       _isButtonEnabled = _captionController.text.isNotEmpty &&
//           _selectedCategory != null &&
//           _locationController.text.isNotEmpty;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Post Video",
//             style: TextStyle(color: Colors.black, fontSize: 18)),
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 📹 Video Preview Section
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       Get.to(
//                           () => FullScreenVideoPage(videoFile: widget.video));
//                     },
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.circular(16.0),
//                           ),
//                           width: 168,
//                           height: 299,
//                         ),
//                         Positioned(
//                           child: Icon(
//                             Icons.play_circle_outline_rounded,
//                             color: Colors.white,
//                             size: 45,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // 📝 Caption Field
//                       // TextField(
//                       //   controller: _captionController,
//                       //   maxLines: 3,
//                       //   maxLength: 100,
//                       //   style: TextStyle(
//                       //       fontSize: 12,
//                       //       color: Colors.black),
//                       //   decoration: const InputDecoration(
//                       //     hintText: "Write a caption and add hashtags..",
//                       //     border: OutlineInputBorder(),
//                       //   ),
//                       //   onChanged: (_) => _updateButtonState(),
//                       // ),
//                       CaptionField(
//                                   controller: _captionController),

//                       const SizedBox(height: 10),

//                       // 🏷 Hashtag Selection
//                       const Text("Hashtags:",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                               color: Colors.black)),
//                       HashTagsWidget(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 10),

//             const Text("Select Category:",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: Colors.black)),

//             Row(
//               children: [
//                 const Icon(Icons.list, color: Colors.black),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: DropdownButton<String>(
//                     value: _selectedCategory,
//                     isExpanded: true,
//                     hint: const Text("(None)", style: TextStyle(fontSize: 14, color: Color(0xffBAB9B6))),
//                     items: ["Architecture", "Construction", "Interior Design", "Others"]
//                         .map((category) {
//                       return DropdownMenuItem(
//                         value: category,
//                         child: Text(category),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedCategory = value;
//                       });
//                     },
//                     icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const Text("Add Location:",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: Colors.black)),
//             TextField(
//               controller: _locationController,
//               style: TextStyle(fontSize: 12),
//               decoration: InputDecoration(
//                 hintText: "Add location...",
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 prefixIcon: const Icon(Icons.location_on, color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 5),
//             const Text(
//               "Add your location and unlock connections with people nearby",
//               style: TextStyle(fontSize: 12, color: Colors.grey),
//             ),
//             const SizedBox(height: 20),

//             // ✅ Confirm Button
//             ElevatedButton(
//               onPressed: _captionController.text.isNotEmpty ? () {} : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xffFFCE00),
//                 disabledBackgroundColor: Colors.grey.shade300,
//                 foregroundColor: Colors.white,
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text(
//                 "Confirm",
//                 style: TextStyle(color: Colors.black, fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_image_picker/widgets/media_upload_widget.dart';

class ReelDescriptionScreen extends StatefulWidget {
  final XFile videoFile;

  const ReelDescriptionScreen({super.key, required this.videoFile});

  @override
  State<ReelDescriptionScreen> createState() => _ReelDescriptionScreenState();
}

class _ReelDescriptionScreenState extends State<ReelDescriptionScreen> {
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final RxList<String> hashTagsList = <String>[].obs;
  final Set<String> selectedHashtags = {};
  final ScrollController _scrollController = ScrollController();
  String selectedCategory = "";
  final List<String> dropdownItems = [
    "Architecture",
    "Construction",
    "Interior Design",
    "Others"
  ];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    hashTagsList.value = [
      "floor",
      "flooringTile",
      "flooring",
      "tiles",
      "tileWork",
      "marble",
      "pattern",
      "marbleFloor",
      "tilesLayout",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Video",
            style: TextStyle(color: Colors.black, fontSize: 18)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Preview
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(() =>
                          FullScreenVideoPage(videoFile: widget.videoFile));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          width: 168,
                          height: 299,
                        ),
                        const Positioned(
                          child: Icon(
                            Icons.play_circle_outline_rounded,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12), // Added spacing between video and caption
                Expanded(
                  child: Column(
                    children: [
                      // Caption Field
                      CaptionField(controller: _captionController),
                      // Hashtags Selection
                      Obx(
                        () => Container(
                          width: MediaQuery.of(context).size.width,
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height * 0.17,
                            maxHeight: MediaQuery.of(context).size.height * 0.2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: const Color.fromRGBO(249, 249, 249, 1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Scrollbar(
                              controller: _scrollController,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                child: Wrap(
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  children: hashTagsList.map((tag) {
                                    final isSelected =
                                        selectedHashtags.contains(tag);
                                    return HashTagWidgetTag(
                                      text: "#$tag",
                                      isSelected: isSelected,
                                      onTapHashTag: () {
                                        setState(() {
                                          if (isSelected) {
                                            selectedHashtags.remove(tag);
                                          } else {
                                            selectedHashtags.add(tag);
                                          }
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            const Text("Select Category:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),
            // Category Selection
            ReelDropDownWidget(
              prefixIcon: const Icon(Icons.category, color: Colors.black),
              hintText: "(NONE)",
              value: selectedCategory,
              dropdownItems: dropdownItems,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 10),
            const Text("Add Location:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black)),

            // Select Location
            SelectLocationWidget(
              controller: _locationController,
              prefixIcon: const Icon(Icons.location_on, color: Colors.black),
              suffixIcon:
                  const Icon(Icons.arrow_drop_down, color: Colors.black),
              hintText: "Add location",
              onChanged: (value) {},
            ),
            SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: _captionController.text.isNotEmpty ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFFCE00),
                disabledBackgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
