part of 'products_bloc.dart';

abstract class ProductsState {
  const ProductsState();
}

class ProductsInitial extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final List<ProductEntity> products;
  final bool isReachedMax;

  ProductsLoadedState({
    required this.products,
    required this.isReachedMax,
  });
}

class LoadFailedState extends ProductsState {}

class LoadingProductsState extends ProductsState{}