import 'package:flutter/material.dart';

import '../../../../core/themes/screen_utility.dart';

class SlideDotes extends StatelessWidget {
  final bool isActive;

  const SlideDotes(this.isActive, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.only(right: 10),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? weevoPrimaryBlueColor : Colors.grey,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

class CategoryDotes extends StatelessWidget {
  final bool isActive;

   const CategoryDotes({Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(
        horizontal: 3.0,
      ),
      height: 7,
      width: 7,
      decoration: BoxDecoration(
        color: isActive ? weevoPrimaryOrangeColor : Colors.grey,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
    );
  }
}
