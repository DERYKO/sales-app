class FeedbackComment {
  int userId;
  String name;
  String assignedto;
  DateTime entryTime;
  String status;
  String priority;
  String commentContent;

  FeedbackComment({
    this.userId,
    this.name,
    this.assignedto,
    this.entryTime,
    this.status,
    this.priority,
    this.commentContent,
  });

  factory FeedbackComment.fromMap(Map<String, dynamic> json) => FeedbackComment(
        userId: json["user_id"],
        name: json["name"],
        assignedto: json["assignedto"],
        entryTime: DateTime.parse(json["entry_time"]),
        status: json["status"],
        priority: json["priority"],
        commentContent: json["comment_content"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "name": name,
        "assignedto": assignedto,
        "entry_time": entryTime?.toIso8601String(),
        "status": status,
        "priority": priority,
        "comment_content": commentContent,
      };
}
