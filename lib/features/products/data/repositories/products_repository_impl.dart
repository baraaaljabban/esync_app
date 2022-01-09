import 'package:dartz/dartz.dart';
import 'package:esync_app/core/errors/error_handler.dart';
import 'package:esync_app/core/errors/failures.dart';
import 'package:esync_app/features/products/data/datasources/products_remote_data_source.dart';
import 'package:esync_app/features/products/domain/entities/product_entity.dart';
import 'package:esync_app/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository with ErrorHandler {
  ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImpl({
    required this.productsRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> loadProducts() async {
    try {
      var result = await productsRemoteDataSource.loadProducts();
      return Right(result);
    } catch (e) {
      if (e is Exception) {
        return Left(mapCommonExceptionToFailure(e));
      }
      return Left(UnhandledFailure(className: e.runtimeType.toString(), message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> loadMoreProducts({required int pageNumber}) async {
    try {
      var result = await productsRemoteDataSource.loadMoreProducts(pageNumber: pageNumber);
      return Right(result);
    } catch (e) {
      if (e is Exception) {
        return Left(mapCommonExceptionToFailure(e));
      }
      return Left(UnhandledFailure(className: e.runtimeType.toString(), message: e.toString()));
    }
  }
}
