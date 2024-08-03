import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.blue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Add Product',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF3E3E3E),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to start
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 200,
                color: const Color(0xFFF3F3F3),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Upload Image',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                  height: 20), // Space between image box and text fields
              Text(
                'Name',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF3E3E3E),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 8.0), // Left and right margin
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF3F3F3),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16), // Space between text fields
              Text(
                'Category',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF3E3E3E),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 8.0), // Left and right margin
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF3F3F3),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16), // Space between text fields
              Text(
                'Price',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF3E3E3E),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 8.0), // Left and right margin
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF3F3F3),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16), // Space between text fields
              Text(
                'Description',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF3E3E3E),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0), // Left and right margin
                child: Container(
                  height: 250,
                  child: const TextField(
                    maxLines: 100,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF3F3F3),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: 16), // Space between text fields and buttons
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0), // Match TextField padding
                child: Container(
                  width: double
                      .infinity, // Expand button to full width of its parent
                  height: 50, // Set the height of the button
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Color(0xFF3F51F3), // Background color
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0, // Increase vertical padding
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18, // Increase font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(
                      'ADD',
                      style: GoogleFonts.poppins(
                        fontSize: 14, // Font size
                        fontWeight: FontWeight.w600, // Font weight
                        color: const Color(0xFFFFFFFF), // Font color
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8), // Space between buttons
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0), // Match TextField padding
                child: Container(
                  width: double
                      .infinity, // Expand button to full width of its parent
                  height: 50, // Set the height of the button
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      foregroundColor: Colors.red, // Text color
                      side: const BorderSide(color: Colors.red), // Border color
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0, // Increase vertical padding
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18, // Increase font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(
                      'DELETE',
                      style: GoogleFonts.poppins(
                        fontSize: 14, // Font size
                        fontWeight: FontWeight.w600, // Font weight
                        color: Colors
                            .red, // Ensure text color contrasts with background
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
