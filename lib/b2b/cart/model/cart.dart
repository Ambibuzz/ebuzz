import 'package:flutter_riverpod/flutter_riverpod.dart';

class Cart {
  int quantity;
  final String id;
  final String itemName;
  final String imageUrl;
  Cart({this.quantity, this.id, this.itemName, this.imageUrl});
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        id: json['id'],
        imageUrl: json['image'],
        itemName: json['name'],
        quantity: json['quantity']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.itemName;
    data['image'] = this.imageUrl;
    data['quantity'] = this.quantity;
    return data;
  }
}

//create provider to manage state

class CartList extends StateNotifier<List<Cart>> {
  CartList(List<Cart> state) : super(state ?? []);

  void addAll(List<Cart> carts) {
    state.addAll(carts);
  }

  void add(Cart cart) {
    state = [...state, cart];
  }

  void edit(Cart cart, int quantity) {
    state = [
      for (final cartItem in state)
        if (cartItem.id == cart.id)
          Cart(
              id: cart.id,
              imageUrl: cart.imageUrl,
              itemName: cart.itemName,
              quantity: cartItem.quantity + quantity)
        else
          cartItem
    ];
  }

  void remove(Cart removeItem) {
    state = state.where((cart) => cart.id != removeItem.id).toList();
  }
}
