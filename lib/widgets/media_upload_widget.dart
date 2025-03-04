import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class HashTagsWidget extends StatefulWidget {
  const HashTagsWidget({Key? key}) : super(key: key);

  @override
  State<HashTagsWidget> createState() => _HashTagsWidgetState();
}

class _HashTagsWidgetState extends State<HashTagsWidget> {
  final RxList<String> hashTagsList = <String>[].obs;
  final ScrollController _scrollController = ScrollController();
  final RxSet<String> selectedHashtags = <String>{}.obs;

  final List<String> hashtags = [
    "floor",
    "flooringTile",
    "flooring",
    "tiles",
    "tileWork",
    "marble",
    "pattern",
    "marbleFloor",
    "tilesLayout"
  ];

  @override
  void initState() {
    super.initState();
    hashTagsList.assignAll(hashtags);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.17,
        maxHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: const Color.fromRGBO(249, 249, 249, 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() => Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: hashTagsList.map((tag) {
                    final isSelected = selectedHashtags.contains(tag);
                    return InkWell(
                      onTap: () => setState(() {
                        isSelected
                            ? selectedHashtags.remove(tag)
                            : selectedHashtags.add(tag);
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: isSelected ? Colors.black : Colors.grey),
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 1.0),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )),
      ),
    );
  }
}

class HashTagWidgetTag extends StatelessWidget {
  final Function() onTapHashTag;
  final String text;
  final bool isSelected;
  const HashTagWidgetTag({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTapHashTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapHashTag,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.black : Colors.grey),
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
          child: Text(
            text,
            maxLines: 10,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

//fullscreen video player
class FullScreenVideoPage extends StatefulWidget {
  final XFile videoFile;

  const FullScreenVideoPage({super.key, required this.videoFile});

  @override
  FullScreenVideoPageState createState() => FullScreenVideoPageState();
}

class FullScreenVideoPageState extends State<FullScreenVideoPage> {
  late VideoPlayerController _videoController;
  bool isVideoEnded = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(File(widget.videoFile.path))
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
      });
    _videoController.addListener(() {
      if (_videoController.value.position >= _videoController.value.duration) {
        setState(() {
          isVideoEnded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _videoController.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  )
                : CircularProgressIndicator(color: Colors.white),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () => Get.back(),
              child:
                  Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(
          isVideoEnded || !_videoController.value.isPlaying
              ? Icons.play_arrow
              : Icons.pause,
          color: Colors.black,
        ),
        onPressed: () {
          setState(() {
            if (isVideoEnded) {
              _videoController.seekTo(Duration.zero);
              isVideoEnded = false;
              _videoController.play();
            } else {
              _videoController.value.isPlaying
                  ? _videoController.pause()
                  : _videoController.play();
            }
          });
        },
      ),
    );
  }
}

class SelectLocationWidget extends StatefulWidget {
  final TextEditingController controller;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String hintText;
  final double? height;
  final Color? containerColor;
  final Function(String value) onChanged;

  const SelectLocationWidget({
    Key? key,
    required this.controller,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.hintText,
    this.height,
    required this.onChanged,
    this.containerColor,
  }) : super(key: key);

  @override
  State<SelectLocationWidget> createState() => _SelectLocationWidgetState();
}

class _SelectLocationWidgetState extends State<SelectLocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: widget.height ?? 55,
        decoration: BoxDecoration(
          color: widget.containerColor ?? Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            // widget.prefixIcon,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TypeAheadField<String>(
                    hideOnEmpty: true,
                    hideOnError: true,
                    hideOnLoading: false,
                    controller: widget.controller,
                    builder: (context, controller, focusNode) => TextField(
                      controller: controller,
                      focusNode: focusNode,
                      autofocus: false,
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        prefixIcon: widget.prefixIcon,
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      if (pattern.isNotEmpty) {
                        List<String> suggestions =
                            await fetchCityPredictions(pattern);
                        return suggestions;
                      }
                      return [];
                    },
                    itemBuilder: (context, suggestion) => Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(suggestion),
                      ),
                    ),
                    loadingBuilder: (context) => Container(
                      color: Colors.white,
                      height: 100,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                    onSelected: (suggestion) {
                      widget.controller.text = suggestion;
                      widget.onChanged(suggestion);
                    },
                  ),
                ],
              ),
            ),
            // widget.suffixIcon, // Ensure suffix icon is included
          ],
        ),
      ),
    );
  }
}

Future<List<String>> fetchCityPredictions(String input) async {
  // Replace with your own API logic
  return ['City 1', 'City 2', 'City 3']; // Dummy data for demonstration
}

class ReelDropDownWidget extends StatelessWidget {
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final String? value;
  final double? height;
  final Function(String value) onChanged;
  final List<String> dropdownItems;

  const ReelDropDownWidget({
    Key? key,
    required this.prefixIcon,
    required this.hintText,
    required this.onChanged,
    required this.dropdownItems,
    required this.value,
    this.height,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height ?? 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: dropdownItems.contains(value) ? value : null, // ✅ Ensure null safety
            onChanged: (String? newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
            hint: Row(
              children: [
                prefixIcon,
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    hintText, // ✅ Show hint text properly
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                if (suffixIcon != null) suffixIcon!,
              ],
            ),
            isExpanded: true,
            items: dropdownItems.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class CaptionField extends StatelessWidget {
  final TextEditingController controller;

  const CaptionField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller,
            maxLength: 100,
            minLines: 3,
            maxLines: null,
            decoration: InputDecoration(
              hintText:
                  'Write a caption and add hashtags...', // Placeholder text
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: TextStyle(color: Colors.black, fontSize: 14.0),
            buildCounter: (context,
                {required int currentLength,
                required bool isFocused,
                int? maxLength}) {
              return Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
                  child: Text(
                    "$currentLength/$maxLength",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
