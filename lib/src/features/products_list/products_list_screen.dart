import 'package:ecommerce_app/src/common_widgets/responsive_center.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/home_app_bar/home_app_bar.dart';
import 'package:ecommerce_app/src/features/products_list/products_grid.dart';
import 'package:ecommerce_app/src/features/products_list/products_search_text_field.dart';
import 'package:flutter/material.dart';

/// Shows the list of products with a search field at the top.
class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();
  bool _isFabVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
    _scrollController.addListener(_fabVisibility);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    _scrollController.removeListener(_fabVisibility);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  void _fabVisibility() {
    const offset = 1000.0;
    if (_scrollController.offset > offset) {
      setState(() => _isFabVisible = true);
    } else {
      setState(() => _isFabVisible = false);
    }
  }

  void _scrollUp() {
    const start = 0.0;
    _scrollController.animateTo(
      start,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: const [
          ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p16),
            child: ProductsSearchTextField(),
          ),
          ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p16),
            child: ProductsGrid(),
          ),
        ],
      ),
      floatingActionButton: _isFabVisible
          ? FloatingActionButton(
              onPressed: _scrollUp,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(
                Icons.arrow_upward,
              ),
            )
          : null,
    );
  }
}
