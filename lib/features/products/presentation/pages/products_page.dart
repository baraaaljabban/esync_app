import 'package:esync_app/features/products/domain/entities/product_entity.dart';
import 'package:esync_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:esync_app/features/products/presentation/widgets/end_loading_controller.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
          //TODO : add loading on load state
        },
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
