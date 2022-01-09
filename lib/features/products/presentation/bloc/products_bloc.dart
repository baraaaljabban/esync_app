import 'package:bloc/bloc.dart';
import 'package:esync_app/features/products/domain/entities/product_entity.dart';
import 'package:esync_app/features/products/domain/usecases/get_more_products.dart';
import 'package:esync_app/features/products/domain/usecases/get_products.dart';
import 'package:rxdart/rxdart.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetMoreProducts moreProductsUsecase;
  final GetProducts getProductsUsecase;
  int pageNumber = 1;
  ProductsBloc({
    required this.moreProductsUsecase,
    required this.getProductsUsecase,
  }) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) {});

    on<GetProductsEvent>(_onGetProducts);
    on<GetMoreProductsEvent>(
      _onGetMoreProductsEvent,
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }

  _onGetProducts(GetProductsEvent event, Emitter<ProductsState> emit) async {
    emit(LoadingProductsState());
    var result = await getProductsUsecase();
    result.fold(
        (l) => emit(LoadFailedState()),
        (r) => {
              emit(ProductsLoadedState(products: r, isReachedMax: false)),
            });
  }

  /// trigger when feed screen scroll to bottom of list
  _onGetMoreProductsEvent(GetMoreProductsEvent event, Emitter<ProductsState> emit) async {
    emit(LoadingProductsState());
    var result = await moreProductsUsecase(params: LoadMoreParams(pageNumber: pageNumber));
    result.fold(
        (l) => emit(LoadFailedState()),
        (r) => {
              pageNumber++,
              emit(
                ProductsLoadedState(
                  products: r,
                  isReachedMax: true,
                ),
              ),
            });
  }
}
