class InfoQueueUser {
  final String qol_mem_id;
  final String qol_date;
  final String qol_ref;
  final String qus_name;
  final String ts_time_start;
  final String ts_time_stop;
  final String svt_name;
  final String svst_name;

  InfoQueueUser({this.qol_mem_id, this.qol_date, this.qol_ref, this.qus_name, this.ts_time_start, this.ts_time_stop, this.svt_name, this.svst_name});

  factory InfoQueueUser.fromJson(Map<String, dynamic> json) {
    return InfoQueueUser(
      qol_mem_id: json['qol_mem_id'] as String,
      qol_date: json['qol_date'] as String,
      qol_ref: json['qol_ref'] as String,
      qus_name: json['qus_name'] as String,
      ts_time_start: json['ts_time_start'] as String,
      ts_time_stop: json['ts_time_stop'] as String,
      svt_name: json['svt_name'] as String,
      svst_name: json['svst_name'] as String,
    );
  }
}

