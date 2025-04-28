import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class ChooseHelptype extends StatefulWidget {
  @override
  _ChooseHelptypeState createState() => _ChooseHelptypeState();
}

class _ChooseHelptypeState extends State<ChooseHelptype> {
  final PageController _pageController = PageController(
      initialPage: 1, viewportFraction: 0.6); // Set initialPage to 1
  int _currentPage = 1;

  final List<Map<String, String>> _options = [
    {"emoji": "😔", "text": "Tackling\nStress"},
    {"emoji": "😫", "text": "Overcoming\nDepression"},
    {"emoji": "😴", "text": "Better\nSleep"},
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        // This makes sure the current page is updated dynamically based on the scroll position
        _currentPage = _pageController.page?.round() ?? _currentPage;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 24.0, bottom: 16),
            child: Text(
              "What can we\nhelp you with",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(
            height: 280,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _options.length,
              itemBuilder: (context, index) {
                // Page offset value
                double pageOffset =
                    _pageController.page ?? _currentPage.toDouble();
                double distanceFromCenter = (pageOffset - index).abs();

                // Curved effect: move cards up/down
                double verticalOffset = distanceFromCenter * 30;

                // Scale effect
                double scale = 1 - (distanceFromCenter * 0.1);

                return Transform.translate(
                  offset: Offset(0, verticalOffset),
                  child: Transform.scale(
                    scale: scale,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: index == _currentPage
                            ? AppColors.primary
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _options[index]['emoji']!,
                              style: TextStyle(fontSize: 48),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _options[index]['text']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: index == _currentPage
                                    ? AppColors.lighFont
                                    : AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
