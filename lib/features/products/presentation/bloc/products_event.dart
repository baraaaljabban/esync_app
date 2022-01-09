part of 'products_bloc.dart';

abstract class ProductsEvent {
  const ProductsEvent();
}

class GetProductsEvent extends ProductsEvent {}

class GetMoreProductsEvent extends ProductsEvent {}
