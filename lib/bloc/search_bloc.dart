import 'package:flutter/material.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';

class SearchBloc extends Bloc {
  TextEditingController searchController = TextEditingController();
  Function builder;
  String title;
  Function onFilter;
  List filteredItems = [];
  List items = [];

  void onSearch() {
    print("Items are: ${items.length}");
    var _searchText = searchController.text.toLowerCase();
    filteredItems.clear();
    // item["region_name"].toString().toLowerCase().contains(_searchText))
    filteredItems = items.where((item) {
      print(item);
      return onFilter(item,
          _searchText); //item["region_name"].toString().toLowerCase().contains(_searchText);
    }).toList();
    notifyChanges();
  }

  SearchBloc({
    this.items = const [],
    @required this.title = "",
    @required this.builder,
    @required this.onFilter,
  });

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearch);
    onSearch();
  }
}
