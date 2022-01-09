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
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 3,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                Expanded(
                    flex: 8,
                    child: Image.network(
                      widget.products[index].imageUrl,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Column(
                          children: const [
                            Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                            Text("something went worng")
                          ],
                        );
                      },
                    )),
                const Spacer(flex: 1),
                Expanded(flex: 1, child: Text("Name: ${widget.products[index].name}")),
                const Spacer(flex: 1),
                Expanded(flex: 2, child: Text("Price: ${widget.products[index].price}RM ")),
              ],
            ),
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
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
