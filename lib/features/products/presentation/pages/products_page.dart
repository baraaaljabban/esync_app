import 'package:esync_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:esync_app/features/products/presentation/widgets/products_list_view_contrller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({
    Key? key,
  }) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    BlocProvider.of<ProductsBloc>(context).add(GetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProductsLoadedState) {
            return ProductListViewController(
              products: state.products,
              isReachedMax: state.isReachedMax,
            );
          }
          return Container();
        },
      ),
    );
  }
}
