import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/item/model/product.dart';
import 'package:flutter/material.dart';

//ItemDetailWidget class is a reusable widget for displaying data from item api

class ItemDetailWidget extends StatelessWidget {
  final AsyncSnapshot<Product> snapshot;
  final String apiurl;
  const ItemDetailWidget({this.snapshot, this.apiurl});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Container(
                width: displayWidth(context) * 0.32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      child: Text(
                        'Item code',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Item name',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35,
                      child: Text(
                        'Item group',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35,
                      child: Text(
                        'HSN/SAC',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35,
                      child: Text(
                        'Brand',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35,
                      child: Text(
                        'Description',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35,
                      child: Text(
                        'Shell Life (Days)',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: displayWidth(context) * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        snapshot.data.itemCode,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        snapshot.data.itemName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35,
                      child: Text(
                        snapshot.data.itemGroup,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35,
                      child: Text(
                        snapshot.data.hsn.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35,
                      child: Text(
                        snapshot.data.brand,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35,
                      child: Text(
                        snapshot.data.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 35,
                      child: Text(
                        snapshot.data.shellLife.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        snapshot.data.image == null || snapshot.data.image == ''
            ? Image.asset(
                'assets/inf.jpg',
                fit: BoxFit.cover,
                width: 200,
                height: 300,
              )
            : Image.network(
                apiurl + snapshot.data.image,
                fit: BoxFit.cover,
                width: 200,
                height: 300,
              ),
        Column(
          children: [],
        ),
      ],
    );
  }
}
