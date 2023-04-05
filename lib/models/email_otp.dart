import 'dart:convert';

EmailOtp emailOtpFromJson(String str) => EmailOtp.fromJson(json.decode(str));

String emailOtpToJson(EmailOtp data) => json.encode(data.toJson());

class EmailOtp {
  EmailOtp({
    required this.error,
    required this.message,
    required this.otp,
  });

  bool error;
  String message;
  String otp;

  factory EmailOtp.fromJson(Map<String, dynamic> json) => EmailOtp(
        error: json["error"],
        message: json["message"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "otp": otp,
      };
}
