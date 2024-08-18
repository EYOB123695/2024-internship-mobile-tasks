import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product_entity.dart';
import '../bloc/bloc/updateproduct_bloc.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  late ProductEntity product;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _category = '';
  double _price = 0.0;
  String _description = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    product = ModalRoute.of(context)?.settings.arguments as ProductEntity;
    // Initialize fields with the current product's details
    _name = product.name;

    _price = product.price;
    _description = product.description;
  }

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
          'Update Product',
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
      body: BlocListener<UpdateproductBloc, UpdateproductState>(
        listener: (context, state) {
          if (state is UpdateproductSucess) {
            Navigator.of(context).pushReplacementNamed('/');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Product updated successfully')),
            );
            // Navigator.of(context).pop();
          } else if (state is UpdateproductLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Updating product...")),
            );
          } else if (state is UpdateproductFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      product.imageUrl,
                      width: 350,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Product Name Label and TextFormField
                  Text(
                    'Product Name',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF3E3E3E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: _name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: const Color(0xFFF3F3F3),
                    ),
                    onChanged: (value) => _name = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter product name' : null,
                  ),
                  const SizedBox(height: 16),
                  // Category Label and TextFormField
                  Text(
                    'Category',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF3E3E3E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: _category,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: const Color(0xFFF3F3F3),
                    ),
                    onChanged: (value) => _category = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter product category' : null,
                  ),
                  const SizedBox(height: 16),
                  // Price Label and TextFormField
                  Text(
                    'Price',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF3E3E3E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: _price.toString(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: const Color(0xFFF3F3F3),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) =>
                        _price = double.tryParse(value) ?? 0.0,
                    validator: (value) => value!.isEmpty ? 'Enter price' : null,
                  ),
                  const SizedBox(height: 16),
                  // Description Label and TextFormField
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF3E3E3E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: _description,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: const Color(0xFFF3F3F3),
                    ),
                    maxLines: 10,
                    onChanged: (value) => _description = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter description' : null,
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<UpdateproductBloc, UpdateproductState>(
                    builder: (context, state) {
                      if (state is UpdateproductLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<UpdateproductBloc>().add(
                                    UpdateProductRequest(
                                      id: product.id,
                                      product: ProductEntity(
                                        id: product.id,
                                        name: _name,
                                        description: _description,
                                        price: _price,

                                        imageUrl: product
                                            .imageUrl, // Keep the existing image URL
                                      ),
                                    ),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: const Color(0xFF3F51F3),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text(
                            'Update Product',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }
// }

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});

//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _categoryController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();

//   // File to store the picked image
//   File? _image;

//   // Function to pick an image from the gallery
//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.blue),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Text(
//           'Add Product',
//           style: GoogleFonts.poppins(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: const Color(0xFF3E3E3E),
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const SizedBox(height: 20),
//               // GestureDetector for picking an image
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   width: double.infinity,
//                   height: 200,
//                   color: const Color(0xFFF3F3F3),
//                   child: _image == null
//                       ? const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Icon(
//                               Icons.image,
//                               size: 40,
//                               color: Colors.blue,
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               'Upload Image',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         )
//                       : Image.file(
//                           _image!,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Name TextField
//               Text(
//                 'Name',
//                 style: GoogleFonts.poppins(
//                   color: const Color(0xFF3E3E3E),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: TextField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFFF3F3F3),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Category TextField
//               Text(
//                 'Category',
//                 style: GoogleFonts.poppins(
//                   color: const Color(0xFF3E3E3E),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: TextField(
//                   controller: _categoryController,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFFF3F3F3),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Price TextField
//               Text(
//                 'Price',
//                 style: GoogleFonts.poppins(
//                   color: const Color(0xFF3E3E3E),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: TextField(
//                   controller: _priceController,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFFF3F3F3),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Description TextField
//               Text(
//                 'Description',
//                 style: GoogleFonts.poppins(
//                   color: const Color(0xFF3E3E3E),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Container(
//                   height: 250,
//                   child: TextField(
//                     controller: _descriptionController,
//                     maxLines: 100,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: const Color(0xFFF3F3F3),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Add Button
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Container(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_image == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Please upload an image'),
//                           ),
//                         );
//                         return;
//                       }

//                       // Creating a new product with the provided details
//                       final newProduct = Product(
//                         imageFilePath: _image!.path,
//                         texts: [
//                           _nameController.text,
//                           _priceController.text,
//                           _categoryController.text,
//                           '4.0' // Default rating or other details
//                         ],
//                       );

//                       // Adding the new product to the provider
//                       Provider.of<ProductProvider>(context, listen: false)
//                           .addProduct(newProduct);

//                       // Navigating back after adding the product
//                       Navigator.of(context).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                       backgroundColor: const Color(0xFF3F51F3),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       textStyle: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     child: Text(
//                       'ADD',
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: const Color(0xFFFFFFFF),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Container(
//                   width: double.infinity,
//                   height: 50,
//                   child: OutlinedButton(
//                     onPressed: () {
//                       // Currently does nothing
//                     },
//                     style: OutlinedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                       foregroundColor: Colors.red,
//                       side: const BorderSide(color: Colors.red),
//                       padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       textStyle: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     child: Text(
//                       'DELETE',
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
