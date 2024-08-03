import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatefulWidget {
  final String imagepath;
  const DetailsPage({super.key, required this.imagepath});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // To keep track of the selected size
  int _selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    final String imagepath =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              imagepath, // Replace with your image path
              fit: BoxFit.cover, // Adjust to BoxFit.contain if needed
              height: 240, // Adjust height as needed
              width: MediaQuery.of(context).size.width,
            ),
          ),
          // const SizedBox(height: 10),
          // Back button container
          Positioned(
            top: 40,
            left: 16,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.blue),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          // Content below the image
          Positioned(
            top: 250, // This should match or exceed the height of the image
            left: 0,
            right: 0,
            bottom: 0, // Ensures it takes up remaining space
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First row with "Men's shoe" and star rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Men\'s shoe',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFAAAAAA),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange),
                          SizedBox(
                              width: 4), // Add spacing between icon and text
                          Text(
                            '(4.0)',
                            style: GoogleFonts.sora(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFAAAAAA),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16), // Add spacing between rows
                  // Second row with "Derby LEFT" and "$120"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Derby Leather',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '\$120',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3E3E3E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16), // Add spacing between rows
                  // Third row with "Size:" and its value
                  Row(
                    children: [
                      Text(
                        'Size:',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Color(0xFF3E3E3E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16), // Add spacing between rows
                  // Horizontally scrollable size options
                  Container(
                    height: 50, // Height of the scrollable area
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) {
                            final size = 39 + index;
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedSize = size;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: _selectedSize == size
                                        ? Colors.blue // Highlight selected size
                                        : Colors.grey[
                                            200], // Default background color
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: _selectedSize == size
                                        ? [
                                            BoxShadow(
                                              color: Colors.blue,
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                            )
                                          ]
                                        : [],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$size',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: _selectedSize == size
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 26), // Add spacing before the text field
                  // Text field with product description
                  Expanded(
                    child: Text(
                      "A derby leather shoe is a classic and versatile footwear option cre the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30), // Add spacing before the buttons
                  // Row for the Delete and Update buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 152,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {
                              // Handle delete action
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red, // Text color
                                side: BorderSide(
                                    color: Colors.red), // Border color
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 24.0,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8)) // Adjust padding as needed
                                ),
                            child: Text(
                              'DELETE',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight
                                      .w600, // Apply the desired font weight
                                  color: Colors
                                      .red, // Ensure the text color is set
                                ),
                              ),
                            ),
                          )),
                      Container(
                        width: 152,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle update action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Background color
                            foregroundColor: Colors.white, // Text color
                            padding: EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 24.0,
                            ), // Adjust padding as needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'UPDATE',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
