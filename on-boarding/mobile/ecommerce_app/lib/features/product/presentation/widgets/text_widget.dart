import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final VoidCallback onFilterPressed; // Correctly defined

  const TextWidget({super.key, required this.onFilterPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Leather',
                suffixIcon: Icon(
                  Icons.arrow_forward,
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Container(
            color: Colors.blue,
            child: IconButton(
              icon: const Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
              onPressed: onFilterPressed, // This should trigger _openFilter
            ),
          ),
        ],
      ),
    );
  }
}
