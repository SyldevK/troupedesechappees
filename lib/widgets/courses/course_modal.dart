import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/course_info.dart';
import 'course_card.dart';

class CourseModal extends StatelessWidget {
  final String title;
  final List<CourseInfo> courseList;

  const CourseModal({
    super.key,
    required this.title,
    required this.courseList,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF6C3A87)),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: courseList
                  .map((course) => CourseCard(courseInfo: course))
                  .toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.hovered)) {
                    return const Color(0xFF6C3A87);
                  }
                  return const Color(0xFFE5B5F3);
                }),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                textStyle: WidgetStateProperty.all<TextStyle>(
                  GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Text("Fermer"),
            )
          ],
        ),
      ),
    );
  }
}
