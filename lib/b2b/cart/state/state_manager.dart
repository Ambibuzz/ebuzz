import 'package:ebuzz/b2b/cart/model/cart.dart';
import 'package:riverpod/riverpod.dart';

final cartListProvider = StateNotifierProvider((ref){
  return CartList([]);
});