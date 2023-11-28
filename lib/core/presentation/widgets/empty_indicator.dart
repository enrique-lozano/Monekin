import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyIndicator extends StatelessWidget {
  /// Create a widget that display an image, a title and a description, one below each other
  const EmptyIndicator(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/page_states/empty_state.svg',
            height: 225,
            // width: constraints.maxWidth * 0.5,
            //colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(description, textAlign: TextAlign.center),
          const SizedBox(height: 42),
        ],
      ),
    );
  }
}
