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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
    _scrollController.addListener(_scrollBehavior);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    _scrollController.removeListener(_scrollBehavior);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  _scrollBehavior() {
    if (_scrollController.position.atEdge) {
      final isTop = _scrollController.position.pixels == 0.0;
      isTop ? _scrollDown() : _scrollUp();
    }
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
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollBehavior,
        backgroundColor: Colors.grey.shade300,
        child: const Icon(
          Icons.arrow_upward,
        ),
      ),
    );
  }

  void _scrollUp() {
    const start = 0.0;
    _scrollController.animateTo(
      start,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void _scrollDown() {
    final end = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      end,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}
