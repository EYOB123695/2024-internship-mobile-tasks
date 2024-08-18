import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/bloc/homepage_bloc.dart';

import 'product.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _refreshData(BuildContext context) async {
    context.read<HomepageBloc>().add(HomePageLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Dispatch the load event in the initState
    context.read<HomepageBloc>().add(HomePageLoadEvent());

    return Scaffold(
      // Scaffold widget provides the basic visual layout structure
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
                      fontWeight: FontWeight.w600,
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
            padding: const EdgeInsets.only(right: 13.0),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(context),
        child:
            BlocBuilder<HomepageBloc, HomepageState>(builder: (context, state) {
          if (state is HomePageLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomePageError) {
            return Center(child: Text(state.Message));
          } else if (state is HomePageLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
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
                          Navigator.of(context).pushNamed(
                            '/search-product',
                            arguments: state.products,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  // child: ListView.builder(

                  //   padding: const EdgeInsets.all(8),
                  //   itemCount: state.products.length,
                  //   itemBuilder: (context, index) {
                  //     final product = state.products[index];
                  //     return
                  child: SizedBox(
                    height: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 13.0),
                      child: ProductCard(
                        //imageFilePath: product.imageUrl,
                        products: state.products,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return (Text('Something went wrong'));
        }),
      ),
      floatingActionButton: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: Color(0xFF3F51F3),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/add-product');
          },
          backgroundColor: Colors.transparent,
          child: const Icon(Icons.add, color: Colors.white),
          elevation: 0,
        ),
      ),
    );
  }
}
