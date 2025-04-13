// import 'package:flutter/material.dart';
// import 'package:instagram_image_picker/screens/post_upload_screen.dart';
// import 'package:instagram_image_picker/screens/reel_record_screen.dart';

// class FloatingTabs extends StatefulWidget {
//   const FloatingTabs({super.key});

//   @override
//   State<FloatingTabs> createState() => _FloatingTabsState();
// }

// class _FloatingTabsState extends State<FloatingTabs>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       setState(() {}); // Updates UI on tab change
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tabs = ['Post', 'Reel'];

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: TabBarView(
//           controller: _tabController,
//           children: const [
//             PostUploadScreen(),
//             ReelRecordScreen(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         color: Colors.white,
//         padding: const EdgeInsets.symmetric(horizontal: 100),
//         child: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.transparent,
//           labelPadding: EdgeInsets.zero,
//           tabs: List.generate(tabs.length, (index) {
//             final isSelected = _tabController.index == index;
//             return Container(
//               height: 40,
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: isSelected ? Colors.black : Colors.grey,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 tabs[index],
//                 style: const TextStyle(color: Colors.white),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:instagram_image_picker/screens/post_upload_screen.dart';
import 'package:instagram_image_picker/screens/reel_record_screen.dart';

class FloatingTabs extends StatefulWidget {
  const FloatingTabs({super.key});

  @override
  State<FloatingTabs> createState() => _FloatingTabsState();
}

class _FloatingTabsState extends State<FloatingTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        _showReelPopup(); // Show popup when Reel tab is selected
        _tabController.index = 0; // ✅ Ensures tab switches back after closing
      } else {
        setState(() {}); // Updates UI on tab change
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// **Show Reel Popup with Blurred Background**
  void _showReelPopup() {
    showDialog(
      context: context,
      barrierDismissible: true, // ✅ Allows tapping outside to close
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: GestureDetector(
            onTap: () {}, // ✅ Prevents closing when clicking inside
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              child: const ReelRecordScreen(), // Added const for performance
            ),
          ),
        );
      },
    ).then((_) {
      // if (_tabController.index != 0) {
      //   _tabController.index = 0; // ✅ Ensures tab switches back after closing
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Post', 'Reel'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PostUploadScreen(), // ✅ Always show Post screen
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelPadding: EdgeInsets.zero,
          tabs: List.generate(tabs.length, (index) {
            final isSelected = _tabController.index == index;
            return Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tabs[index],
                style: const TextStyle(color: Colors.white),
              ),
            );
          }),
        ),
      ),
    );
  }
}
