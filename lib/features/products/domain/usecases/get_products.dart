import 'package:dartz/dartz.dart';
import 'package:esync_app/core/base_use_cases.dart';
import 'package:esync_app/core/errors/failures.dart';
import 'package:esync_app/features/products/domain/entities/product_entity.dart';
import 'package:esync_app/features/products/domain/repositories/products_repository.dart';

class GetProducts extends UseCaseNoParams<List<ProductEntity>> {
  GetProducts({
    required this.repository,
  });

  ProductsRepository repository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repository.loadProducts();
  }
}


