import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:solutech_sat/bloc/feedback_comments_bloc.dart';
import 'package:solutech_sat/bloc/feedbacks_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/feedback_comment.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/comment_box.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class FeedbackCommentsScreen extends StatelessWidget {
  FeedbackCommentsBloc bloc;

  FeedbackCommentsScreen({Feedback feedback})
      : bloc = FeedbackCommentsBloc(feedback: feedback);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Comments",
                ),
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: FutureBuilder(
                      future:
                          recordsManager.getFeedbackComments(bloc.feedback.id),
                      builder: (BuildContext context, snapshot) {
                        return CircularMaterialSpinner(
                          loading: snapshot.connectionState ==
                              ConnectionState.waiting,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(top: 10.0),
                            child: ListView.builder(
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  FeedbackComment comment =
                                      snapshot.data[index];
                                  return CommentBox(
                                    comment: comment.commentContent,
                                    assignedTo: comment.assignedto,
                                    belongsToCurrentUser:
                                        comment.userId == authManager.user.id,
                                    date: comment.entryTime?.toIso8601String(),
                                    priority: comment.priority,
                                    status: comment.status,
                                    userName: authManager.user.name,
                                  );
                                }),
                          ),
                        );
                        /*switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return
                      default:
                        if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                        else
                          return new Text('Result: ${snapshot.data}');
                    }*/
                      },
                    ),
                  ),
                  Container(
                    color: Color(0xFFefefef),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(5.0).copyWith(left: 10.0),
                          child: TextFormField(
                            controller: bloc.commentContentCtrl,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type your comment here...",
                            ),
                          ),
                        )),
                        InkResponse(
                          onTap: bloc.saveComment,
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            margin: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
