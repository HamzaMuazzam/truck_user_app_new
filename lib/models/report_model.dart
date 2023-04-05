class ReportModel {
  int? bookingId;
  int? ticketId;
  String? title;
  String? description;
  List<String>? images = [];
  String? ticketStatus;
  List<Replies?>? replies = [];

  ReportModel(
      {this.bookingId,
      this.ticketId,
      this.title,
      this.description,
      this.images,
      this.ticketStatus,
      this.replies});

  ReportModel.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    ticketId = json['ticket_id'];
    title = json['title'];
    description = json['description'];
    if (json['images'] != null) {
      json['images'].forEach((v) {
        images!.add(v);
      });
    }
    ticketStatus = json['ticket_status'];
    if (json['replies'] != null) {
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
  }
}

class Replies {
  int? userId;
  int? messageId;
  String? userName;
  String? reply;
  String? timestamp;

  Replies(
      {this.userId, this.messageId, this.userName, this.reply, this.timestamp});

  Replies.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    messageId = json['message_id'];
    userName = json['user_name'];
    reply = json['reply'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['message_id'] = this.messageId;
    data['user_name'] = this.userName;
    data['reply'] = this.reply;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
