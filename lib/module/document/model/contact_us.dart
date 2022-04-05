import 'dart:convert';
import 'dart:developer';

class ContactUs {
  const ContactUs({
    this.companyName,
    this.email,
    this.phone,
    this.address,
    this.state,
    this.country,
    this.website,
    this.twitter,
    this.facebook,
    this.linkedin,
    this.youtube,
    this.instagram,
  });

  final String companyName;
  final String email;
  final String phone;
  final String address;
  final String state;
  final String country;
  final String website;
  final String twitter;
  final String facebook;
  final String linkedin;
  final String youtube;
  final String instagram;

  ContactUs copyWith({
    String companyName,
    String email,
    String phone,
    String address,
    String state,
    String country,
    String website,
    String twitter,
    String facebook,
    String linkedin,
    String youtube,
    String instagram,
  }) {
    try {
      return ContactUs(
        companyName: companyName ?? this.companyName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        state: state ?? this.state,
        country: country ?? this.country,
        website: website ?? this.website,
        twitter: twitter ?? this.twitter,
        facebook: facebook ?? this.facebook,
        linkedin: linkedin ?? this.linkedin,
        youtube: youtube ?? this.youtube,
        instagram: instagram ?? this.instagram,
      );
    } catch (e) {
      log('Exception in ContactUs.copyWith : $e');
      return this;
    }
  }

  factory ContactUs.fromJson(String str) {
    try {
      if (str == null || str.isEmpty) return const ContactUs();

      return ContactUs.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in ContactUs.fromJson : $e');
      return const ContactUs();
    }
  }

  String toJson() => json.encode(toMap());

  factory ContactUs.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const ContactUs();

      return ContactUs(
        companyName: json['company_name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        state: json['state'] as String,
        country: json['country'] as String,
        website: json['website'] as String,
        twitter: json['twitter'] as String,
        facebook: json['facebook'] as String,
        linkedin: json['linkedin'] as String,
        youtube: json['youtube'] as String,
        instagram: json['instagram'] as String,
      );
    } catch (e) {
      log('Exception in ContactUs.fromMap : $e');
      return const ContactUs();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String ,dynamic>{
        'company_name': companyName,
        'email': email,
        'phone': phone,
        'address': address,
        'state': state,
        'country': country,
        'website': website,
        'twitter': twitter,
        'facebook': facebook,
        'linkedin': linkedin,
        'youtube': youtube,
        'instagram': instagram,
      };
    } catch (e) {
      log('Exception in ContactUs.toMap : $e');
      return <String ,dynamic>{};
    }
  }
}
