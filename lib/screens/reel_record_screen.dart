// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:get/get.dart';
// import 'dart:async';
// import 'reel_description_screen.dart';

// class ReelRecordScreen extends StatefulWidget {
//   const ReelRecordScreen({super.key});

//   @override
//   State<ReelRecordScreen> createState() => _ReelRecordScreenState();
// }

// class _ReelRecordScreenState extends State<ReelRecordScreen> {
//   CameraController? _cameraController;
//   bool _isRecording = false;
//   final ImagePicker _videoPicker = ImagePicker();
//   late XFile selectedVideoFile;
//   Timer? _timer;
//   int _recordingDuration = 0; // Timer duration counter

//   @override
//   void initState() {
//     super.initState();
//     _checkPermissions();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   /// **Check & Request Permissions on Startup**
//   Future<void> _checkPermissions() async {
//     await [Permission.camera, Permission.microphone].request();
//     _initializeCamera();
//   }

//   /// **Initialize Camera**
//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     if (cameras.isNotEmpty) {
//       _cameraController = CameraController(
//         cameras[0],
//         ResolutionPreset.high,
//         enableAudio: true,
//       );
//       await _cameraController!.initialize();
//       if (mounted) setState(() {});
//     }
//   }

//   /// **Start/Stop Recording**
//   Future<void> _toggleRecording() async {
//     if (_cameraController == null || !_cameraController!.value.isInitialized) {
//       errorSnackbar("Camera not ready.");
//       return;
//     }

//     if (_isRecording) {
//       // Stop recording properly
//       try {
//         setState(() => _isRecording = false);
//         _stopTimer();

//         // 🎯 Ensure UI remains responsive
//         XFile video = await _cameraController!.stopVideoRecording();

//         // 🎯 Give slight delay before navigating (prevents UI freeze)
//         await Future.delayed(const Duration(milliseconds: 500));

//         _navigateToDescription(video);
//       } catch (e) {
//         errorSnackbar("Error stopping recording.");
//       }
//     } else {
//       // Start recording
//       try {
//         await _cameraController!.startVideoRecording();
//         setState(() {
//           _isRecording = true;
//           _recordingDuration = 0;
//         });
//         _startTimer();
//       } catch (e) {
//         errorSnackbar("Error starting recording.");
//       }
//     }
//   }

//   /// **Start Timer for Recording**
//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (mounted) {
//         setState(() {
//           _recordingDuration++;
//         });
//       }
//     });
//   }

//   /// **Stop Timer**
//   void _stopTimer() {
//     _timer?.cancel();
//     _timer = null;
//   }

//   /// **Pick Video from Gallery**
//   Future<void> getVideoFromGallery() async {
//     final XFile? source =
//         await _videoPicker.pickVideo(source: ImageSource.gallery);

//     if (source == null) {
//       errorSnackbar("Please select a video.");
//       return;
//     }

//     if (!isVideoFile(source.path)) {
//       errorSnackbar("Invalid file type. Please select a valid video.");
//       return;
//     }

//     setState(() {
//       selectedVideoFile = source;
//     });

//     Get.to(() => ReelDescriptionScreen(videoFile: selectedVideoFile));
//   }

//   /// **Validate if File is a Video**
//   bool isVideoFile(String path) {
//     final videoExtensions = ['mp4', 'mov', 'avi', 'mkv', 'flv', 'wmv', 'webm'];
//     String extension = path.split('.').last.toLowerCase();
//     return videoExtensions.contains(extension);
//   }

//   void errorSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message, style: const TextStyle(color: Colors.white)),
//         backgroundColor: Colors.black.withOpacity(0.8),
//       ),
//     );
//   }

//   /// **Navigate to Description Screen**
//   void _navigateToDescription(XFile video) {
//     Get.to(() => ReelDescriptionScreen(videoFile: video));
//   }

//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     _stopTimer();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("Record Reel", style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//       ),
//       body: Stack(
//         children: [
//           // 📸 Camera Preview
//           Positioned.fill(
//             child: _cameraController == null ||
//                     !_cameraController!.value.isInitialized
//                 ? const Center(child: CircularProgressIndicator())
//                 : CameraPreview(_cameraController!),
//           ),

//           // ⏳ Recording Timer Display
//           if (_isRecording)
//             Positioned.fill(
//               child: Center(
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(
//                     color: Colors.red.withOpacity(0.8),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     "${_recordingDuration}s",
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),

//           // 🎥 UI Buttons
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: IconButton(
//               icon: const Icon(Icons.video_library,
//                   color: Colors.white, size: 40),
//               onPressed: getVideoFromGallery,
//             ),
//           ),

//           Positioned(
//             bottom: 20,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: FloatingActionButton(
//                 onPressed: _toggleRecording,
//                 backgroundColor: Colors.red,
//                 shape: const CircleBorder(),
//                 child: Icon(
//                   _isRecording ? Icons.stop : Icons.videocam,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'reel_description_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class ReelRecordScreen extends StatefulWidget {
  const ReelRecordScreen({super.key});

  @override
  State<ReelRecordScreen> createState() => _ReelRecordScreenState();
}

class _ReelRecordScreenState extends State<ReelRecordScreen> {
  final ImagePicker _videoPicker = ImagePicker();

  /// **Open System Camera for Video Recording**
  Future<void> _getVideoFromCamera() async {
    // Close the dialog before navigation
    Navigator.pop(context);
    Navigator.pop(context);

    // Request permissions
    PermissionStatus cameraPermission = await Permission.camera.request();
    PermissionStatus micPermission = await Permission.microphone.request();

    if (cameraPermission.isGranted && micPermission.isGranted) {
      final XFile? video =
          await _videoPicker.pickVideo(source: ImageSource.camera);

      if (video != null) {
        // Navigate to the description screen with recorded video
        Get.to(() => ReelDescriptionScreen(videoFile: video));
      } else {
        Get.snackbar("Cancelled", "No video was recorded");
      }
    } else {
      Get.snackbar(
          "Permission Denied", "Camera & Microphone access is required");
    }
  }

  /// **Pick Video from Gallery**
  Future<void> _pickVideoFromGallery() async {
    // Close the dialog before navigation
    Navigator.pop(context);
    Navigator.pop(context);

    final XFile? video =
        await _videoPicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      Get.to(() => ReelDescriptionScreen(videoFile: video));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Reel"),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildOption(Icons.camera_alt_rounded, "Record", _getVideoFromCamera),
          _buildOption(Icons.video_library, "Gallery", _pickVideoFromGallery),
        ],
      ),
    );
  }

  /// **Reusable Widget for Options**
  Widget _buildOption(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(icon, size: 40),
            onPressed: onTap,
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: onTap,
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
