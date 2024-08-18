import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product_entity.dart';
import '../bloc/bloc/searchproduct_bloc.dart';
import '../widgets/text_widget.dart';
import 'bottomfilter.dart';
import 'product.dart';

class SearchProduct extends StatefulWidget {
  final List<ProductEntity> products;
  const SearchProduct({Key? key, required this.products}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  void initState() {
    super.initState();
    context
        .read<SearchproductBloc>()
        .add(LoadproductsEvent(products: widget.products));
  }

  void _openFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocBuilder<SearchproductBloc, SearchproductState>(
          builder: (context, state) {
            double sliderValue =
                state is ProductsFilteredState ? state.sliderValue : 50.0;

            return BottomFilter(
              sliderValue: sliderValue,
              onSliderChanged: (value) {
                context.read<SearchproductBloc>().add(FilteredProductsEvent(
                      sliderValue: value,
                      products: widget.products,
                    ));
              },
              onApplyPressed: () {
                Navigator.pop(context); // Close the bottom sheet
              },
            );
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
      body: BlocBuilder<SearchproductBloc, SearchproductState>(
        builder: (context, state) {
          if (state is ProductsFilteredState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(onFilterPressed: _openFilter),
                const SizedBox(height: 20), // Add some spacing
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    itemCount: state.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = state.filteredProducts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          height: 1500,
                          child: ProductCard(
                            // Pass individual product as a list
                            products: [product],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is SearchproductLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
