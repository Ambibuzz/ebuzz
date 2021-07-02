import 'dart:async';
import 'package:dio/dio.dart';
import 'package:ebuzz/home/model/globaldefaultsmodel.dart';
import 'package:flutter/material.dart';
import 'package:ebuzz/common_models/item_group.dart';
import 'package:ebuzz/common_models/item_price_model.dart';
import 'package:ebuzz/common_models/items_model.dart';
import 'package:ebuzz/common_models/product.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:flutter/cupertino.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_toast.dart';


class CommonService {
  //for fetching batch list
  Future<List<String>> getBatchList(BuildContext context) async {
    List<String> salesInvoiceList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = batchUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        salesInvoiceList.add(listJson['batch_id']);
      }
      return salesInvoiceList;
    } catch (e) {
      exception(e, context);
    }
    return salesInvoiceList;
  }

  //for fetching company list
  Future<List<String>> getCompanyList(BuildContext context) async {
    List<String> companylist = [];
    List list;
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String so = companyListUrl();
      final response = await _dio.get(so);
      var data = response.data;
      list = data['data'];
      for (var listJson in list) {
        companylist.add(listJson['name']);
      }
      return companylist;
    } catch (e) {
      exception(e, context);
    }
    return companylist;
  }

  // Future<Customer> getCustomerDetail(
  //     String customerName, BuildContext context) async {
  //   Customer customer = Customer();
  //   try {
  //     Dio _dio = await BaseDio().getBaseDio();
  //     final String cu = customerDetailUrl(customerName);
  //     final response = await _dio.get(cu);
  //     var data = response.data;
  //     customer = Customer.fromJson(data['data']);
  //     return customer;
  //   } catch (e) {
  //     exception(e, context);
  //   }
  //   return customer;
  // }

  Future<List<String>> getCustomerGroupList(BuildContext context) async {
    List<String> customerGroupList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String customerGroup = customerGroupUrl();
      final response = await _dio.get(customerGroup);
      var data = response.data;
      List listData = data['data'];
      listData.forEach((customerJson) {
        customerGroupList.add(customerJson['customer_group_name']);
      });

      return customerGroupList;
    } catch (e) {
      exception(e, context);
    }
    return customerGroupList;
  }

  //for fetching customer list
  Future<List<String>> getCustomerList(BuildContext context) async {
    List<String> customerlist = [];
    List list;
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String so = customerListUrl();
      final response = await _dio.get(so);
      var data = response.data;
      list = data['data'];
      for (var listJson in list) {
        customerlist.add(listJson['name']);
      }
      return customerlist;
    } catch (e) {
      exception(e, context);
    }
    return customerlist;
  }

  //for fetching delivery note string list
  Future<List<String>> getDeliveryNoteListFromRefernce(
      String name, BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = deliveryNoteDataUrl(name);
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data']['items'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['item_name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e, context);
    }
    return purchaseRecieptList;
  }

  //for fetching delivery note string list
  Future<List<String>> getDeliveryNoteSubmittedList(
      BuildContext context) async {
    List<String> deliveryNoteList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String dn = deliveryNoteUrl();
      final response = await _dio.get(dn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        deliveryNoteList.add(listJson['name']);
      }
      return deliveryNoteList;
    } catch (e) {
      exception(e, context);
    }
    return deliveryNoteList;
  }

  //For fetching itemcode data from barcode api
  Future<String> getItemCodeFromBarcode(
      String barcode, BuildContext context) async {
    String itemCode = '';
    try {
      final String url = barcodeUrl(barcode);
      Dio _dio = await BaseDio().getBaseDio();
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        var data = response.data;
        itemCode = data['message']['item'];
        return itemCode;
      }
      if (response.statusCode == 417) {
        fluttertoast(whiteColor, blueAccent, 'Invalid Barcode');
        return '';
      }
    } catch (e) {
      exception(e, context);
    }
    return itemCode;
  }

  //For fetching itemcode from itemname
  Future<String> getItemCodeFromItemName(
      String text, BuildContext context) async {
    String itemCode = '';
    try {
      Dio _dio = await BaseDio().getBaseDio();

      final String url = specificItemNameDataUrl(text);
      final response = await _dio.get(
        url,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        itemCode = data['data'][0]['name'];
        return itemCode;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      exception(e, context);
    }
    return itemCode;
  }

  //For fetching itemcode list
  Future<List<String>> getItemCodeList(BuildContext context) async {
    List listData = [];
    List<String> itemCodeList = [];
    try {
      final String itemList = itemListUrl();
      Dio _dio = await BaseDio().getBaseDio();
      final response = await _dio.get(
        itemList,
      );
      var data = response.data;
      listData = data['data'];
      for (int i = 0; i < listData.length; i++) {
        itemCodeList.add(listData[i]['item_code']);
      }
      return itemCodeList;
    } catch (e) {
      exception(e, context);
    }
    return itemCodeList;
  }

  Future<List<String>> getItemGroupList(BuildContext context) async {
    List<ItemGroupModel> itemGroupList = [];
    List<String> itemGroupName = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String itemGroup = itemGroupUrl();
      final response = await _dio.get(itemGroup);
      var data = response.data;
      List listData = data['data'];
      listData.forEach((itemGroup) {
        itemGroupList.add(ItemGroupModel.fromJson(itemGroup));
      });
      itemGroupList.forEach((item) {
        itemGroupName.add(item.name!);
      });
      return itemGroupName;
    } catch (e) {
      exception(e, context);
    }
    return itemGroupName;
  }

  //For fetching list of items (itemname,itemcode) data from item api
  Future<List> getItemList(BuildContext context) async {
    List listData = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String itemList = itemListUrl();
      final response = await _dio.get(
        itemList,
      );
      var data = response.data;
      listData = data['data'];
    } catch (e) {
      exception(e, context);
    }
    return listData;
  }

  Future<List<String>> getItemNameList(BuildContext context) async {
    List<ItemsModel> itemsList = [];
    List<String> itemNameList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String itemList = itemListUrl();
      final response = await _dio.get(
        itemList,
      );
      var data = response.data;
      List listData = data['data'];
      listData.forEach((itemData) {
        itemsList.add(ItemsModel.fromJson(itemData));
      });
      itemsList.forEach((item) {
        itemNameList.add(item.itemName);
      });
      return itemNameList;
    } catch (e) {
      exception(e, context);
    }
    return itemNameList;
  }

  Future<List<ItemsModel>> getItemsList(BuildContext context) async {
    List<ItemsModel> itemsList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String itemList = itemListUrl();
      final response = await _dio.get(
        itemList,
      );
      var data = response.data;
      List listData = data['data'];
      listData.forEach((itemData) {
        itemsList.add(ItemsModel.fromJson(itemData));
      });
      return itemsList;
    } catch (e) {
      exception(e, context);
    }
    return itemsList;
  }

  Future<List<String>> getLabelsList(
      BuildContext context, List<String> modules) async {
    List<String> labelsList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String labelsUrl = labelsListUrl();
      for (String module in modules) {
        final response = await _dio.post(labelsUrl, data: {'page': module});
        var data = response.data;
        List listDataShotcuts = data['message']['shortcuts']['items'];
        List listDataCards = data['message']['cards']['items'];
        listDataShotcuts.forEach((l) {
          String label = l['label'];
          if (!labelsList.contains(label)) {
            labelsList.add(label);
          }
        });
        listDataCards.forEach((l) {
          List labels = l['links'];
          labels.forEach((cl) {
            String cardLabel = cl['label'];
            if (!labelsList.contains(cardLabel)) {
              labelsList.add(cardLabel);
            }
          });
        });
      }
      return labelsList;
    } catch (e) {
      exception(e, context);
    }
    return labelsList;
  }

  // Future<Lead> getLeadDetail(String leadName, BuildContext context) async {
  //   Lead lead = Lead();
  //   try {
  //     Dio _dio = await BaseDio().getBaseDio();
  //     final String lu = leadDetailFromLeadNameUrl(leadName);
  //     final response = await _dio.get(lu);
  //     var data = response.data;
  //     lead = Lead.fromJson(data['data'][0]);
  //     return lead;
  //   } catch (e) {
  //     exception(e, context);
  //   }
  //   return lead;
  // }

  Future<List<String>> getLeadList(BuildContext context) async {
    List<String> customerlist = [];
    List list;
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String gl = leadListUrl();
      final response = await _dio.get(gl);
      var data = response.data;
      list = data['data'];
      for (var listJson in list) {
        customerlist.add(listJson['lead_name']);
      }
      return customerlist;
    } catch (e) {
      exception(e, context);
    }
    return customerlist;
  }

  Future<List<String>> getModulesList(BuildContext context) async {
    List<String> modulesList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String modules = modulesListUrl();
      final response = await _dio.get(modules);
      var data = response.data;
      List listData = data['message'];
      listData.forEach((listJson) {
        if (!modulesList.contains(listJson['label'])) {
          modulesList.add(listJson['label']);
        }
      });
      return modulesList;
    } catch (e) {
      exception(e, context);
    }
    return modulesList;
  }

  Future<double> getPriceForItem(
      String? itemCode, String customer, BuildContext context) async {
    double pricelistdata = 0;
    String? company = await getCompany();
    ItemPriceModel _itemPriceModel = ItemPriceModel(
        company: company,
        conversionrate: 1.0,
        customer: customer,
        doctype: 'Sales Invoice',
        itemcode: itemCode,
        pricelist: 'Buy and Sell');
    try {
      final String url = itemPriceUrl();
      Dio _dio = await BaseDio().getBaseDio();
      final response = await _dio.post(url, data: _itemPriceModel);
      if (response.statusCode == 200) {
        var data = response.data;
        pricelistdata = data['message']['price_list_rate'];
      }
      return pricelistdata;
    } catch (e) {
      exception(e, context);
    }
    return pricelistdata;
  }

  //For fetching data from item api in product model
  Future<Product> getProductFromItemCode(
      String text, BuildContext context) async {
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = itemDataUrl(text);
      final response = await _dio.get(
        url,
      );
      if (response.statusCode == 200) {
        return Product.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      exception(e, context);
    }
    return Product();
  }

  //For fetching data for specific itemname from item api
  Future<Product> getProductFromItemName(
      String text, BuildContext context) async {
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = specificItemNameDataUrl(text);
      final response = await _dio.get(
        url,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Product.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      exception(e, context);
    }
    return Product();
  }

  //for fetching purchase invoice string list
  Future<List<String>> getPurchaseInvoiceListFromReference(
      String name, BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = purchaseInvoiceDataUrl(name);
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data']['items'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['item_name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e, context);
    }
    return purchaseRecieptList;
  }

  //for fetching purchase invoice string list
  Future<List<String>> getPurchaseInvoiceSubmittedList(
      BuildContext context) async {
    List<String> purchaseInvoiceList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = purchaseInvoiceSubmittedUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        purchaseInvoiceList.add(listJson['name']);
      }
      return purchaseInvoiceList;
    } catch (e) {
      exception(e, context);
    }
    return purchaseInvoiceList;
  }

  //for fetching purchase receipt string list
  Future<List<String>> getPurchaseRecieptListFromReference(
      String name, BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = purchaseRecieptDataUrl(name);
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data']['items'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['item_name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e, context);
    }
    return purchaseRecieptList;
  }

  //for fetching purchase receipt string list
  Future<List<String>> getPurchaseRecieptSubmittedList(
      BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = purchaseRecieptSubmittedUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e, context);
    }
    return purchaseRecieptList;
  }

  //for fetching sales invoice string list
  Future<List<String>> getSalesInvoiceList(
      String name, BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = salesInvoiceDataUrl(name);
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data']['items'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['item_name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e, context);
    }
    return purchaseRecieptList;
  }

  //for fetching sales invoice string list
  Future<List<String>> getSalesInvoiceSubmittedList(
      BuildContext context) async {
    List<String> salesInvoiceList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = salesInvoiceSubmittedUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        salesInvoiceList.add(listJson['name']);
      }
      return salesInvoiceList;
    } catch (e) {
      exception(e, context);
    }
    return salesInvoiceList;
  }

  //for fetching stock entry string list
  Future<List<String>> getStockEntryListFromReference(
      String name, BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = stockEntryDataUrl(name);
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data']['items'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['item_name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e, context);
    }
    return purchaseRecieptList;
  }

  //for fetching stock entry string list
  Future<List<String>> getStockEntrySubmittedList(BuildContext context) async {
    List<String> stockEntryList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = stockEntrySubmittedUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        stockEntryList.add(listJson['name']);
      }
      return stockEntryList;
    } catch (e) {
      exception(e, context);
    }
    return stockEntryList;
  }

  Future<List<String>> getTerritoryList(BuildContext context) async {
    List<String> territoryList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String territory = territoryUrl();
      final response = await _dio.get(territory);
      var data = response.data;
      List listData = data['data'];
      listData.forEach((territoryJson) {
        territoryList.add(territoryJson['territory_name']);
      });

      return territoryList;
    } catch (e) {
      exception(e, context);
    }
    return territoryList;
  }

  //for fetching username
  Future<String> getUsername(BuildContext context) async {
    String username = '';
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = usernameUrl();
      final response = await _dio.get(url);
      var data = response.data;
      username = data['message'];
      return username;
    } catch (e) {
      exception(e, context);
    }
    return username;
  }

  //for fetching warehouse list
  Future<List<String>> getWarehouseList(
      String company, BuildContext context) async {
    List<String> warehouselist = [];
    List list;
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String so = warehouseList(company);
      final response = await _dio.get(so);
      var data = response.data;
      list = data['data'];
      for (var listJson in list) {
        warehouselist.add(listJson['name']);
      }
      return warehouselist;
    } catch (e) {
      exception(e, context);
    }
    return warehouselist;
  }

  //For fetching warehousequantity data from stock ledger entry api
  Future<List<double>> getWareHouseQtyData(
      String itemCode, BuildContext context) async {
    List<String> unique = [];
    List<double> warehouseQty = [];
    unique.clear();
    warehouseQty.clear();
    try {
      Dio _dio = await BaseDio().getBaseDio();

      final String dateCreationUrl = stockLedgerUrl(
        itemCode,
      );
      final dateCreationResponse = await _dio.get(
        dateCreationUrl,
      );
      List<String> warehouseList = [];
      var decData = await dateCreationResponse.data;
      for (int i = 0; i < decData['data'].length; i++) {
        warehouseList.add(decData['data'][i]['warehouse']);
      }
      for (int i = 0; i < warehouseList.length; i++) {
        if (!unique.contains(warehouseList[i])) {
          unique.add(warehouseList[i]);
          warehouseQty.add(decData['data'][i]['qty_after_transaction']);
        }
      }
    } catch (e) {
      exception(e, context);
    }
    return warehouseQty;
  }

  //For fetching warehousename data from stock ledger entry api
  Future<List<String>> getWareHouseNameData(
      String itemCode, BuildContext context) async {
    List<String> unique = [];
    List<String> warehouseName = [];
    unique.clear();
    warehouseName.clear();
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String dateCreationUrl = stockLedgerUrl(itemCode);
      var dateCreationResponse = await _dio.get(
        dateCreationUrl,
      );
      List<String> warehouseList = [];

      var decData = await dateCreationResponse.data;
      for (int i = 0; i < decData['data'].length; i++) {
        warehouseList.add(decData['data'][i]['warehouse']);
      }
      for (int i = 0; i < warehouseList.length; i++) {
        if (!unique.contains(warehouseList[i])) {
          unique.add(warehouseList[i]);
          warehouseName.add(decData['data'][i]['warehouse']);
        }
      }
    } catch (e) {
      exception(e, context);
    }
    return warehouseName;
  }

  // Future<List<String>> getBomListFromItemName(
  //     String text, BuildContext context) async {
  //   List<Bom> bomList = [];
  //   List<String> bomNameList = [];
  //   try {
  //     Dio _dio = await BaseDio().getBaseDio();
  //     final String url = bomNameFromItemNameUrl(text);
  //     final response = await _dio.get(url);
  //     if (response.statusCode == 200) {
  //       var data = response.data['data'];
  //       var list = data as List;
  //       list.forEach((listJson) {
  //         bomList.add(Bom.fromJson(listJson));
  //       });
  //       bomList.forEach((bom) {
  //         bomNameList.add(bom.name);
  //       });
  //       return bomNameList;
  //     }
  //   } catch (e) {
  //     exception(e, context);
  //   }
  //   return [];
  // }

  // Future<List<String>> getBomListFromItem(
  //     String text, BuildContext context) async {
  //   List<Bom> bomList = [];
  //   List<String> bomNameList = [];
  //   try {
  //     Dio _dio = await BaseDio().getBaseDio();
  //     final String url = bomNameFromItemUrl(text);
  //     final response = await _dio.get(url);
  //     if (response.statusCode == 200) {
  //       var data = response.data['data'];
  //       var list = data as List;
  //       list.forEach((listJson) {
  //         bomList.add(Bom.fromJson(listJson));
  //       });
  //       bomList.forEach((bom) {
  //         bomNameList.add(bom.name);
  //       });
  //       return bomNameList;
  //     }
  //   } catch (e) {
  //     exception(e, context);
  //   }
  //   return [];
  // }

  Future sendEmail({
    @required recipients,
    // cc,
    // bcc,
    @required subject,
    @required content,
    @required doctype,
    doctypeName,
    // sendEmail,
    // printHtml,
    // sendMeACopy,
    // printFormat,
    // emailTemplate,
    attachments,
    // readReceipt,
    // printLetterhead
  }) async {
    var queryParams = {
      'recipients': recipients,
      'subject': subject,
      'content': content,
      'send_email': 1,
      'name': doctypeName,
      'doctype': doctype,
      'attachments': '${[attachments]}',
    };

    Dio dio = await BaseDio().getBaseDio();
    final response = await dio.post(
      '/api/method/frappe.core.doctype.communication.email.make',
      data: queryParams,

      // options: Options(contentType: Headers.formUrlEncodedContentType)
    );
    if (response.statusCode == 200) {
      print(response.data);
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future setGlobalDefaults(BuildContext context) async {
    GlobalDefaults globalDefaultsData;
    try {
      Dio dio = await BaseDio().getBaseDio();
      final String globaldefaults = globalDefaultsUrl();
      final response = await dio.get(globaldefaults);
      if (response.statusCode == 200) {
        var data = response.data;
        var listData = data['data'];
        globalDefaultsData = GlobalDefaults.fromJson(listData);
        setCompany(globalDefaultsData.company!);
        setCurrency(globalDefaultsData.currency!);
      }
    } catch (e) {
      exception(e, context);
    }
  }
}
