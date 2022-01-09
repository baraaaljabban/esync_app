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
  List<ProductEntity> products = [];

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
    products.clear();
    result.fold(
        (l) => emit(LoadFailedState()),
        (r) => {
              products.addAll(r),
              emit(ProductsLoadedState(products: products, isReachedMax: false)),
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
              products.addAll(r),
              emit(
                ProductsLoadedState(
                  products: products,
                  //this now is hard coded for delivery purpose only 
                  isReachedMax: true,
                ),
              ),
            });
  }
}
