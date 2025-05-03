import 'dart:ui';

import 'package:flutter/material.dart';

// class CustomTabBarPage extends StatefulWidget {
//   @override
//   _CustomTabBarPageState createState() => _CustomTabBarPageState();
// }
//
// class _CustomTabBarPageState extends State<CustomTabBarPage> {
//   late PageController _pageController;
//   final List<String> tabs = ['Short', 'Quite long', 'A very long one'];
//   List<double> tabWidths = [];
//   List<double> tabOffsets = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _calculateTabSizes();
//     });
//   }
//
//   void _calculateTabSizes() {
//     final context = this.context;
//     final textStyles = DefaultTextStyle.of(context).style;
//
//     double currentOffset = 0;
//     tabWidths.clear();
//     tabOffsets.clear();
//
//     for (var tab in tabs) {
//       final textPainter = TextPainter(
//         text: TextSpan(text: tab, style: textStyles.copyWith(fontSize: 16)),
//         textDirection: TextDirection.ltr,
//       )..layout();
//
//       tabWidths.add(textPainter.width + 32); // Add padding left and right
//       tabOffsets.add(currentOffset);
//       currentOffset += textPainter.width + 32; // Move offset for next tab
//     }
//
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Custom Tab Bar')),
//       body: Column(
//         children: [
//           Container(
//             height: 60,
//             child: tabWidths.isEmpty
//                 ? SizedBox()
//                 : LayoutBuilder(
//                     builder: (context, constraints) {
//                       double totalWidth = tabWidths.reduce((a, b) => a + b);
//
//                       return Stack(
//                         children: [
//                           // Bubble Background
//                           AnimatedBuilder(
//                             animation: _pageController,
//                             builder: (context, child) {
//                               double page = _pageController.hasClients &&
//                                       _pageController.page != null
//                                   ? _pageController.page!
//                                   : 0;
//
//                               int currentPage = page.floor();
//                               int nextPage =
//                                   (currentPage + 1).clamp(0, tabs.length - 1);
//
//                               double currentOffset = tabOffsets[currentPage];
//                               double nextOffset = tabOffsets[nextPage];
//                               double currentWidth = tabWidths[currentPage];
//                               double nextWidth = tabWidths[nextPage];
//
//                               double lerpOffset = lerpDouble(currentOffset,
//                                   nextOffset, page - currentPage)!;
//                               double lerpWidth = lerpDouble(
//                                   currentWidth, nextWidth, page - currentPage)!;
//
//                               return Positioned(
//                                 left: lerpOffset,
//                                 top: 8,
//                                 bottom: 8,
//                                 child: Container(
//                                   width: lerpWidth,
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           // Tab Buttons
//                           Row(
//                             children: List.generate(tabs.length, (index) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   _pageController.animateToPage(
//                                     index,
//                                     duration: Duration(milliseconds: 300),
//                                     curve: Curves.ease,
//                                   );
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16),
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     tabs[index],
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//           ),
//           Expanded(
//             child: PageView(
//               controller: _pageController,
//               children: [
//                 Center(child: Text('Short Page')),
//                 Center(child: Text('Quite long Page')),
//                 Center(child: Text('A very long one Page')),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
///

class CustomTabBarPage extends StatefulWidget {
  const CustomTabBarPage({super.key});

  @override
  State<CustomTabBarPage> createState() => _CustomTabBarPageState();
}

class _CustomTabBarPageState extends State<CustomTabBarPage> {
  late PageController _pageController;
  final List<String> tabs = ['Short', 'Quite long', 'A very long one'];
  List<double> tabWidths = [];
  List<double> tabOffsets = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateTabSizes();
    });
  }

  void _calculateTabSizes() {
    final context = this.context;
    final textStyles = DefaultTextStyle.of(context).style;

    double currentOffset = 0;
    tabWidths.clear();
    tabOffsets.clear();

    for (var tab in tabs) {
      final textPainter = TextPainter(
        text: TextSpan(text: tab, style: textStyles.copyWith(fontSize: 16)),
        textDirection: TextDirection.ltr,
      )..layout();

      tabWidths.add(textPainter.width + 32); // Add padding
      tabOffsets.add(currentOffset);
      currentOffset += textPainter.width + 32;
    }

    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Tab Bar')),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: tabWidths.isEmpty
                ? const SizedBox()
                : AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double page = _pageController.hasClients &&
                              _pageController.page != null
                          ? _pageController.page!
                          : 0;

                      int currentPage = page.floor();
                      int nextPage =
                          (currentPage + 1).clamp(0, tabs.length - 1);

                      double currentOffset = tabOffsets[currentPage];
                      double nextOffset = tabOffsets[nextPage];
                      double currentWidth = tabWidths[currentPage];
                      double nextWidth = tabWidths[nextPage];

                      double lerpOffset = lerpDouble(
                          currentOffset, nextOffset, page - currentPage)!;
                      double lerpWidth = lerpDouble(
                          currentWidth, nextWidth, page - currentPage)!;

                      double bubbleLeft = lerpOffset;
                      double bubbleRight = lerpOffset + lerpWidth;

                      return Stack(
                        children: [
                          // Bubble itself
                          Positioned(
                            left: bubbleLeft,
                            top: 8,
                            bottom: 8,
                            child: Container(
                              width: lerpWidth,
                              decoration: BoxDecoration(
                                color: Colors.red.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          // Tabs
                          Row(
                            children: List.generate(tabs.length, (index) {
                              double tabStart = tabOffsets[index];
                              // double tabEnd =
                              //     tabOffsets[index] + tabWidths[index];

                              return GestureDetector(
                                onTap: () {
                                  _pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  alignment: Alignment.center,
                                  child: ShaderMask(
                                    shaderCallback: (bounds) {
                                      double tabWidth = tabWidths[index];
                                      double relativeBubbleLeft =
                                          (bubbleLeft - tabStart)
                                              .clamp(0.0, tabWidth);
                                      double relativeBubbleRight =
                                          (bubbleRight - tabStart)
                                              .clamp(0.0, tabWidth);

                                      return LinearGradient(
                                        colors: const [
                                          Colors.green, // unselected color
                                          Colors.green,
                                          Colors.red, // selected color
                                          Colors.red,
                                          Colors.green,
                                          Colors.green,
                                        ],
                                        stops: [
                                          0.0,
                                          relativeBubbleLeft / tabWidth,
                                          relativeBubbleLeft / tabWidth,
                                          relativeBubbleRight / tabWidth,
                                          relativeBubbleRight / tabWidth,
                                          1.0,
                                        ],
                                      ).createShader(Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height));
                                    },
                                    child: Text(
                                      tabs[index],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors
                                            .white, // Important for shader mask
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      );
                    },
                  ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: const [
                Center(child: Text('Short Page')),
                Center(child: Text('Quite long Page')),
                Center(child: Text('A very long one Page')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///
// class CustomTabBarPage extends StatefulWidget {
//   @override
//   _CustomTabBarPageState createState() => _CustomTabBarPageState();
// }

// class _CustomTabBarPageState extends State<CustomTabBarPage> {
//   late PageController _pageController;
//   final List<String> tabs = ['Short', 'Quite long', 'A very long one'];
//   List<double> tabWidths = [];
//   List<double> tabOffsets = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _calculateTabSizes();
//     });
//   }
//
//   void _calculateTabSizes() {
//     final context = this.context;
//     final textStyles = DefaultTextStyle.of(context).style;
//
//     double currentOffset = 0;
//     tabWidths.clear();
//     tabOffsets.clear();
//
//     for (var tab in tabs) {
//       final textPainter = TextPainter(
//         text: TextSpan(text: tab, style: textStyles.copyWith(fontSize: 16)),
//         textDirection: TextDirection.ltr,
//       )..layout();
//
//       tabWidths.add(textPainter.width + 32); // Add padding left and right
//       tabOffsets.add(currentOffset);
//       currentOffset += textPainter.width + 32; // Move offset for next tab
//     }
//
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Custom Tab Bar')),
//       body: Column(
//         children: [
//           Container(
//             height: 60,
//             child: tabWidths.isEmpty
//                 ? SizedBox()
//                 : LayoutBuilder(
//                     builder: (context, constraints) {
//                       double totalWidth = tabWidths.reduce((a, b) => a + b);
//
//                       return Stack(
//                         children: [
//                           // Bubble Background
//                           AnimatedBuilder(
//                             animation: _pageController,
//                             builder: (context, child) {
//                               double page = _pageController.hasClients &&
//                                       _pageController.page != null
//                                   ? _pageController.page!
//                                   : 0;
//
//                               int currentPage = page.floor();
//                               int nextPage =
//                                   (currentPage + 1).clamp(0, tabs.length - 1);
//
//                               double currentOffset = tabOffsets[currentPage];
//                               double nextOffset = tabOffsets[nextPage];
//                               double currentWidth = tabWidths[currentPage];
//                               double nextWidth = tabWidths[nextPage];
//
//                               double lerpOffset = lerpDouble(currentOffset,
//                                   nextOffset, page - currentPage)!;
//                               double lerpWidth = lerpDouble(
//                                   currentWidth, nextWidth, page - currentPage)!;
//
//                               return Positioned(
//                                 left: lerpOffset,
//                                 top: 8,
//                                 bottom: 8,
//                                 child: Container(
//                                   width: lerpWidth,
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           // Tab Buttons
//                           Row(
//                             children: List.generate(tabs.length, (index) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   _pageController.animateToPage(
//                                     index,
//                                     duration: Duration(milliseconds: 300),
//                                     curve: Curves.ease,
//                                   );
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16),
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     tabs[index],
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//           ),
//           Expanded(
//             child: PageView(
//               controller: _pageController,
//               children: [
//                 Center(child: Text('Short Page')),
//                 Center(child: Text('Quite long Page')),
//                 Center(child: Text('A very long one Page')),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
///
//
// class CustomTabBarPage extends StatefulWidget {
//   @override
//   _CustomTabBarPageState createState() => _CustomTabBarPageState();
// }
//
// class _CustomTabBarPageState extends State<CustomTabBarPage> {
//   late PageController _pageController;
//   final List<String> tabs = ['Short', 'Quite long', 'A very long one'];
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final tabWidth = MediaQuery.of(context).size.width / tabs.length;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Custom Tab Bar'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 60,
//             child: Stack(
//               children: [
//                 // Moving Bubble (background highlight)
//                 AnimatedBuilder(
//                   animation: _pageController,
//                   builder: (context, child) {
//                     double indicatorPosition = 0;
//                     if (_pageController.hasClients &&
//                         _pageController.page != null) {
//                       indicatorPosition = _pageController.page!;
//                     }
//                     return Positioned(
//                       left: tabWidth * indicatorPosition + 8,
//                       top: 8,
//                       bottom: 8,
//                       child: Container(
//                         width: tabWidth - 16,
//                         decoration: BoxDecoration(
//                           color: Colors.blue.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 Row(
//                   children: List.generate(tabs.length, (index) {
//                     return Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           _pageController.animateToPage(
//                             index,
//                             duration: Duration(milliseconds: 300),
//                             curve: Curves.ease,
//                           );
//                         },
//                         child: Center(
//                           child: Text(
//                             tabs[index],
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: PageView(
//               controller: _pageController,
//               children: [
//                 Center(child: Text('Home Page')),
//                 Center(child: Text('Search Page')),
//                 Center(child: Text('Profile Page')),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class OngoingPageView extends StatelessWidget {
  const OngoingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTabBarPage();
  }
}
