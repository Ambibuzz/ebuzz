import 'package:dio/dio.dart';
import 'package:ebuzz/b2b/cart/model/cart.dart';
import 'package:ebuzz/b2b/cart/model/quotation_model.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';

class CartService {
  Future postQuotation(List<Cart> items) async {
    List<QuotationItems> qoitems = [];
    items.map((cart) {
      qoitems.add(QuotationItems(
          itemcode: cart.itemCode, quantity: cart.quantity, rate: cart.rate));
    }).toList();
    QuotationModel _quotationModel =
        QuotationModel(currency: 'INR', quotationitems: qoitems);
    final String url = quotationUrl();
    Dio _dio = await BaseDio().getBaseDio();
    final response = await _dio.post(url, data: _quotationModel);
    if (response.statusCode == 200) {
      print(response.data);
      fluttertoast(whiteColor, blueAccent, 'Quotation Posted Successfully');
    }
  }
}
