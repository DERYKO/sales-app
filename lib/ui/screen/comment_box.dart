import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  String userName;
  String comment;
  String date;
  bool belongsToCurrentUser;
  String assignedTo;
  String status;
  String priority;

  CommentBox(
      {this.userName,
      this.comment,
      this.date,
      this.belongsToCurrentUser,
      this.assignedTo,
      this.status,
      this.priority});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: belongsToCurrentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 5, bottom: 5, left: 8, top: 3),
              margin: EdgeInsets.only(
                  left: belongsToCurrentUser ? 0 : 10,
                  right: belongsToCurrentUser ? 10 : 0),
              width: MediaQuery.of(context).size.width * 0.70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: belongsToCurrentUser
                          ? Radius.circular(0)
                          : Radius.circular(10),
                      topLeft: belongsToCurrentUser
                          ? Radius.circular(10)
                          : Radius.circular(0),
                      bottomLeft: belongsToCurrentUser
                          ? Radius.circular(10)
                          : Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.grey[100],
                  border: Border.all()),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    FittedBox(
                      child: Text(
                        userName,
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        priority ?? "None",
                        style: TextStyle(
                            fontSize: 11,
                            color: (priority == "Low")
                                ? Colors.green
                                : (priority == "High")
                                    ? Colors.red
                                    : Colors.blue),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                Divider(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  alignment: Alignment.topLeft,
                  child: Text(comment),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FittedBox(
                        child: Row(
                      children: <Widget>[
                        Text("status: ", style: TextStyle(fontSize: 9)),
                        Text(status,
                            style: TextStyle(
                              fontSize: 8,
                              color: status == "Pending"
                                  ? Colors.red
                                  : Colors.green,
                            )),
                      ],
                    )),
                    FittedBox(
                        child: Row(
                      children: <Widget>[
                        Text("Assignee: ", style: TextStyle(fontSize: 9)),
                        Text(assignedTo,
                            style: TextStyle(
                              fontSize: 8,
                              color: assignedTo == "None"
                                  ? Colors.red
                                  : Colors.green,
                            )),
                      ],
                    )),
                    FittedBox(
                      child: Text(
                        date,
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                )
              ])),
        ],
      ),
    );
  }
}
