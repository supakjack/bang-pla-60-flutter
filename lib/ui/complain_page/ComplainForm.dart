import 'dart:convert';
import 'dart:io';

import 'package:bangplasmartapp/ui/BangplaAppTheme.dart';
import 'package:bangplasmartapp/ui/complain_page/ComplainPage.dart';
import 'package:bangplasmartapp/ui/complain_page/model/ComplainRequestList.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:multi_image_picker/multi_image_picker.dart' ;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as imgpath;
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;
import 'package:image/image.dart' as Img;
import 'package:async/async.dart';
import 'package:intl/date_symbol_data_local.dart';

class ComplainFormInput extends StatefulWidget {
  final CategoryRequestList categoryRequestListData;
  ComplainFormInput({Key key, @required this.categoryRequestListData, CategoryRequest categoryRequestData})
      : super(key: key);

  @override
  _ComplainFormInputState createState() => _ComplainFormInputState();
}

class _ComplainFormInputState extends State<ComplainFormInput> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  TextEditingController cda_text = new TextEditingController();
  TextEditingController cdoc_detail = new TextEditingController();
  String _error = 'No Error Dectected';
  DateFormat dateFormat;


  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = new DateFormat("d MMMM yyyy",'th');
  }

  void modalImageBottom(context){
    showModalBottomSheet(
      context: context,

      builder: (BuildContext bc){
          return Container(
            child: new Wrap(
            children: <Widget>[
          new ListTile(
            leading: new Icon(Icons.image),
            title: new Text('Gallery'),
            onTap: () => {
              getImageGallery(),
              Navigator.of(context).pop(),
            }          

          ),
          new ListTile(
            leading: new Icon(Icons.camera_alt),
            title: new Text('Camera'),
            onTap: () => {
              getImageCamera(),
              Navigator.of(context).pop(),
            },          
          ),
            ],
          ),
          );
      }
    );
  }
  
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("ยืนยันการบันทึกข้อมูล"),
          content: new Text("คุณต้องการบันทึกคำร้องใช่หรือไม่"),
          actions: <Widget>[
            new RaisedButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new RaisedButton(
              child: new Text("Confirm"),
              onPressed: () {
                addData();
                // upload(_image);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ComplainPage()));
              },
            ),
          ],
        );
      },
    );
  }
  
  Future<void> addData() async {
    var url="http://10.80.39.17/service-bangpla/index.php/Complain/insert_complaint_data";
    var response = await http.post(url, body: {
      "cda_text": cda_text.text,
      "cdoc_detail": cdoc_detail.text,
      "cda_cdt_id": widget.categoryRequestListData.cda_cdt_id.toString(),
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
    TextEditingController cTitle = new TextEditingController();

    Future getImageGallery() async{
      var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

      final tempDir =await getTemporaryDirectory();
      final path = tempDir.path;

      int rand= new Math.Random().nextInt(100000);
      
      Img.Image image= Img.decodeImage(imageFile.readAsBytesSync());
      Img.Image smallerImg = Img.copyResize(image,height: 200,width: 200);

      var compressImg= new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
      setState(() {
          _image = compressImg;
        });
        
    }

    Future getImageCamera() async{
      var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

      final tempDir =await getTemporaryDirectory();
      final path = tempDir.path;
      int rand= new Math.Random().nextInt(100000);

      Img.Image image= Img.decodeImage(imageFile.readAsBytesSync());
      Img.Image smallerImg = Img.copyResize(image,height: 200,width: 200);

      var compressImg= new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));


      setState(() {
          _image = compressImg;
        });
    }

    Future upload(File imageFile) async{
      var stream= new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length= await imageFile.length();
      var uri = Uri.parse("http://172.20.10.4/my_store/upload.php");

      var request = new http.MultipartRequest("POST", uri);

      var multipartFile = new http.MultipartFile("image", stream, length, filename: imgpath.basename(imageFile.path)); 
      request.fields['title'] = cTitle.text;
      print(imgpath.basename(imageFile.path));
      request.files.add(multipartFile); 

      var response = await request.send();

      if(response.statusCode==200){
        print("Image Uploaded");
      }else{
        print("Upload Failed");
      }
      response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
    }
          @override
          Widget build(BuildContext context) {
            return Theme(
              data: BangplaAppTheme.buildLightTheme(),
              child: Container(
                child: Scaffold(
                  // resizeToAvoidBottomPadding: false,
                  body: Stack(
                    children: <Widget>[
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Column(
                          children: <Widget>[
                            getAppBarUI(),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      getInputUI(),
                                      confirmButton(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        
        
          Widget getAppBarUI() {
            return Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue[900],
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(0, 2),
                      blurRadius: 8.0),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top, left: 8, right: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      width: AppBar().preferredSize.height + 40,
                      height: AppBar().preferredSize.height,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_back_ios,
                            color: Color.fromRGBO(255, 255, 255, 10),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'ร้องเรียน / ร้องทุกข์',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Color.fromRGBO(255, 255, 255, 10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: AppBar().preferredSize.height + 40,
                      height: AppBar().preferredSize.height + 2,
                    )
                  ],
                ),
              ),
            );
          }
        
          Widget getInputUI() {
            DateTime now = DateTime.now();
            var dateTime = new DateTime.now();
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 200,
                            child: Text(
                              ' ประเภทคำร้อง',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, top: 8, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: BangplaAppTheme.buildLightTheme().backgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(18.0),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.9),
                                    offset: Offset(0, 2),
                                    blurRadius: 8.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 6, bottom: 6),
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                cursorColor:
                                    BangplaAppTheme.buildLightTheme().primaryColor,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget.categoryRequestListData.title,
                                  hintStyle:
                                      TextStyle(fontSize: 16.0, color: Colors.black),
                                ),
                                enabled: false,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 200,
                            child: Text(
                              ' คำร้องเรื่อง',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, top: 8, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: BangplaAppTheme.buildLightTheme().backgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.9),
                                    offset: Offset(0, 2),
                                    blurRadius: 8.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 8),
                              child: TextFormField(
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                  controller: cda_text,
                                  cursorColor: BangplaAppTheme.buildLightTheme().primaryColor,
                                  decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "กรุณาใส่เรื่องคำร้อง",
                                ),
                                validator: (cda_text) {
                                  if (cda_text.isEmpty) {
                                    return 'กรุณากรอกข้อมูล';
                                  }
                                  return null;
                                },
                              ),
                              
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, top: 8, bottom: 16),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.9),
                                    offset: Offset(4, 4),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          color: BangplaAppTheme.buildLightTheme().backgroundColor,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 16, top: 8, bottom: 16),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(
                                                          'รายละเอียดคำร้อง',
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 22,
                                                          ),
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 4,
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(right: 16,top: 8,bottom: 8),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color: BangplaAppTheme.buildLightTheme().backgroundColor,
                                                              borderRadius:
                                                                  BorderRadius.all(Radius.circular(15.0),
                                                              ),
                                                              boxShadow: <BoxShadow>[
                                                                BoxShadow(
                                                                    color: Colors.grey.withOpacity(0.9),
                                                                    offset: Offset(0, 2),
                                                                    blurRadius: 8.0),
                                                              ],
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.only(left: 16,right: 16,top: 4,bottom: 100),
                                                              child: TextFormField(
                                                                style: TextStyle(
                                                                  fontSize: 18,
                                                                ),
                                                                  controller: cdoc_detail,
                                                                  cursorColor: BangplaAppTheme.buildLightTheme().primaryColor,
                                                                  decoration:new InputDecoration(
                                                                  border:InputBorder.none,
                                                                  hintText:"กรุณากรอกรายละเอียดร้อง",
                                                                ),
                                                                validator: (cdoc_detail) {
                                                                  if (cdoc_detail.isEmpty) {
                                                                    return 'กรุณากรอกข้อมูล';
                                                                  }
                                                                  return null;
                                                                },
                                                                maxLines: null,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(top: 8, right: 8,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(32.0),
                                          ),
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, top: 0, bottom: 16),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    offset: Offset(4, 4),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          color: BangplaAppTheme.buildLightTheme()
                                              .backgroundColor,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 16, top: 8, bottom: 16),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(
                                                          'รูปภาพ',
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 22,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                          // width: 40,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Container(
                                                              height: 150,
                                                              width: 350,
                                                              decoration: BoxDecoration(
                                                                color: BangplaAppTheme.buildLightTheme().backgroundColor,//////////
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                  Radius.circular(16.0),
                                                                ),
                                                                boxShadow: <BoxShadow>[
                                                                  BoxShadow(
                                                                      color: Colors.grey.withOpacity(0.9),
                                                                      offset: Offset(
                                                                          1.1, 1.1),
                                                                      blurRadius: 10.0),
                                                                ],
                                                              ),
                                                              child : Center(
                                                                child: _image==null
                                                                ? new Container(
                                                                      padding: EdgeInsets.all(30),
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                                                          
                                                                          boxShadow: <BoxShadow>[
                                                                            BoxShadow(
                                                                              color: Colors.grey.withOpacity(0.6),
                                                                              offset: Offset(4, 4),
                                                                              blurRadius: 16,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child: GestureDetector(
                                                                           child:Image.asset("assets/images/plus.png",
                                                                      ),
                                                                      onTap: (){
                                                                        modalImageBottom(context);
                                                                      },
                                                                    ),
                                                                      ),
                                                                    )
                                                                : new Padding(
                                                                      padding: EdgeInsets.all(8),
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                                                          boxShadow: <BoxShadow>[
                                                                            BoxShadow(
                                                                              color: Colors.grey.withOpacity(0.6),
                                                                              offset: Offset(4, 4),
                                                                              blurRadius: 16,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child: GestureDetector(
                                                                          child: ClipRRect(
                                                                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                                                            child: Image.file(_image),
                                                                          ),
                                                                          onTap: (){
                                                                            modalImageBottom(context);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    )
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(32.0),
                                          ),
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        
          Widget confirmButton() {
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: BangplaAppTheme.nearlyBlue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: BangplaAppTheme.nearlyBlue.withOpacity(0.5),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: RaisedButton(
                          color: BangplaAppTheme.nearlyBlue.withOpacity(0.5),
                          child: Text(
                            "บันทึก",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: 0.0,
                              color: BangplaAppTheme.nearlyWhite,
                            ),
                          ),
                          onPressed: () {
        
                          if (_formKey.currentState.validate()) {
                              _showDialog();
                          }
                          }),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            );
          }
    
}

class StatusForm extends StatefulWidget {
  final StatusRequest statusRequestListData;
  StatusForm({Key key, @required this.statusRequestListData}) : super(key: key);

  @override
  _StatusFormState createState() => _StatusFormState();
}

class _StatusFormState extends State<StatusForm> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: BangplaAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          // resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: <Widget>[
                              getInputUI(),
                              // ConfirmButton()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue[900],
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios,
                    color: Color.fromRGBO(255, 255, 255, 10),),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'ติดตามคำร้อง',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Color.fromRGBO(255, 255, 255, 10)
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height + 2,
            )
          ],
        ),
      ),
    );
  }


  Widget _getIconstatusColor() {
    if (widget.statusRequestListData.cds_text == 'ไม่ดำเนินการ')
      return Icon(Icons.brightness_1,color: Colors.yellow,size: 20);
    else if (widget.statusRequestListData.cds_text == 'ดำเนินการเสร็จสิ้น')
      return Icon(Icons.brightness_1,color: Colors.green,size: 20);
    else if (widget.statusRequestListData.cds_text == 'อนุมัติ')
      return Icon(Icons.brightness_1,color: Colors.green,size: 20);
    else if (widget.statusRequestListData.cds_text == 'ไม่อนุมัติ')
      return Icon(Icons.brightness_1,color: Colors.red,size: 20);
    else if (widget.statusRequestListData.cds_text == 'รออนุมัติ')
      return Icon(Icons.brightness_1,color: Colors.yellow,size: 20);
    else
      return Icon(Icons.brightness_1,color: Colors.red,size: 20);
  }

  Widget getInputUI() {
    // String nowdate = formatter.format(nowFormatted);
    // String formattedDate = DateFormat("d MMMM yyyy").format(nowFormatted);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 200,
                    child: Text(
                      ' ประเภทคำร้อง',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5, top: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: BangplaAppTheme.buildLightTheme().backgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(18.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            offset: Offset(0, 2),
                            blurRadius: 8.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 4, bottom: 4),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor:
                            BangplaAppTheme.buildLightTheme().primaryColor,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.statusRequestListData.cdt_text,
                          hintStyle:
                              TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        enabled: false,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 200,
                    child: Text(
                      'คำร้องเรื่อง',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5, top: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: BangplaAppTheme.buildLightTheme().backgroundColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(18.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            offset: Offset(0, 2),
                            blurRadius: 8.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 4, bottom: 4),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor:
                            BangplaAppTheme.buildLightTheme().primaryColor,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.statusRequestListData.cda_text,
                          hintStyle:
                              TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        enabled: false,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 8, bottom: 16),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            offset: Offset(4, 4),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  color: BangplaAppTheme.buildLightTheme()
                                      .backgroundColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, top: 8, bottom: 16),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'รายละเอียดคำร้อง',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'วันที่แจ้ง :',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.8)),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                      height: 40,
                                                    ),
                                                    Text(
                                                      widget.statusRequestListData.cdoc_inform_date,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.8)),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "สถานะ : ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black.withOpacity(0.8)),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Container(
                                                      child: _getIconstatusColor(),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      widget.statusRequestListData.cds_text,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black.withOpacity(0.8)),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(right: 16,top: 8,bottom: 8),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                    
                                                      color: BangplaAppTheme.buildLightTheme().backgroundColor,
                                                      borderRadius: BorderRadius.all(Radius.circular(18.0),
                                                      ),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                            color: Colors.grey.withOpacity(0.9),
                                                            offset: Offset(0, 2),
                                                            blurRadius: 8.0),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(20),
                                                      child: Column(
                                                        children: <Widget>[ 
                                                          SizedBox(
                                                            width: double.infinity,
                                                            child: Text(widget.statusRequestListData.cdoc_detail, 
                                                            style: TextStyle(fontSize: 16.0))
                                                          ),
                                                          ]
                                                        ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
