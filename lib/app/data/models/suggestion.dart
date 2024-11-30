class Suggestion {
  int? id;
  String? title;
  String? createAt;
  String? userTypeName;
  String? status;

  Suggestion(
      {this.id, this.title, this.createAt, this.userTypeName, this.status});

  Suggestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createAt = json['createAt'];
    userTypeName = json['userTypeName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['createAt'] = this.createAt;
    data['userTypeName'] = this.userTypeName;
    data['status'] = this.status;
    return data;
  }
}
