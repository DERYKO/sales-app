import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  Function onSearch;
  bool search;
  TextEditingController searchTextController;
  AppBar mainAppBar;
  Function onExitSearch;
  Size size;

  SearchAppBar({
    this.search = false,
    this.onSearch,
    this.searchTextController,
    this.mainAppBar,
    this.onExitSearch,
  }) : assert(search != null &&
            onSearch != null &&
            mainAppBar != null &&
            onExitSearch != null);
  @override
  Widget build(BuildContext context) {
    if (!searchTextController.hasListeners) {
      searchTextController.addListener(() {
        onSearch(searchTextController.text);
      });
    }

    return (search)
        ? AppBar(
            backgroundColor: Colors.white,
            title: TextFormField(
              autofocus: true,
              controller: searchTextController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search...",
                  hintStyle:
                      TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500)),
            ),
            leading: InkResponse(
              onTap: () {
                searchTextController.clear();
                onExitSearch();
              },
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              ),
            ),
            actions: <Widget>[
              (searchTextController.text != "")
                  ? GestureDetector(
                      onTap: () {
                        searchTextController.clear();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : new Container()
            ],
          )
        : mainAppBar;
  }

  // TODO: implement preferredSize
  @override
  Size get preferredSize => Size(
        double.infinity,
        (search)
            ? kToolbarHeight
            : mainAppBar.preferredSize.height ?? kToolbarHeight,
      );
}

abstract class Searchable {
  bool search;
  Function onSearch;
  TextEditingController searchTextController;
  Function onExitSearch;
}
