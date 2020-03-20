
import 'dart:convert';

import 'package:bangplasmartapp/ui/Queue/bookingList.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'model/infobookingqueue.dart';

class Booking extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return BookingState();
  }
  
}
class BookingState extends State<Booking> {
  final format = DateFormat("dd/MM/yyyy");
  var _title = "จองคิว";
  final _formKey = GlobalKey<FormState>();
  // String titleName;
  DateTime date;
  // DateTime _date = new DateTime.now();
  // TimeOfDay _time = new TimeOfDay.now();
  String _formattedDate;
  // String _formattedTime = "กรุณาระบุเวลา";

  // var selectedType;
  List<InfoMainType> _infoMainType= List<InfoMainType>();
  List<DropdownMenuItem<InfoMainType>> _dropdownMainTypeItem;
  InfoMainType _selectedMainType;
  var _svt_key_code;
  var _svt_id;
  Future<List<InfoMainType>> fetchNotesMainType() async {
    var url = 'http://10.80.39.17/service-bangpla/index.php/Queueonline/get_all_data_type';
    var response = await http.get(url);
    var infoMainTypeList = List<InfoMainType>();
    
    if (response.statusCode == 200) {
    // print(response.body);
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        infoMainTypeList.add(InfoMainType.fromJson(noteJson));
      }
    }
    return infoMainTypeList;
  }

  List<InfoSubType> _infoSubType = List<InfoSubType>();
  List<DropdownMenuItem<InfoSubType>> _dropdownSubTypeItem;
  InfoSubType _selectedSubType;
  var _svst_key_code;
  var _svst_id;
  Future<List<InfoSubType>> fetchNotesSubType() async {
    var url = 'http://10.80.39.17/service-bangpla/index.php/Queueonline/get_all_data_sub_type';
    var response = await http.get(url);
    var infoSubTypeList = List<InfoSubType>();
    
    if (response.statusCode == 200) {
    // print(response.body);
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        infoSubTypeList.add(InfoSubType.fromJson(noteJson));
      }
    }
    return infoSubTypeList;
  }

  List<InfoTime> _infoTime= List<InfoTime>();
  List<DropdownMenuItem<InfoTime>> _dropdownTimeItem;
  InfoTime _selectedTime;
  var _ts_id;
  Future<List<InfoTime>> fetchNotesTime() async {
    var url = 'http://10.80.39.17/service-bangpla/index.php/Queueonline/get_all_data_time_slot';
    var response = await http.get(url);
    var infoTimeList = List<InfoTime>();
    
    if (response.statusCode == 200) {
    // print(response.body);
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        infoTimeList.add(InfoTime.fromJson(noteJson));
      }
    }
    return infoTimeList;
  }
  
  @override
  void initState() {
    fetchNotesMainType().then((value) {
      setState(() {
        _infoMainType.addAll(value);
      });
      _dropdownMainTypeItem = buildDropdownMenuItems(_infoMainType);
      // _selectedMainType = _dropdownMainTypeItem[0].value;
    });

    fetchNotesSubType().then((value) {
      setState(() {
        _infoSubType.addAll(value);
      });
      _dropdownSubTypeItem = buildDropdownSybTypeItems(_infoSubType);
      // _selectedSubType = _dropdownSubTypeItem[0].value;
    });

    fetchNotesTime().then((value) {
      setState(() {
        _infoTime.addAll(value);
      });
      _dropdownTimeItem = buildDropdownTimeItems(_infoTime);
      // _selectedTime = _dropdownTimeItem[0].value;
    });
    super.initState();
    // _controller = new TextEditingController(_formattedDate);
  }

  List<DropdownMenuItem<InfoMainType>> buildDropdownMenuItems(List infoMainType) {
    List<DropdownMenuItem<InfoMainType>> items = List();
    for (InfoMainType infoMainType in infoMainType) {
      items.add(
        DropdownMenuItem(
          value: infoMainType,
          child: Text(infoMainType.svt_name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<InfoSubType>> buildDropdownSybTypeItems(List infoSubType) {
    List<DropdownMenuItem<InfoSubType>> items = List();
    for (InfoSubType infoSubType in infoSubType) {
      items.add(
        DropdownMenuItem(
          value: infoSubType,
          child: Text(infoSubType.svst_name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<InfoTime>> buildDropdownTimeItems(List infoTime) {
    List<DropdownMenuItem<InfoTime>> items = List();
    for (InfoTime infoTime in infoTime) {
      items.add(
        DropdownMenuItem(
          value: infoTime,
          child: Text(infoTime.ts_time),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(InfoMainType selectedMainType) {
  setState(() {
    _selectedMainType = selectedMainType;
    _svt_key_code = selectedMainType.svt_key_code;
    _svt_id = selectedMainType.svt_id;
  });
  }

  onChangeDropdownSubTypeItem(InfoSubType selectedSubType) {
  setState(() {
    _selectedSubType = selectedSubType;
    _svst_key_code = selectedSubType.svst_key_code;
    _svst_id = selectedSubType.svst_id;
  });
  }

  onChangeDropdownTimeItem(InfoTime selectedTime) {
  setState(() {
    _selectedTime = selectedTime;
    _ts_id = selectedTime.ts_id;
  });
  }

  void postData(){
    var url="http://10.80.39.17/service-bangpla/index.php/Queueonline/insert_queue_online";

    _formattedDate = new DateFormat("dd/MM/yyyy").format(date);
    http.post(url, body: {
      "svt_key_code": _selectedMainType.svt_key_code,
      "svt_id": _selectedMainType.svt_id,
      "svst_key_code": _selectedSubType.svst_key_code,
      "svst_id": _selectedSubType.svst_id,
      "qol_date": _formattedDate,
      "ts_id": _selectedTime.ts_id,
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            InkWell(
              child: SizedBox(
                width: 80,
                child: saveButton(),
              ),
            ),
          ],
          centerTitle: true ,
          title: Text(_title),
        ),
        body: Form(key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(30.0),
            children: <Widget>[
              lableTextServiceType(),
              dropdownServiceType(),
              lableTextServiceSubType(),
              dropdownServiceSubType(),
              lableTextDate(),
              inputDate(),
              lableTextTime(),
              dropdownTime(),
            ]
          ),
        ),
        );
  }

  Widget lableTextServiceType(){
    return Text(
      'ชื่อเรื่องบริการหลัก',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 20,
        height: 1.0,
        color: Colors.blue[900]
      ),
    );
  }

   Widget dropdownServiceType(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 20.0, left: 16.0, right: 16.0), child: 
        Row(children: <Widget>[
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  DropdownButtonFormField(
                  hint: Text(
                    'กรุณาเลือกชื่อเรื่องหลัก',
                  ),
                  value: _selectedMainType,
                  onChanged:onChangeDropdownItem,
                  validator: (value) => value == null ? 'กรุณาระบุข้อมูลให้ครบถ้วน' : null,
                  items:_dropdownMainTypeItem,
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
   }

   Widget lableTextServiceSubType(){
    return Text(
      'ชื่อเรื่องบริการรอง',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 20,
        height: 2.0,
        color: Colors.blue[900]
      ),
    );
  }

  Widget dropdownServiceSubType(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 20.0, left: 16.0, right: 16.0), child: 
        Row(children: <Widget>[
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  DropdownButtonFormField(
                  hint: Text(
                    'กรุณาเลือกชื่อเรื่องรอง',
                  ),
                  value: _selectedSubType,
                  onChanged:onChangeDropdownSubTypeItem,
                  validator: (value) => value == null ? 'กรุณาระบุข้อมูลให้ครบถ้วน' : null,
                  items:_dropdownSubTypeItem,
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget lableTextDate(){
    return Text(
      'วันที่เข้ารับบริการ',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 20,
        height: 2.0,
        color: Colors.blue[900]
      ),
    );
  }

  Widget inputDate(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:Padding( padding: const EdgeInsets.only(top: 5.0, bottom: 20.0, left: 16.0, right: 16.0), child: 
        Row(children: <Widget>[
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  DateTimeField(
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                    );
                  },
                  onChanged: (dt) => setState(() => date = dt),
                  validator: (date) => date == null ? 'กรุณาระบุข้อมูลให้ครบถ้วน' : null,
                  decoration: InputDecoration(
                    labelText: 'กรุณาเลือกวันที่เข้ารับบริการ', 
                    hasFloatingPlaceholder: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget lableTextTime(){
    return Text(
      'เวลาเข้ารับบริการ',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 20,
        height: 2,
        color: Colors.blue[900]
      ),
    );
  }

  Widget dropdownTime(){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 20.0, left: 16.0, right: 16.0), child: 
        Row(children: <Widget>[
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  DropdownButtonFormField(
                  hint: Text(
                    'กรุณาเลือกเวลาเข้ารับบริการ',
                  ),
                  value: _selectedTime,
                  onChanged:onChangeDropdownTimeItem,
                  validator: (value) => value == null ? 'กรุณาระบุข้อมูลให้ครบถ้วน' : null,
                  items:_dropdownTimeItem,
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget saveButton(){
    return IconButton(
      icon: Text('บันทึก'),
      onPressed: (){
        if(_svt_key_code == null || _svt_id == null || _svst_key_code == null || _svst_id == null || date == null || _ts_id == null){
          print("error");
        }else{
          _showDialogError();
        }
        if(_formKey.currentState.validate()){
          print('บริการหลักคีย์ = $_svt_key_code');
          print('บริการหลักไอดี = $_svt_id');
          print('บริการรองคีย์ = $_svst_key_code');
          print('บริการรองไอดี = $_svst_id');
          print('เวลาเข้ารับบริการ = $_ts_id');
          print('วันที่เข้ารับบริการ = $date');
        }
      },
    );
  }

  void _showDialogError() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "บันทึก",
            style: TextStyle(
              color: Colors.green[800],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: new Text(
            "ต้องการบันทึกข้อมูล",
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 18,
            ),  
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
             new FlatButton(
              child: new Text(
                "ยกเลิก",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "ตกลง",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                postData();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => BookingList()
                ));
              },
            ),
          ],
        );
      },
    );
  }

  // Future<Null> _selectDate(BuildContext context) async{
  //   final DateTime picked = await showDatePicker(
  //     context: context, 
  //     initialDate: _date, 
  //     firstDate: new DateTime(2020), 
  //     lastDate: new DateTime(2100)
  //   );
  //   if(picked != null && picked != _date){
  //     print('Date selected : ${_date.toString()}');
  //     _date = picked;
  //     setState(() {
  //       _formattedDate = new DateFormat("dd/MM/yyyy").format(_date);
  //     });
  //   }
    
  // }

  // Future<Null> _selectTime(BuildContext context) async{
  //   final TimeOfDay picked = await showTimePicker(
  //     context: context, 
  //     initialTime: TimeOfDay(hour: _time.hour, minute: _time.minute),
  //   );
  //   final now = new DateTime.now();
  //   final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
  //   final format = DateFormat.jm().format(dt);  //"6:00 AM"
  //   if(format != null){
  //     // print('Time selected : ${format.toString()}');
      
  //     setState(() {
  //       _formattedTime = format;
  //     });
  //   }
  // }

//   String formatTimeOfDay(TimeOfDay _time) {
//     final now = new DateTime.now();
//     final dt = DateTime(now.year, now.month, now.day, _time.hour, _time.minute);
//     final format = DateFormat.jm();  //"6:00 AM"
//     return format.format(dt);
// }
}
