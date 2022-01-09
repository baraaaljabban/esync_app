import 'package:dartz/dartz.dart';
import 'package:esync_app/core/errors/failures.dart';
import 'package:esync_app/features/products/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> loadProducts();

  Future<Either<Failure, List<ProductEntity>>> loadMoreProducts({
    required int pageNumber,
  });
}
