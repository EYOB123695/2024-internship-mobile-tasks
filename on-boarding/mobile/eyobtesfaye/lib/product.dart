import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import "product_provider.dart";

class ProductCard extends StatelessWidget {
  final String? imageAssetPath;
  final String? imageFilePath;
  final List<String> texts;

  const ProductCard({
    Key? key,
    this.imageAssetPath,
    this.imageFilePath,
    required this.texts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the image path to pass as an argument
    final String? imagePath = imageAssetPath ?? imageFilePath;

    return GestureDetector(
      onTap: () {
        if (imagePath != null) {
          Navigator.of(context).pushNamed(
            '/details',
            arguments: imagePath, // Passing the image path as an argument
          );
        } else {
          // Handle the case when there is no image path
          // For example, you might show a message or navigate to a default route
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No image available')),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imagePath != null
                ? ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: imageAssetPath != null
                          ? Image.asset(
                              imageAssetPath!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : Image.file(
                              File(imageFilePath!),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                    ),
                  )
                : Container(), // Default empty container if no image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        texts[0],
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF3E3E3E),
                          ),
                        ),
                      ),
                      Text(
                        texts[1],
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF3E3E3E),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        texts[2],
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFAAAAAA),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            texts[3],
                            style: GoogleFonts.sora(
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFAAAAAA),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
