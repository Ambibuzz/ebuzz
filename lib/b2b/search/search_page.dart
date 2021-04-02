import 'package:ebuzz/b2b/items/ui/items_ui.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SearchPage extends StatefulWidget {
  final List<String> itemsList;
  SearchPage({this.itemsList});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  List<String> searchItemList = [];

  void search(String searchText) {
    searchItemList.clear();
    for (String item in widget.itemsList) {
      String itemLowerCase = item.toLowerCase();
      if (itemLowerCase.contains(searchText)) {
        searchItemList.add(item);
      }
      setState(() {});
    }
  }

  void clear() {
    searchItemList.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            searchBar(),
            searchItemList.isEmpty
                ? Container()
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchItemList.length,
                      itemBuilder: (context, index) {
                        String item = searchItemList[index];
                        return ListTile(
                          leading: Icon(
                            Icons.search,
                            color: greyDarkColor,
                            size: 20,
                          ),
                          title: Text(item),
                          onTap: () {
                            Navigator.pop(context, item);
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      width: displayWidth(context),
      height: displayHeight(context) * 0.1,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: greyDarkColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: greyDarkColor,
                      ),
                      onPressed: clear)),
              controller: searchController,
              onChanged: (item) {
                String itemLowercase = item.toLowerCase();
                search(itemLowercase);
              },
            ),
          ),
        ],
      ),
    );
  }
}
