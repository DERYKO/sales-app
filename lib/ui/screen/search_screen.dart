import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/search_bloc.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';

class SearchScreen extends StatelessWidget {
  SearchBloc bloc;
  SearchScreen({
    String title,
    Function builder,
    Function onFilter,
    List items,
  }) {
    bloc = SearchBloc(
      title: title,
      builder: builder,
      onFilter: onFilter,
      items: items,
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${bloc.title}",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: bloc.pop,
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: StreamBuilder(
            stream: bloc.stream,
            builder: (context, snapshot) {
              return Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                          ),
                          Container(
                            width: 5.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: bloc.searchController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: bloc.filteredItems.length,
                        itemBuilder: (context, index) {
                          var item = bloc.filteredItems[index];
                          return GestureDetector(
                            child: bloc.builder(item, index),
                            onTap: () {
                              bloc.pop(item);
                            },
                          );
                        },
                      ),
                    ),
                    Footer()
                  ],
                ),
              );
            }),
      ),
    );
  }
}
