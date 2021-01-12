import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:flutter/material.dart';

//UniqueWarehouseList class is a reusble widget for displaying data of list of unique warehouse
class UniqueWarehouseList extends StatelessWidget {
  final List<String> warehouseName;
  final List<double> warehouseQty;

  UniqueWarehouseList({this.warehouseName, this.warehouseQty});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
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
                  style: displayWidth(context) > 600
                      ? TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                      : TextStyles.t18BlackBold,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Quantity',
                  textAlign: TextAlign.center,
                  style: displayWidth(context) > 600
                      ? TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                      : TextStyles.t18BlackBold,
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
              itemCount: warehouseName.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            warehouseName[index].toString(),
                            style: displayWidth(context) > 600
                                ? TextStyle(
                                    fontSize: 28,
                                  )
                                : TextStyles.t16Black,
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
                              warehouseQty[index].toString(),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: displayWidth(context) > 600
                                  ? TextStyle(
                                      fontSize: 28,
                                    )
                                  : TextStyles.t16Black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
