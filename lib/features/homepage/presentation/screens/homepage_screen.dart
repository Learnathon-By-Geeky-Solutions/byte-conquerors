import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/homepage/presentation/widgets/featured_view.dart';
import 'package:soul_space/features/homepage/presentation/widgets/phq9_score_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moods = ['😄', '🙂', '😐', '😕', '☹️'];
    int selectedIndex =
        0; // You can use a stateful widget if this needs to be dynamic

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hello,',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w400)),
              CircleAvatar(
                backgroundColor: Colors.yellow[100],
                radius: 24,
                child: const Icon(Icons.person, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 30),

          const Text(
            'How are you feeling ?',
            style: TextStyle(fontSize: 16, color: AppColors.darkFont),
          ),
          const SizedBox(height: 15),

          // Mood Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              moods.length,
              (index) => CircleAvatar(
                radius: 26,
                backgroundColor: selectedIndex == index
                    ? AppColors.primary
                    : Colors.grey.shade200,
                child: Text(
                  moods[index],
                  style: ThemeData().textTheme.labelMedium?.copyWith(
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Phq9ScoreWidget(),
          const SizedBox(height: 20),

          const Text(
            'For your mood',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.darkFont),
          ),
          const SizedBox(height: 20),

          // Featured Card
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.network(
                  'https://picsum.photos/600/200',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.bookmark_border),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Practice Info
          const Text(
            '12 min, Intermediate',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          const Text(
            'Abundance Guided Practice',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: AppColors.secondaryColor),
              SizedBox(width: 4),
              Text('4.5  Scott & Shanice',
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 30),

          // Quote Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NATHANIEL BRANDEN',
                  style: ThemeData().textTheme.labelMedium?.copyWith(
                        fontSize: 12,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                ),
                SizedBox(height: 10),
                Text(
                  'The first step toward change is awareness. The second step is acceptance.',
                  style: TextStyle(
                    color: AppColors.lighFont,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.favorite_border, color: Colors.white),
                )
              ],
            ),
          ),
          FeaturedSleepView(),
        ],
      ),
    );
  }
}
