import 'package:flutter/material.dart';
import 'product.dart';
import 'text_widget.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  double _sliderValue = 50.0; // Initial value for the slider
  bool _showFilters = false;

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
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
            TextWidget(
                onFilterPressed:
                    _toggleFilters), // Pass the _toggleFilters method
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              child: const ProductCard(
                imageAssetPath: 'images/image.png',
                texts: [
                  'Derby Leather Shoes',
                  '120\$',
                  'Men’s shoe',
                  '4.0',
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              child: Image.asset('images/image.png'),
            ),
            AnimatedOpacity(
              opacity: _showFilters ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Visibility(
                visible: _showFilters,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(12.0),
                      child: const Text(
                        'Category',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.blue,
                              inactiveTrackColor: Colors.blue.withOpacity(0.3),
                              thumbColor: Colors.blue,
                              overlayColor: Colors.blue.withOpacity(0.2),
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 10.0),
                              overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 20.0),
                            ),
                            child: Slider(
                              value: _sliderValue,
                              min: 0,
                              max: 100,
                              divisions: 10,
                              label: _sliderValue.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _sliderValue = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(12.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('APPLY'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
