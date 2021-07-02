import 'package:ebuzz/common/colors.dart';
import 'package:flutter/material.dart';

//UniqueWarehouseList class is a reusble widget for displaying data of list of unique warehouse
class UniqueWarehouseList extends StatelessWidget {
  final List<String>? warehouseName;
  final List<double>? warehouseQty;

  UniqueWarehouseList({this.warehouseName, this.warehouseQty});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: blackColor,
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                'Name',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: blackColor),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Quantity',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: blackColor),
              ),
            ),
          ],
        ),
        Divider(
          color: blackColor,
          height: 5,
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: warehouseName!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          warehouseName![index].toString(),
                          style: TextStyle(fontSize: 14, color: blackColor),
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            warehouseQty![index].toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, color: blackColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ],
    );
  }
}
