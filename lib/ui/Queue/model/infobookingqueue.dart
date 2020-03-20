class InfoMainType {
  final String svt_name;
  final String svt_key_code; 
  final String svt_id; 

  InfoMainType({this.svt_name, this.svt_key_code, this.svt_id});

  factory InfoMainType.fromJson(Map<String, dynamic> json) {
    return InfoMainType(
      svt_name: json['svt_name'] as String,
      svt_key_code: json['svt_key_code'] as String,
      svt_id: json['svt_id'] as String,
    );
  }
}

class InfoSubType {
  final String svst_name;
  final String svst_key_code; 
  final String svst_id; 

  InfoSubType({this.svst_name, this.svst_key_code, this.svst_id});

  factory InfoSubType.fromJson(Map<String, dynamic> json) {
    return InfoSubType(
      svst_name: json['svst_name'] as String,
      svst_key_code: json['svst_key_code'] as String,
      svst_id: json['svst_id'] as String,
    );
  }
}

class InfoTime {
  final String ts_id;
  final String ts_time; 

  InfoTime({this.ts_id, this.ts_time});

  factory InfoTime.fromJson(Map<String, dynamic> json) {
    return InfoTime(
      ts_id: json['ts_id'] as String,
      ts_time: json['ts_time'] as String,
    );
  }
}