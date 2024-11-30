

class AppUser {
  int? id;
  String? fullname;
  String? email;
  String? imagePath;
  String? phoneNumber;
  String? birthDate;
  int? gender;
  String? favoriteLanguage;
  String? frontEndDevice;

  AppUser(
      {this.id,
        this.fullname,
        this.email,
        this.imagePath,
        this.phoneNumber,
        this.birthDate,
        this.gender,
        this.favoriteLanguage,
        this.frontEndDevice});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    imagePath = json['imagePath'];
    phoneNumber = json['phoneNumber'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    favoriteLanguage = json['favoriteLanguage'];
    frontEndDevice = json['frontEndDevice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['imagePath'] = this.imagePath;
    data['phoneNumber'] = this.phoneNumber;
    data['birthDate'] = this.birthDate;
    data['gender'] = this.gender;
    data['favoriteLanguage'] = this.favoriteLanguage;
    data['frontEndDevice'] = this.frontEndDevice;
    return data;
  }
}

