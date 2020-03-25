class SumRequestList {
  String imagePath;
  String titleTxt;
  String subTxt;

  SumRequestList({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
  });

  static List<SumRequestList> sumRequestList = [
    SumRequestList(
      imagePath: 'assets/images/complain/maincomplain.png',
      titleTxt: 'ร้องเรียน',
      subTxt: 'ระบุปัญหา/ความเดือดร้อน',
    ),
    SumRequestList(
      imagePath: 'assets/images/complain/mainstatus.jpg',
      titleTxt: 'Request Dashboard',
      subTxt: 'Dashboard จัดการคำร้อง',
    ),
    SumRequestList(
      imagePath: 'assets/images/complain/mainstatus.jpg',
      titleTxt: 'Queue Dashboard',
      subTxt: 'Dashboard จัดการคิว',
    ),
    SumRequestList(
      imagePath: 'assets/images/complain/mainstatus.jpg',
      titleTxt: 'จองคิว',
      subTxt: 'ทดสอบ',
    ),
  ];
}
