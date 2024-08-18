import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import '../../domain/entities/product_entity.dart';
import '../bloc/bloc/detailpage_bloc.dart';
import 'home_screen.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late ProductEntity product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    product = ModalRoute.of(context)?.settings.arguments as ProductEntity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailpageBloc, DetailpageState>(
        listener: (context, state) {
          if (state is DeleteSucess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
            );
          } else if (state is DeleteFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              // Background image
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: product.imageUrl.startsWith('/')
                    ? Image.file(
                        File(product.imageUrl),
                        fit: BoxFit.cover,
                        height: 240,
                        width: MediaQuery.of(context).size.width,
                      )
                    : Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        height: 240,
                        width: MediaQuery.of(context).size.width,
                      ),
              ),
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
                    icon:
                        Icon(Icons.arrow_back_ios_rounded, color: Colors.blue),
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
                      // First row with product name and star rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
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
                                  width:
                                      4), // Add spacing between icon and text
                              Text(
                                '(4.0)', // You can replace with actual rating if available
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
                      // Second row with product description and price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.description,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '\$${product.price}',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF3E3E3E),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 350), // Add spacing before the buttons
                      // Row for the Delete and Update buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 152,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  context.read<DetailpageBloc>().add(
                                        DeleteProductEvent(id: product.id),
                                      );
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
                                Navigator.pushNamed(
                                  context,
                                  '/update-products',
                                  arguments: product,
                                );
                                // Handle update action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.blue, // Background color
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
        ));
  }
}
