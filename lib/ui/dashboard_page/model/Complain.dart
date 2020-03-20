import 'dart:convert';

class Complain {
  final String cda_id;
  final String cda_text;
  final String cdt_text;
  final String cds_text;
  final String cdoc_detail;
  final String cdt_id;
  final String cu_ps_id;
  final String cdoc_inform_date;

  Complain(
      {this.cda_id,
      this.cda_text,
      this.cdt_text,
      this.cds_text,
      this.cdoc_detail,
      this.cdt_id,
      this.cu_ps_id,
      this.cdoc_inform_date});

  factory Complain.fromJson(Map<String, dynamic> json) {
    return Complain(
        cda_id: json['cda_id'] as String,
        cda_text: json['cda_text'] as String,
        cdt_text: json['cdt_text'] as String,
        cds_text: json['cds_text'] as String,
        cdoc_detail: json['cdoc_detail'] as String,
        cdt_id: json['cdt_id'] as String,
        cu_ps_id: json['cu_ps_id'] as String,
        cdoc_inform_date: json['cdoc_inform_date'] as String);
  }
}

// A function that converts a response body into a List<Photo>.
List<Complain> parseComplain(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Complain>((json) => Complain.fromJson(json)).toList();
}
