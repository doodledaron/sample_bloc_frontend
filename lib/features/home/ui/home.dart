import 'package:bloc_shop_app/features/cart/ui/cart.dart';
import 'package:bloc_shop_app/features/home/ui/product_tile_widget.dart';
import 'package:bloc_shop_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_shop_app/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    homeBloc.add(
      HomeInitialEvent(),
    );
  }

  @override
  void dispose() {
    homeBloc.close(); // Close homeBloc when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      //For this, I only want to listen when UI get action state
      // listenWhen: (previous, current) => current is HomeActionState,
      //For this, I only want to build when UI dont get the action state (which means UI get the HomeState)
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        //listen to the state, the state is emmited from homebloc
        if (state is HomeNavigateToCartPageActionState) {
          print('$state');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cart(),
            ),
          );
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Wishlist(),
            ),
          );
        } else if (state is HomeProductCartAddedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Item added to cart'),
            ),
          );
        } else if (state is HomeProductWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Item wishlisted'),
            ),
          );
        } else {
          print('current state: $state');
        }
      },
      builder: (context, state) {
        //IMPORTANT: if the state is action state, do not rebuild
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: const CircularProgressIndicator(),
              ),
            );
          case HomeLoadedState:
            //to access the variable in HomeLoadedState
            final successState = state as HomeLoadedState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                title: Text('Doo Grocer'),
                actions: [
                  //navigate to wishlist
                  IconButton(
                    onPressed: () {
                      //notifies a new event to the homebloc
                      homeBloc.add(
                        HomeWishlistButtonNavigateEvent(),
                      );
                    },
                    icon: Icon(Icons.favorite_outline_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      //notifies a new event to the homebloc

                      homeBloc.add(
                        HomeCartButtonNavigateEvent(),
                      );
                      print('$state');
                    },
                    icon: Icon(Icons.shopping_bag),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  //access the list of products in the HomeLoadedState
                  return ProductTileWidget(
                    productDataModel: successState.products[index],
                    homeBloc: homeBloc,
                  );
                },
              ),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return Scaffold(
              body: Center(
                child: Text('Unknown error occured'),
              ),
            );
        }
      },
    );
  }
}
