class SuggestionAndReplies {
  int? id;
  String? title;
  String? body;
  String? createAt;
  String? updateAt;
  String? note;
  String? status;
  String? createdApplicationUserId;
  String? createdFullName;
  String? createdUserName;
  String? createdEmail;
  String? createdPhoneNumber;
  String? createdUserTypeName;
  bool? createdIsConnectionAvailable;
  bool? isRead;
  String? readDateTime;
  String? readerApplicationUserId;
  String? readFullName;
  String? readUserName;
  String? readEmail;
  String? readPhoneNumber;
  bool? isFinished;
  String? finisherApplicationUserId;
  String? finishedDateTime;
  String? finishFullName;
  String? finishUserName;
  String? finishEmail;
  String? finishPhoneNumber;
  var deliveryOrderId;
  var transportOrderId;
  List<Replies>? replies;

  SuggestionAndReplies(
      {this.id,
        this.title,
        this.body,
        this.createAt,
        this.updateAt,
        this.note,
        this.status,
        this.createdApplicationUserId,
        this.createdFullName,
        this.createdUserName,
        this.createdEmail,
        this.createdPhoneNumber,
        this.createdUserTypeName,
        this.createdIsConnectionAvailable,
        this.isRead,
        this.readDateTime,
        this.readerApplicationUserId,
        this.readFullName,
        this.readUserName,
        this.readEmail,
        this.readPhoneNumber,
        this.isFinished,
        this.finisherApplicationUserId,
        this.finishedDateTime,
        this.finishFullName,
        this.finishUserName,
        this.finishEmail,
        this.finishPhoneNumber,
        this.deliveryOrderId,
        this.transportOrderId,
        this.replies});

  SuggestionAndReplies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    note = json['note'] ??"";
    status = json['status'];
    createdApplicationUserId = json['createdApplicationUserId'];
    createdFullName = json['createdFullName'];
    createdUserName = json['createdUserName'];
    createdEmail = json['createdEmail'];
    createdPhoneNumber = json['createdPhoneNumber'];
    createdUserTypeName = json['createdUserTypeName'];
    createdIsConnectionAvailable = json['createdIsConnectionAvailable'];
    isRead = json['isRead'];
    readDateTime = json['readDateTime'];
    readerApplicationUserId = json['readerApplicationUserId'];
    readFullName = json['readFullName'];
    readUserName = json['readUserName'];
    readEmail = json['readEmail'];
    readPhoneNumber = json['readPhoneNumber'];
    isFinished = json['isFinished'];
    finisherApplicationUserId = json['finisherApplicationUserId']??"";
    finishedDateTime = json['finishedDateTime']??"";
    finishFullName = json['finishFullName']??"";
    finishUserName = json['finishUserName']??"";
    finishEmail = json['finishEmail']??"";
    finishPhoneNumber = json['finishPhoneNumber']??"";
    deliveryOrderId = json['deliveryOrderId']??"";
    transportOrderId = json['transportOrderId']??"";
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['createAt'] = this.createAt;
    data['updateAt'] = this.updateAt;
    data['note'] = this.note;
    data['status'] = this.status;
    data['createdApplicationUserId'] = this.createdApplicationUserId;
    data['createdFullName'] = this.createdFullName;
    data['createdUserName'] = this.createdUserName;
    data['createdEmail'] = this.createdEmail;
    data['createdPhoneNumber'] = this.createdPhoneNumber;
    data['createdUserTypeName'] = this.createdUserTypeName;
    data['createdIsConnectionAvailable'] = this.createdIsConnectionAvailable;
    data['isRead'] = this.isRead;
    data['readDateTime'] = this.readDateTime;
    data['readerApplicationUserId'] = this.readerApplicationUserId;
    data['readFullName'] = this.readFullName;
    data['readUserName'] = this.readUserName;
    data['readEmail'] = this.readEmail;
    data['readPhoneNumber'] = this.readPhoneNumber;
    data['isFinished'] = this.isFinished;
    data['finisherApplicationUserId'] = this.finisherApplicationUserId;
    data['finishedDateTime'] = this.finishedDateTime;
    data['finishFullName'] = this.finishFullName;
    data['finishUserName'] = this.finishUserName;
    data['finishEmail'] = this.finishEmail;
    data['finishPhoneNumber'] = this.finishPhoneNumber;
    data['deliveryOrderId'] = this.deliveryOrderId;
    data['transportOrderId'] = this.transportOrderId;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Replies {
  int? id;
  String? createAt;
  String? message;
  String? replyUserId;
  String? replyUserName;
  bool? isFromAdmin;

  Replies(
      {this.id,
        this.createAt,
        this.message,
        this.replyUserId,
        this.replyUserName,
        this.isFromAdmin});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createAt = json['createAt'];
    message = json['message'];
    replyUserId = json['replyUserId'];
    replyUserName = json['replyUserName'];
    isFromAdmin = json['isFromAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createAt'] = this.createAt;
    data['message'] = this.message;
    data['replyUserId'] = this.replyUserId;
    data['replyUserName'] = this.replyUserName;
    data['isFromAdmin'] = this.isFromAdmin;
    return data;
  }
}
