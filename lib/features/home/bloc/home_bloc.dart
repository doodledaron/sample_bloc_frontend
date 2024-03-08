import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_shop_app/data/cart_items.dart';
import 'package:bloc_shop_app/data/wishlist_items.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/home_product_data_model.dart';
import '../../../data/grocery_data.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //all the events will be handled here
  HomeBloc() : super(HomeInitial()) {
    // on THIS event, emit THIS state to UI
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeInitialEvent>(homeInitialEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    //emit loading state
    emit(HomeLoadingState());
    await Future.delayed(
      Duration(seconds: 3),
    );
    //then emit the loaded state

    emit(
      //the list of products will be stored in HomeLoadedState, where could be access through home UI
      HomeLoadedState(
        products: GroceryData.groceryProducts
            //map each element into product data model
            .map(
              (product) => ProductDataModel(
                  id: product['id'],
                  name: product['name'],
                  description: product['description'],
                  price: product['price'],
                  imageUrl: product['url']),
            )
            .toList(),
      ),
    );
  }

//this state will be emitted  when the Cart Button is clicked at the product card
  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart product clicked');
    //pass data to the bloc via event
    //clicked product is the data we need to construct HomeProductCartButtonClickedEvent
    cartItems.add(event.clickedProduct);
    emit(
      HomeProductCartAddedActionState(),
    );
  }

//this state will be emitted  when the Wishlist Button is clicked at the product card
  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Wishlist product clicked');
    wishlistItems.add(event.clickedProduct);
    emit(
      HomeProductWishlistedActionState(),
    );
  }

//this state will be emitted  when the Wishlist Button is clicked at the AppBar (navigation)
  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist navigation clicked');
    emit(
      HomeNavigateToWishlistPageActionState(),
    );
  }

//this state will be emitted  when the Navigation Button is clicked at the AppBar (navigation)
  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart navigation clicked');
    emit(
      HomeNavigateToCartPageActionState(),
    );
  }
}
