import 'package:flutter/material.dart';
import '../../models/course_info.dart';
import 'course_modal.dart';

class AgeGroupCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final List<CourseInfo> courseList;

  const AgeGroupCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.courseList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.deepPurple.shade100, width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imageAsset, height: 100),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Poppins',
                color: Color(0xFF6C3A87)
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Color(0xFF6C3A87),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6C3A87),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CourseModal(
                  title: title,
                  courseList: courseList,
                ),
              );
            },
            child: const Text(
              'En savoir plus',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
