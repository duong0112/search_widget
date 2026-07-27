<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

know whether this package might be useful for them.

## Features


## Getting started

start using the package.

## Usage

to `/example` folder.

```dart
import 'package:flutter/material.dart';

class SearchDemo extends StatefulWidget {
  const SearchDemo({super.key});

  @override
  State<SearchDemo> createState() => _SearchDemoState();
}

class _SearchDemoState extends State<SearchDemo> {
  SearchItemModel? selectedRemote;
  SearchItemModel? selectedLocal;
  TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 16);
  TextStyle textStyleSelected = TextStyle(color: Colors.white, fontSize: 16);

  TextStyle subTextStyle = TextStyle(color: Colors.black, fontSize: 12);
  TextStyle subTextStyleSelected = TextStyle(color: Colors.white, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 160, child: Text("search remote: ")),
            Expanded(
              child: InputSearch<ResponseSearch>.remote(
                searchController: SearchControllerCustom(
                  onSearch: (String keyword) async {
                    //function call api
                    return List.generate(10, (int index) {
                      String title = "$keyword $index";
                      String subTitle = "sub $keyword $index";
                      final model = ResponseSearch(
                        keySearch: "$title $subTitle",
                        id: index,
                        title: title,
                        subTitle: subTitle,
                      );
                      return SearchItemModel<ResponseSearch>(
                        id: model.id,
                        keySearch: model.keySearch,
                        data: model,
                      );
                    });
                  },
                ),
                idSelected: selectedRemote?.id,
                itemBuilder: (context, item, idSelected) {
                  //custom item UI
                  return Container(
                    color: idSelected? Colors.blue : Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.account_box_outlined),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.data?.title??"", style: idSelected? textStyleSelected : textStyle,),
                              Text(item.data?.subTitle??"", style: idSelected? subTextStyleSelected : subTextStyle,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                // heightBoxResponse: 50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                    style: BorderStyle.solid,
                    strokeAlign: 1,
                  ),
                ),
                borderFocus: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red, width: 2.0, style: BorderStyle.solid, strokeAlign: 1),
                ),
                onSelect: (item) {
                  setState(() {
                    selectedRemote = item;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 4,),
        Text("remote search selected: ${selectedRemote.toString()}"),
        SizedBox(height: 20,),
        Row(
          children: [
            SizedBox(width: 160, child: Text("search local: ")),
            Expanded(
              child: InputSearch<ResponseSearch>.local(
                items: [
                  ...List.generate(5, (int index) {
                    String title = "title local $index";
                    String subTitle = "subTitle local $index";
                    final model = ResponseSearch(
                      keySearch: "$title $subTitle",
                      id: index,
                      title: title,
                      subTitle: subTitle,
                    );
                    return SearchItemModel(
                      id: model.id,
                      keySearch: model.keySearch,
                      data: model,
                    );
                  }),
                ],
                idSelected: selectedLocal?.id,
                hintText: selectedLocal?.data?.title,
                itemBuilder: (context, item, idSelected) {
                  //custom item UI
                  return Container(
                    color: idSelected? Colors.blue : Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.ac_unit),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.data?.title??"", style: idSelected? textStyleSelected : textStyle,),
                              Text(item.data?.subTitle??"", style: idSelected? subTextStyleSelected : subTextStyle,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                // heightBoxResponse: 50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                    style: BorderStyle.solid,
                    strokeAlign: 1,
                  ),
                ),
                borderFocus: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red, width: 2.0, style: BorderStyle.solid, strokeAlign: 1),
                ),
                onSelect: (item) {
                  setState(() {
                    selectedLocal = item;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 4,),
        Text("local search selected: ${selectedLocal.toString()}"),
        Spacer(),
      ],
    );
  }
}

class ResponseSearch {
  String keySearch;
  int id;
  String title;
  String subTitle;

  ResponseSearch({required this.keySearch, required this.id, required this.title, required this.subTitle});
}

```

## Additional information