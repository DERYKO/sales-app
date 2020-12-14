import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/refresh_bloc.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/refresh_loader.dart';

class RefreshScreen extends StatelessWidget {
  final bloc = RefreshBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        body: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: RefreshLoader(bloc: bloc),
                  ),
                  Footer(),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
            );
          },
        ),
      ),
    );
  }
}
