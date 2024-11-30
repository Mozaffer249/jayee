// To parse this JSON data, do
//
//     final appInfo = appInfoFromMap(jsonString);

import 'dart:convert';

AppInfo appInfoFromMap(String str) => AppInfo.fromMap(json.decode(str));

String appInfoToMap(AppInfo data) => json.encode(data.toMap());

class AppInfo {
  AppInfo({
    this.terms,
    this.policy,
    this.policyAr,
    this.termsAr,
    this.aboutAr,
    this.about,
    this.lastAppVersion,
  });

  final String? terms;
  final String? policy;
  final String? policyAr;
  final String? termsAr;
  final String? aboutAr;
  final String? about;
  final int? lastAppVersion;


  factory AppInfo.fromMap(Map<String, dynamic> json) => AppInfo(
        terms: json["terms"] == null || json["terms"] is bool
            ? null
            : json["terms"],
        policy: json["policy"] == null || json["policy"] is bool
            ? null
            : json["policy"],
        policyAr: json["policy_ar"] == null || json["policy_ar"] is bool
            ? null
            : json["policy_ar"],
        termsAr: json["terms_ar"] == null || json["terms_ar"] is bool
            ? null
            : json["terms_ar"],
        aboutAr: json["about_ar"] == null || json["about_ar"] is bool
            ? null
            : json["about_ar"],
        about: json["about"] == null || json["about"] is bool
            ? null
            : json["about"],
       lastAppVersion: json["last_app_version"] == null || json["last_app_version"] is bool
            ? null
            : json["last_app_version"],
      );

  Map<String, dynamic> toMap() => {
        "terms": terms == null ? null : terms,
        "policy": policy == null ? null : policy,
        "policy_ar": policyAr == null ? null : policyAr,
        "terms_ar": termsAr == null ? null : termsAr,
        "about_ar": aboutAr == null ? null : aboutAr,
        "about": about == null ? null : about,
      };
}
