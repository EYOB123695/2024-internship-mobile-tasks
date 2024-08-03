import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product.dart';
import 'add_product.dart'; // Ensure to import the AddProductScreen
import 'search_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'July 14, 2023',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFAAAAAA),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hello, ',
                    style: GoogleFonts.sora(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFAAAAAA),
                    ),
                  ),
                  TextSpan(
                    text: 'Yohannes',
                    style: GoogleFonts.sora(
                      fontSize: 12,
                      fontWeight: FontWeight.w600, // Apply bold weight here
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 13.0), // Add right padding
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.black, // No color fill
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20), // Space above the row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Available products",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3E3E3E),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 19),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/search-product');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), // Space between row and product cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8), // Adjust padding here if needed
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 13.0), // Add vertical padding
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/details',
                        arguments: 'images/image.png',
                      );
                    },
                    child: ProductCard(
                      imageAssetPath: 'images/image.png',
                      texts: [
                        'Derby Leather Shoes',
                        '120\$',
                        'Men’s shoe',
                        '4.0',
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 13.0), // Add vertical padding
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/details',
                        arguments: 'images/hat.png',
                      );
                    },
                    child: ProductCard(
                      imageAssetPath: 'images/hat.jpg',
                      texts: [
                        'Product 2',
                        '150\$',
                        'Women’s shoe',
                        '4.5',
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 13.0), // Add vertical padding
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/details',
                        arguments: 'images/bag.png',
                      );
                    },
                    child: ProductCard(
                      imageAssetPath: 'images/bag.jpg',
                      texts: [
                        'Product 3',
                        '200\$',
                        'Kids’ shoe',
                        '4.7',
                      ],
                    ),
                  ),
                ),
                // Add more ProductCard widgets as needed
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 72, // Size of the button
        height: 72, // Size of the button
        decoration: BoxDecoration(
          color: Color(0xFF3F51F3),
          shape: BoxShape.circle, // Ensures circular shape
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/add-product');
          },
          backgroundColor:
              Colors.transparent, // Make the background transparent
          child: const Icon(Icons.add, color: Colors.white),
          elevation: 0, // Remove elevation to match the container's appearance
        ),
      ),
    );
  }
}
