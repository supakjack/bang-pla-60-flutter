import 'dart:convert';

class Queue {
  // final String cda_id;
  // final String cda_text;
  // final String cda_is_active;
  // final String cda_cdt_id;
  // final String cda_is_queue;
  // final String cda_use_form_calendar;

  Queue(
      // {this.cda_id,
      // this.cda_text,
      // this.cda_is_active,
      // this.cda_cdt_id,
      // this.cda_is_queue,
      // this.cda_use_form_calendar}
      );

  factory Queue.fromJson(Map<String, dynamic> json) {
    // return Queue(
    //     cda_id: json['cda_id'] as String,
    //     cda_text: json['cda_text'] as String,
    //     cda_is_active: json['cda_is_active'] as String,
    //     cda_cdt_id: json['cda_cdt_id'] as String,
    //     cda_is_queue: json['cda_is_queue'] as String,
    //     cda_use_form_calendar: json['cda_use_form_calendar'] as String);
  }
}

// A function that converts a response body into a List<Photo>.
List<Queue> parseQueue(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Queue>((json) => Queue.fromJson(json)).toList();
}
