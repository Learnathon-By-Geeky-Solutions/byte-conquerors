import 'package:flutter/material.dart';

class FeaturedSleepView extends StatelessWidget {
  const FeaturedSleepView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Featured',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: const [
              _FeaturedCard(
                imageUrl: 'https://picsum.photos/id/1018/400/240',
                duration: '20 min',
                title: 'How to sleep effortlessly',
                rating: 4.1,
                author: 'Hilary Jackendoff',
              ),
              SizedBox(width: 16),
              _FeaturedCard(
                imageUrl: 'https://picsum.photos/id/1025/400/240',
                duration: '22 min',
                title: 'Yoga for sleep',
                rating: 4.4,
                author: 'James Cook',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String duration;
  final String title;
  final double rating;
  final String author;

  const _FeaturedCard({
    required this.imageUrl,
    required this.duration,
    required this.title,
    required this.rating,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 240,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: Icon(Icons.bookmark_border, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            duration,
            style: const TextStyle(fontSize: 12, color: Colors.green),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                rating.toString(),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 6),
              Text(
                author,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
