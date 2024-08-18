import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import '../../domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final String? imageAssetPath;
  final String? imageFilePath;
  final List<ProductEntity> products;

  const ProductCard({
    Key? key,
    this.imageAssetPath,
    this.imageFilePath,
    required this.products,
  }) : super(key: key);

  @override
  List<Widget> _buildCard(BuildContext context) {
    final String? imagePath = imageAssetPath ?? imageFilePath;

    return products.map((product) {
      return GestureDetector(
        onTap: () {
          if (product.imageUrl != null) {
            Navigator.of(context).pushNamed(
              '/details',
              arguments: product,
            );
          } else {
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
              Container(
                height: 120, // Set a fixed height for the image
                width: double.infinity,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF3E3E3E),
                          ),
                        ),
                        Text(
                          product.price.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF3E3E3E),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.description,
                            style: GoogleFonts.poppins(
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
                              "4.0",
                              style: GoogleFonts.sora(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFAAAAAA),
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
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1, // Adjusted aspect ratio
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildCard(context)[index];
      },
    );
  }
}
