import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class FeedbackCommentsBloc extends Bloc {
  TextEditingController commentContentCtrl = TextEditingController();
  Feedback feedback;
  FeedbackCommentsBloc({
    this.feedback,
  });

  void saveComment() async {
    if (commentContentCtrl.text.trim() == "") {
      alert("Empty comment", "Please enter a comment");
      return;
    }
    progressDialog.message = "Saving comment";
    progressDialog.show();
    api.addComment({
      "id": feedback.id,
      "comment_content": commentContentCtrl.text,
      "entry_time": DateTime.now().toIso8601String(),
      "userid": authManager.user.id,
      "priority_level": feedback.priorityLevel,
      "status": feedback.status,
      "assigned_to": feedback.assignedTo
    }).then((response) {
      commentContentCtrl.clear();
      notifyChanges();
      progressDialog.hide();
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
