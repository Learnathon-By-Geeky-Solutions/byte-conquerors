import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class ChooseSleephour extends StatefulWidget {
  const ChooseSleephour({Key? key}) : super(key: key);

  @override
  State<ChooseSleephour> createState() => _ChooseSleephourState();
}

class _ChooseSleephourState extends State<ChooseSleephour> {
  final List<int> hours = List.generate(18, (index) => index + 1);
  final ScrollController _scrollController = ScrollController();
  final double itemWidth = 60.0;
  int selectedHour = 8;

  @override
  void initState() {
    super.initState();

    // Wait until layout is ready, then scroll to selected hour
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToHour(selectedHour, animate: false);
    });
  }

  void _scrollToHour(int hour, {bool animate = true}) {
    final index = hour - 1;
    final screenCenter = MediaQuery.of(context).size.width / 2;
    final offset = (index * itemWidth) - screenCenter + (itemWidth / 2);

    if (animate) {
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.jumpTo(offset);
    }
  }

  void _onScrollUpdate() {
    final centerPosition =
        _scrollController.offset + MediaQuery.of(context).size.width / 2;
    final index =
        (centerPosition / itemWidth).round().clamp(0, hours.length - 1);
    final newHour = hours[index];

    if (newHour != selectedHour) {
      setState(() {
        selectedHour = newHour;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'How many hours\ndo you sleep?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 80,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification ||
                  notification is ScrollEndNotification) {
                _onScrollUpdate();
              }
              return true;
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Scrollable hour list
                ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: hours.length,
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.width / 2 - itemWidth / 2,
                  ),
                  itemBuilder: (context, index) {
                    final hour = hours[index];
                    final isSelected = hour == selectedHour;

                    return Container(
                      width: itemWidth,
                      alignment: Alignment.center,
                      child: Text(
                        hour.toString(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.transparent : Colors.grey,
                        ),
                      ),
                    );
                  },
                ),

                // Green box with selected number inside
                IgnorePointer(
                  child: Container(
                    width: itemWidth,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      selectedHour.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
