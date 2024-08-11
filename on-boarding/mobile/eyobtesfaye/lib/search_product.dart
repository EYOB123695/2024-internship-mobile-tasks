// search_product.dart
import 'package:flutter/material.dart';
import 'bottomfilter.dart';
import 'product.dart';
import 'text_widget.dart';
import 'product_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  double _sliderValue = 50.0; // Initial value for the slider

  void _updateSliderValue(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  void _openFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the bottom sheet to be scrollable if needed
      builder: (BuildContext context) {
        return BottomFilter(
          sliderValue: _sliderValue,
          onSliderChanged: _updateSliderValue,
          onApplyPressed: () {
            Navigator.pop(context); // Close the bottom sheet
          },
        );
      },
    );
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
        title: const Text(
          'Search Product',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextWidget(onFilterPressed: _openFilter),
            Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                return Column(
                  children: productProvider.products.map((product) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(12.0),
                      child: ProductCard(
                        imageFilePath: product.imageFilePath,
                        texts: product.texts,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
