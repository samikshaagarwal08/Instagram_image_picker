import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:get/get.dart'; 
import 'post_description_screen.dart';

class PostUploadScreen extends StatefulWidget {
  const PostUploadScreen({super.key});

  @override
  _PostUploadScreenState createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
  XFile? _selectedImage;
  List<AssetEntity> _galleryImages = [];
  List<AssetPathEntity> _albums = [];
  AssetPathEntity? _selectedAlbum;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGalleryImages();
  }

  // Function to get gallery images
  Future<void> _fetchGalleryImages() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(type: RequestType.image);
      if (albums.isNotEmpty) {
        setState(() {
          _albums = albums;
          _selectedAlbum = albums.first;
        });
        _loadImagesFromAlbum(albums.first);
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  // Function to load images from selected album
  Future<void> _loadImagesFromAlbum(AssetPathEntity album) async {
    setState(() => _isLoading = true);
    List<AssetEntity> photos = await album.getAssetListPaged(page: 0, size: 50);

    if (photos.isNotEmpty) {
      File? firstImageFile = await photos.first.file;
      if (firstImageFile != null) {
        _selectedImage = XFile(firstImageFile.path); // First image pre-select
      }
    }

    setState(() {
      _galleryImages = photos;
      _isLoading = false;
    });
  }

  // Function to select image (without reloading gallery)
  Future<void> _setSelectedImage(AssetEntity entity,
      {bool updateUI = true}) async {
    File? file = await entity.file;
    if (file != null) {
      if (updateUI) {
        setState(() {
          _selectedImage = XFile(file.path);
        });
      } else {
        _selectedImage = XFile(file.path);
      }
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });

      // ✅ Navigate to next screen with correct image path using GetX
      Get.to(() => PostDescriptionScreen(image: image));
    }
  }

  // Navigate to Next Screen
  void _goToNextScreen() {
    if (_selectedImage != null) {
      Get.to(() => PostDescriptionScreen(image: _selectedImage!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            const Text("Upload Image", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _goToNextScreen,
            child: Text("NEXT",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Selected Image Display
            _selectedImage != null
                ? Expanded(
                    child: Image.file(
                      File(_selectedImage!.path),
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  )
                : const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),

            // Gallery View
            Container(
              height: 300,
              color: Colors.white.withOpacity(0.9),
              child: Column(
                children: [
                  // Dropdown & Camera Button
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dropdown Button
                        DropdownButtonHideUnderline(
                          child: DropdownButton<AssetPathEntity>(
                            dropdownColor: Colors.white,
                            value: _selectedAlbum,
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Colors.black),
                            items: _albums.map((album) {
                              return DropdownMenuItem(
                                value: album,
                                child: Text(
                                  album.name,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              );
                            }).toList(),
                            onChanged: (AssetPathEntity? newAlbum) {
                              if (newAlbum != null) {
                                _loadImagesFromAlbum(newAlbum);
                                setState(() {
                                  _selectedAlbum = newAlbum;
                                });
                              }
                            },
                          ),
                        ),

                        // Camera Button
                        IconButton(
                          icon: const Icon(Icons.camera_alt,
                              color: Colors.black, size: 28),
                          onPressed: _pickImageFromCamera,
                        ),
                      ],
                    ),
                  ),

                  // Grid Gallery
                  Expanded(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            padding: const EdgeInsets.all(5),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemCount: _galleryImages.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder<File?>(
                                future: _galleryImages[index].file,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.data != null) {
                                    return GestureDetector(
                                      onTap: () => _setSelectedImage(
                                          _galleryImages[index]),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.file(
                                            snapshot.data!,
                                            fit: BoxFit.cover,
                                          ),
                                          if (_selectedImage?.path ==
                                              snapshot.data!.path)
                                            Container(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              child: const Center(
                                                child: Icon(Icons.check_circle,
                                                    color: Colors.white,
                                                    size: 30),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
