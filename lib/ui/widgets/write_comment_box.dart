import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WriteCommentBox extends StatelessWidget {
  int feedbackId;
  String category;
  String status;
  String priority;
  String assignee;
  bool isSendingComment = false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Function sendMessage;
  Stream<dynamic> stream;
  var admins = [];
  List<String> feedbackCategories = [];
  List<String> _status = ['Pending', 'Resolved'];
  List<String> _priorities = ['Low', 'Normal', 'Important', 'Critical'];
  TextEditingController commentController = TextEditingController();

  WriteCommentBox(
      {this.priority,
      this.category,
      this.status,
      this.assignee,
      this.feedbackId,
      this.stream,
      this.admins,
      this.isSendingComment,
      this.sendMessage,
      this.feedbackCategories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: 5),
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextFormField(
                controller: commentController,
                decoration: InputDecoration(
                    hintText: "Type here...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    contentPadding: EdgeInsets.all(15),
                    fillColor: Colors.grey),
              ),
            ),
            Expanded(
                child: GestureDetector(
              child: Container(
                padding: EdgeInsets.all(5),
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Alert(
                        context: context,
                        title: "Feedback message",
                        content: FormBuilder(
                          key: _fbKey,
                          child: Column(children: <Widget>[
                            FormBuilderTextField(
                              decoration: InputDecoration(
                                hintText: 'Comment',
                              ),
                              attribute: 'comment',
                              validators: [FormBuilderValidators.required()],
                              initialValue: commentController.text,
                            ),
                            FormBuilderDropdown(
                              attribute: "category",
                              hint: Text('Select category'),
                              initialValue: category,
                              validators: [FormBuilderValidators.required()],
                              items: feedbackCategories
                                  .map((category) => DropdownMenuItem(
                                      value: category,
                                      child: Text("$category")))
                                  .toList(),
                            ),
                            FormBuilderDropdown(
                              attribute: "priority",
                              hint: Text('Select priority'),
                              initialValue:
                                  priority.isNotEmpty ? priority : "None",
                              validators: [FormBuilderValidators.required()],
                              items: _priorities
                                  .map((priority) => DropdownMenuItem(
                                      value: priority,
                                      child: Text("$priority")))
                                  .toList(),
                            ),
                            FormBuilderDropdown(
                              attribute: "status",
                              initialValue: status,
                              hint: Text('Select status'),
                              validators: [FormBuilderValidators.required()],
                              items: _status
                                  .map((status) => DropdownMenuItem(
                                      value: status, child: Text("$status")))
                                  .toList(),
                            ),
                            FormBuilderDropdown(
                              attribute: "assignee",
                              hint: Text('Assigned to'),
                              initialValue: assignee,
                              validators: [FormBuilderValidators.required()],
                              items: admins
                                  .map((assignee) => DropdownMenuItem(
                                      value: assignee['name'],
                                      child: Text("${assignee['name']}")))
                                  .toList(),
                            ),
                          ]),
                        ),
                        buttons: [
                          DialogButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "CANCEL",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            color: Theme.of(context).accentColor,
                          ),
                          DialogButton(
                            onPressed: () {
                              if (_fbKey.currentState.validate()) {
                                _fbKey.currentState.save();
                                Map<String, dynamic> data =
                                    _fbKey.currentState.value;
                                sendMessage(data, feedbackId);
                              }
                            },
                            child: StreamBuilder<dynamic>(
                                stream: stream,
                                builder: (context, snapshot) {
                                  print("Sending $isSendingComment");
                                  return Text(
                                    isSendingComment ? "SENDING..." : "SEND",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  );
                                }),
                            color: Theme.of(context).primaryColor,
                          ),
                        ]).show();
                  },
                ),
              ),
            ))
          ],
        )
      ],
    );
  }
}
