import 'package:flutter_riverpod/flutter_riverpod.dart';

class Cart {
  int quantity;
  final String id;
  final String itemName;
  final String itemCode;
  final String imageUrl;
  final double rate;
  Cart(
      {this.quantity,
      this.id,
      this.itemName,
      this.imageUrl,
      this.rate,
      this.itemCode});
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        id: json['id'],
        imageUrl: json['image'],
        itemName: json['name'],
        quantity: json['quantity'],
        itemCode: json['itemcode'],
        rate: json['rate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.itemName;
    data['image'] = this.imageUrl;
    data['quantity'] = this.quantity;
    data['itemcode'] = this.itemCode;
    data['rate'] = this.rate;
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
              quantity: cartItem.quantity + quantity,
              itemCode: cart.itemCode,
              rate: cart.rate)
        else
          cartItem
    ];
  }

  void remove(Cart removeItem) {
    state = state.where((cart) => cart.id != removeItem.id).toList();
  }
}
