class Userinfo {
  int? userId;
  String? deviceToken;
  String? socialmediaUid;
  String? fcmId;
  String? apiToken;
  String? userName;
  String? phone;
  String? emailid;
  String? password;
  String? timestamp;
  String? phoneCode;
  String? profilePic;
  int? status;
  int? phoneVerified;
  int? emailVerified;
  String? address;
  String? nationality;
  String? docType;

  Userinfo(
      {this.userId,
      this.apiToken,
      this.fcmId,
      this.deviceToken,
      this.socialmediaUid,
      this.userName,
      this.phone,
      this.phoneCode,
      this.emailid,
      this.password,
      this.profilePic,
      this.status,
      this.phoneVerified,
      this.timestamp,
      this.address,
      this.nationality,
      this.docType,
      this.emailVerified});

  Userinfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    apiToken = json['api_token'];
    fcmId = json['fcm_id'];
    deviceToken = json['device_token'] ?? "";
    socialmediaUid = json['socialmedia_uid'] ?? "";
    userName = json['user_name'] ?? json['name'];
    phone = json['phone'];
    phoneCode = json['phone_code'] ?? "+91";
    emailid = json['emailid'] ?? json['email'];
    password = json['password'] ?? "";
    profilePic = json['profile_pic'] ?? "";
    status = json['status'] ?? 1;
    phoneVerified = json['phone_verified'] ?? 0;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['api_token'] = this.apiToken;
    data['fcm_id'] = this.fcmId;
    data['device_token'] = this.deviceToken;
    data['socialmedia_uid'] = this.socialmediaUid;
    data['user_name'] = this.userName;
    data['phone'] = this.phone;
    data['phone_code'] = this.phoneCode;
    data['emailid'] = this.emailid;
    data['password'] = this.password;
    data['profile_pic'] = this.profilePic;
    data['status'] = this.status;
    data['phone_verified'] = this.phoneVerified;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
