import 'package:flutter/material.dart';
import '../../models/course_info.dart';

class CourseCard extends StatelessWidget {
  final CourseInfo courseInfo;

  const CourseCard({super.key, required this.courseInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE5B5F3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseInfo.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(courseInfo.shortText),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(courseInfo.title),
                  content: Text(courseInfo.longText),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Fermer"),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'En savoir plus',
              style: TextStyle(
                color: Color(0xFF6C3A87),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
