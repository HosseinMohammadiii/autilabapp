import 'package:flutter/material.dart';

class DisplayAllDoctorMediaWidget extends StatelessWidget {
  const DisplayAllDoctorMediaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 15,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 12,
        mainAxisExtent: 102,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/child2_image.jpg',
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
