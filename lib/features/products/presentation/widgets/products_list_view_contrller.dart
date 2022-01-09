import 'package:esync_app/features/products/domain/entities/product_entity.dart';
import 'package:esync_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:esync_app/features/products/presentation/widgets/end_loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListViewController extends StatefulWidget {
  final List<ProductEntity> products;
  final bool isReachedMax;

  const ProductListViewController({
    Key? key,
    required this.products,
    required this.isReachedMax,
  }) : super(key: key);

  @override
  _ProductListViewControllerState createState() => _ProductListViewControllerState();
}

class _ProductListViewControllerState extends State<ProductListViewController> {
  // flag to indicate if fetching the data
  // using in the infinite scrolling to avoid multiple dispatch to event
  // although there is a debounce implemented but seems still have the chance to call multiple
  bool _isFetching = false;

  final _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 45.0),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        // show the loading bar if is a t the bottom
        if (index > widget.products.length) {
          // if reaching max
          if (widget.isReachedMax) {
            return const EndLoadinController();
          }
          return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator()));
        }
        return Column(
          children: [
            Text(widget.products[index].name),
            Text(widget.products[index].price.toString()),
          ],
        );
      },
    );
  }

  /// scroll listener
  /// trigger upon scrolling
  /// if is at the bottom near 80%, it will trigger to load the next page
  void _onScroll() {
    if (_isBottom & !_isFetching & !widget.isReachedMax) {
      // set is fetching to avoid the event dispatched multiple times
      // which causing multiple api calls
      _isFetching = true;
      BlocProvider.of<ProductsBloc>(context).add(GetMoreProductsEvent());
    }
  }

  /// check if is near to bottom
  /// return [true] if is current scroll position is >= 80% of the scroll length
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }
}
