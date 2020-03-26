import 'dart:io';
class ComplainRequestList {
  String imagePath;
  String titleTxt;
  String subTxt;

  ComplainRequestList({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
  });

  static List<ComplainRequestList> complainRequestList = [
    ComplainRequestList(
      imagePath: 'assets/images/complain/maincomplain.png',
      titleTxt: 'ร้องเรียน / ร้องทุกข์',
      subTxt: 'ระบุปัญหา/ความเดือดร้อน',
    ),
    ComplainRequestList(
      imagePath: 'assets/images/complain/mainstatus.jpg',
      titleTxt: 'ตรวจสอบสถานะ',
      subTxt: 'ติดตามสถานะคำร้อง',
    ),
  ];
}

class CategoryRequestList {
  String title;
  String subtitle;
  String imagePath;
  int cda_cdt_id;

  CategoryRequestList({
    this.title = '',
    this.imagePath = '',
    this.subtitle = '',
    this.cda_cdt_id = 0,
  });

  static List<CategoryRequestList> categoryRequestList = [
    CategoryRequestList(
      imagePath: 'assets/images/complain/dispute.jpg',
      title: 'ข้อพิพาทระหว่างบุคคล',
      subtitle: 'แบบคำร้องข้อพิพาทระหว่างบุคคล',
      cda_cdt_id: 23,
    ),
    CategoryRequestList(
      imagePath: 'assets/images/complain/government.jpg',
      title: 'ร้องเรียนโครงการรัฐ',
      subtitle: 'แบบคำร้องโครงการรัฐ',
      cda_cdt_id: 24,
    ),
    CategoryRequestList(
      imagePath: 'assets/images/complain/flood.jpg',
      title: 'อุทกภัย',
      subtitle: 'แบบคำร้องอุทกภัย',
      cda_cdt_id: 28,
    ),
    CategoryRequestList(
      imagePath: 'assets/images/complain/fire.jpg',
      title: 'อัคคีภัย',
      subtitle: 'แบบคำร้องอัคคีภัย',
      cda_cdt_id: 29,
    ),
    CategoryRequestList(
      imagePath: 'assets/images/complain/strom.jpg',
      title: 'วาตภัย',
      subtitle: 'แบบคำร้องวาตภัย',
      cda_cdt_id: 32,
    ),
    CategoryRequestList(
      imagePath: 'assets/images/complain/conflict.jpg',
      title: 'ทะเลาะวิวาท',
      subtitle: 'แบบคำร้องทะเลาะวิวาท',
      cda_cdt_id: 37,
    ),
    CategoryRequestList(
      imagePath: 'assets/images/complain/minister.jpg',
      title: 'ร้องเรียนนายก',
      subtitle: 'แบบคำร้องเรียนนายก',
      cda_cdt_id: 38,
    ),
   // CategoryRequestList(
     // imagePath: 'assets/images/complain/conflict.jpg',
     // title: 'การวิวาท',
     // subtitle: 'แบบคำร้องเรียนการวิวาท',
     // cda_cdt_id: 39,
   // ),
  ];
}

class CategoryRequest {
  final String cdt_id;
  final String cdt_text;
  final String cdt_sequence;
  final String cdt_is_active;

  CategoryRequest({this.cdt_id, this.cdt_text, this.cdt_sequence, this.cdt_is_active});

  factory CategoryRequest.fromJson(Map<String, dynamic> json) {
    return CategoryRequest(
      cdt_id: json['cdt_id'] as String,
      cdt_text: json['cdt_text'] as String,
      cdt_sequence: json['cdt_sequence'] as String,
      cdt_is_active: json['cdt_is_active'] as String,
    );
  }
}

class StatusRequestList {
  String title;
  String status;
  String imagePath;
  DateTime date;

  StatusRequestList({
    this.title = '',
    this.imagePath = '',
    this.status = '',
  });

  static List<StatusRequestList> statusRequestList = [
    StatusRequestList(
      imagePath: 'assets/images/complain/dispute.jpg',
      title: 'ข้อพิพาทระหว่างบุคคล',
      status: 'กำลังดำเนินการ',
    ),
    StatusRequestList(
      imagePath: 'assets/images/complain/government.jpg',
      title: 'ร้องเรียนโครงการรัฐ',
      status: 'กำลังดำเนินการ',
    ),
  ];
}

class StatusRequest {
  final String cda_id;
  final String cda_text;
  final String cdt_text;
  final String cds_text;
  final String cmdu_user_cu_id;
  final String cdoc_detail;
  final String cdt_id;
  final String cdoc_inform_date;

  StatusRequest({this.cda_id, this.cda_text, this.cdt_text, this.cds_text, this.cmdu_user_cu_id, this.cdoc_detail, this.cdt_id, this.cdoc_inform_date});

  factory StatusRequest.fromJson(Map<String, dynamic> json) {
    return StatusRequest(
      cda_id: json['cda_id'] as String,
      cda_text: json['cda_text'] as String,
      cdt_text: json['cdt_text'] as String,
      cds_text: json['cds_text'] as String,
      cmdu_user_cu_id: json['cmdu_user_cu_id'] as String,
      cdoc_detail: json['cdoc_detail'] as String,
      cdt_id: json['cdt_id'] as String,
      cdoc_inform_date: json['cdoc_inform_date'] as String,
    );
  }
}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}