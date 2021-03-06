import 'package:flutterphone/Inside_the_app/user_Profile.dart';
import 'package:flutterphone/screens/signuser_screen.dart';
import 'package:flutterphone/screens/welcome.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_cloud_messaging/firebase_cloud_messaging.dart';
import 'package:flutterphone/components/already_have_an_account_acheck.dart';
import 'package:flutterphone/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutterphone/components/pin_entry_text_field.dart';
import 'dart:io';
import 'dart:convert';
import 'login_screen.dart';
import 'welcome.dart';
String IP4="192.168.1.8";
String _verificationCode;
String smscode ;

FocusNode myFocusNode = new FocusNode();


class SignuserScreen extends StatefulWidget {
  @override

  _Body createState() => _Body();
}

class _Body extends State<SignuserScreen> {

  String country_id="اختيار المنطقة";
  String hint="اختيار المنطقة";
  List<String>country=["جنين","نابلس","طولكرم","رام الله","طوباس","حيفا","يافا","عكا","الخليل","قلقيلية"];
  OverlayEntry floatingDropdown;
  TextEditingController nameController = TextEditingController();
  TextEditingController namefirstController = TextEditingController();
  TextEditingController namelastController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passController2 = TextEditingController();
  TextEditingController Coutry = TextEditingController();
  TextEditingController phone_Num = TextEditingController();
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;
  Future getdata()async{
    var url='https://'+IP4+'/testlocalhost/getNameforusers.php';
    var ressponse=await http.get(url);
    String massage= json.decode(ressponse.body);
    if(massage=='userlogin'){
    }
  }
  @override
  bool selected=true ;
  bool Name_Null=true;
  bool Namefirst_Null=true;
  bool Namelast_Null=true;
  bool Pass_Null=true;
  bool Pass_Mismatch=true;
  bool Phone=true;
  bool Pass_S=true;
  bool Pass_R=true;
  bool Invaled_Phone=true;
  bool _showPassword1 = false;
  bool _showPassword2 = false;
  bool invalid_OTP=false;
  bool Country=true;
  bool card1=true;
  bool card2=false;
  bool isDropdownOpened=false;
  bool ButtonDrop=false;
  var mytoken ;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  GlobalKey actionKey;
  double height, width, xPosition, yPosition;
  @override
  void initState() {

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        mytoken = token ;
      });
      print(mytoken);
    });
    setState(() {
      Country=true;
    });
    super.initState();
  }

  void _togglevisibility1() {
    setState(() {
      _showPassword1 = !_showPassword1;
    });
  }
  void _togglevisibility2() {
    setState(() {
      _showPassword2 = !_showPassword2;
    });
  }
  void findDropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
    print(height);
    print(width);
    print(xPosition);
    print(yPosition);
  }
  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: 50,
        top: 350,
        height: 500,
        child: Drop(

        ),
      );
    });
  }

  String radioItem = '';
  PickedFile image_file;
  File _file;
  bool choose=false;
  final ImagePicker image_picker =ImagePicker();
  Widget build(BuildContext context) {

    debugShowCheckedModeBanner: false;
    Size size = MediaQuery.of(context).size;
    bool _value1 = false;
    bool _value2 = false;
    String code = "";
    String pass="";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor:Colors.white,
        // appBar: AppBar(
        //   leading:  IconButton(
        //     alignment: Alignment.topRight,
        //     onPressed: () {
        //       if(card1){
        //         Navigator.of(context).push(
        //             MaterialPageRoute(
        //                 builder: (BuildContext context) =>WelcomeScreen()));}
        //       if(!card1){
        //         card1=true;
        //         setState(() {
        //         });
        //       }
        //     },
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //       size: 30.0,
        //     ),
        //   ),
        //   actions: [
        //
        //   ],
        // ),
        body: Form(key: formKey,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [

                    ClipPath(
                      clipper: Clipper4(),
                      child:  Container(
                        height: 220,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [B,G]),),

                        // child: Center(child: Text("MultiplePointedEdgeClipper()")),
                      ),
                    ),
                   Column(
                      children: [
                        Center(
                          child: Container(margin:EdgeInsets.only(top:90),child: image_profile(),),),
                      ],),
                  ],
                ),

                // GestureDetector(
                //   child: AnimatedContainer(
                //     duration: Duration(milliseconds: 500),
                //     curve: Curves.ease,
                //     height:MediaQuery.of(context).size.height * 0.28,
                //     child: CustomPaint(
                //       painter: CurvePainter(false),
                //       child: Column(
                //         children: [
                //           Center(
                //             child: Container(margin:EdgeInsets.only(top:90),child: image_profile(),),),
                //         ],),
                //     ),
                //   ),
                // ),
                GestureDetector(

                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                      height: MediaQuery.of(context).size.height * 0.72,
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.only(top: 5),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0,),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                card1?Container(
                                  child: Column(
                                    children:[
                                      Container(
                                       child:Row(
                                         children: [
                                           Container(
                                             margin: EdgeInsets.fromLTRB(0,70,40,0),
                                             width: size.width * 0.33,
                                             height: 60,
                                             child: TextFormField(
                                               controller: namefirstController,
                                               validator: (value) {
                                                 if (value.isEmpty) {
                                                   Namefirst_Null=false;
                                                   return null;
                                                 } else {

                                                   Namefirst_Null=true;
                                                   return null;
                                                 }
                                               },
                                               cursorColor: kPrimaryColor,
                                               textAlign: TextAlign.right,
                                               style: TextStyle(
                                                 fontSize: 16.0,
                                                 fontWeight: FontWeight.bold,
                                                 fontFamily: 'Changa',
                                               ),
                                               decoration: InputDecoration(
                                                 filled: true,
                                                 fillColor:Colors.grey[100],
                                                 enabledBorder: new OutlineInputBorder(
                                                   borderRadius: new BorderRadius.circular(30.0),
                                                   borderSide:  BorderSide(color:Colors.grey[100]),

                                                 ),
                                                 focusedBorder: new OutlineInputBorder(
                                                   borderRadius: new BorderRadius.circular(30.0),
                                                   borderSide:  BorderSide(color:Colors.grey[100]),

                                                 ),
                                                 hintText: 'الاسم الأول ',
                                                 hintStyle: TextStyle(
                                                   fontSize: 16.0,
                                                   fontFamily: 'Changa',
                                                   color: Color(0xFF666360),
                                                 ),
                                                 floatingLabelBehavior: FloatingLabelBehavior.always,
                                               ),
                                             ),
                                           ),
                                           Container(
                                             margin: EdgeInsets.fromLTRB(0,70,10,0),
                                             //padding: EdgeInsets.fromLTRB(0,0,30,0),
                                             width: size.width * 0.44,
                                             height: 60,
                                             child: TextFormField(
                                               controller: namelastController,
                                               validator: (value) {
                                                 if (value.isEmpty) {
                                                   Namelast_Null=false;
                                                   return null;
                                                 } else {

                                                   Namelast_Null=true;
                                                   return null;
                                                 }
                                               },
                                               cursorColor: kPrimaryColor,
                                               textAlign: TextAlign.right,
                                               style: TextStyle(
                                                 fontSize: 16.0,
                                                 fontWeight: FontWeight.bold,
                                                 fontFamily: 'Changa',
                                               ),
                                               decoration: InputDecoration(
                                                 filled: true,
                                                 fillColor:Colors.grey[100],
                                                 enabledBorder: new OutlineInputBorder(
                                                   borderRadius: new BorderRadius.circular(30.0),
                                                   borderSide:  BorderSide(color:Colors.grey[100]),

                                                 ),
                                                 focusedBorder: new OutlineInputBorder(
                                                   borderRadius: new BorderRadius.circular(30.0),
                                                   borderSide:  BorderSide(color:Colors.grey[100]),

                                                 ),
                                                 //contentPadding: EdgeInsets.only(),
                                                 hintText: ' اسم العائلة ',
                                                 hintStyle: TextStyle(
                                                   fontSize: 16.0,
                                                   fontFamily: 'Changa',
                                                   color: Color(0xFF666360),
                                                 ),
                                                 floatingLabelBehavior: FloatingLabelBehavior.always,
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                      ),
                                      Namelast_Null || Namefirst_Null ? Container(
                                        margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                        child: Text('',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),
                                      ): Container(
                                        margin: EdgeInsets.fromLTRB(105, 0, 0, 0),
                                        child: Text('يجب إدخال الاسمان الأول والأخير !',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),
                                      ),
                                      Container(
                                      margin: EdgeInsets.fromLTRB(0,5,0,0),
                                      width: size.width * 0.8,
                                      height: 60,
                                      child: TextFormField(
                                        controller: nameController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            Name_Null=false;
                                            return null;
                                          } else {

                                            Name_Null=true;
                                            return null;
                                          }
                                        },
                                        cursorColor: kPrimaryColor,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Changa',
                                        ),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                          prefixIcon: Icon(Icons.person,color: Color(0xFF666360)),
                                          enabledBorder: new OutlineInputBorder(
                                            borderRadius: new BorderRadius.circular(30.0),
                                            borderSide:  BorderSide(color:Colors.grey[100]),

                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                            borderRadius: new BorderRadius.circular(30.0),
                                            borderSide:  BorderSide(color:Colors.grey[100]),

                                          ),
                                          hintText: 'اسم المستخدم ',
                                          hintStyle: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Changa',
                                            color: Color(0xFF666360),
                                          ),
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                        ),
                                      ),
                                    ),
                                      Name_Null ? Container(margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                        child: Text('',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),): Container(
                                        margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                        child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0,5,0,0),
                                        padding: EdgeInsets.symmetric(horizontal:0,),
                                        width: size.width * 0.8,
                                        height: 60,
                                        child: TextFormField(
                                          controller: passController,
                                          validator: (value) {
                                            pass=value;
                                            if (value.isEmpty) {
                                              Pass_Null=false;
                                              Pass_S=true;
                                              return null;
                                            } else if (value.length < 8) {
                                              Pass_S=false;
                                              Pass_Null=true;
                                              return null;
                                            }
                                            Pass_Null=true;
                                            Pass_S=true;
                                            return null;
                                          },
                                          obscureText: !_showPassword1,
                                          cursorColor: kPrimaryColor,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Changa',
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            prefixIcon: Icon(Icons.lock, color:Color(0xFF666360)),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                _togglevisibility1();
                                              },
                                              child: Icon(
                                                _showPassword1 ? Icons.visibility : Icons
                                                    .visibility_off, color: Color(0xFF666360),),
                                            ),
                                            enabledBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(30.0),
                                              borderSide:  BorderSide(color:Colors.grey[100]),

                                            ),
                                            focusedBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(30.0),
                                              borderSide:  BorderSide(color:Colors.grey[100]),

                                            ),
                                            hintText: ('كلمة السر'),
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Changa',
                                              color: Color(0xFF666360),
                                            ),
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                          ),

                                        ),
                                      ),
                                      Pass_Null && Pass_S ?  Container(
                                        margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                        child: Text('',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),):Container(),
                                      Pass_Null ? Container(
                                      ): Container(
                                        margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                        child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),
                                      ),
                                      Pass_S ? Container(

                                      ): Container(
                                        margin: EdgeInsets.fromLTRB(70, 0, 0, 0),
                                        child: Text(' * يجب أن تحتوي كلمة السر 8 أحرف على الأقل',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0,5,0,0),
                                        width: size.width * 0.8,
                                        height: 60,
                                        child: TextFormField(
                                          validator: (value) {
                                            if(passController.text.isEmpty){
                                              return null;
                                            }
                                            if(value==pass) {
                                              Pass_Mismatch=true;
                                              return null;
                                            }
                                            Pass_Mismatch=false;
                                            return null;
                                          },
                                          obscureText: !_showPassword2,
                                          cursorColor: kPrimaryColor,
                                          textAlign: TextAlign.right,
                                          controller: passController2,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Changa',
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            prefixIcon: Icon(Icons.lock, color: Color(0xFF666360)),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                _togglevisibility2();
                                              },
                                              child: Icon(
                                                  _showPassword2 ? Icons.visibility : Icons
                                                      .visibility_off, color: Color(0xFF666360)),
                                            ),
                                            enabledBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(30.0),
                                              borderSide:  BorderSide(color:Colors.grey[100]),

                                            ),
                                            focusedBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(30.0),
                                              borderSide:  BorderSide(color:Colors.grey[100]),

                                            ),
                                            hintText: ('تأكيد كلمة السر'),
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Changa',
                                              color: Color(0xFF666360),
                                            ),
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                          ),
                                        ),
                                      ),
                                      // Container(height: 10,),
                                      Pass_Mismatch ? Container(
                                        margin: EdgeInsets.fromLTRB(170, 0,0, 0),
                                        child: Text('',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),
                                      ): Container(
                                        margin: EdgeInsets.fromLTRB(170, 0,0, 0),
                                        child: Text(' * كلمة السر غير متطابقة',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child:AlreadyHaveAnAccountCheck(
                                          login: false,
                                          press: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return Loginscreen();
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                     //Container(height: 10,),
                                    ],
                                  ),):Container(
                                  child: Column(
                                    children:[
                                      Container(
                                        margin: EdgeInsets.only(top:20,right:10,left:290),
                                        child:IconButton(
                                          onPressed: () {
                                            if(card1){
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (BuildContext context) =>WelcomeScreen()));}
                                            if(!card1){
                                              card1=true;
                                              setState(() {
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color:Colors.yellow,
                                            size: 20.0,
                                          ),),),

                                      GestureDetector(
                                        key: actionKey,
                                        onTap: () {
                                          setState(() {
                                            if (isDropdownOpened) {
                                              floatingDropdown.remove();
                                            } else {
                                              //findDropdownData();
                                              floatingDropdown = _createFloatingDropdown();
                                              Overlay.of(context).insert(floatingDropdown);
                                            }
                                            isDropdownOpened = !isDropdownOpened;
                                          });
                                        },
                                        child: Container(
                                          height: 60,
                                          width:size.width*0.8,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.grey[100],
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                country_id,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'Changa',
                                                  color: Color(0xFF666360),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.location_on,
                                                color: Color(0xFF666360),
                                                size: 27,
                                              ),
                                            ],
                                          ),
                                        ),),

                                      // Directionality(textDirection:TextDirection.rtl, child:
                                      // Container(
                                      //     margin: EdgeInsets.fromLTRB(0,10,0,0),
                                      //     padding: EdgeInsets.fromLTRB(20,15,20,10),
                                      //     width: size.width * 0.8,
                                      //     height: 60,
                                      //     decoration: BoxDecoration(
                                      //       color: Colors.grey[100],
                                      //       borderRadius: BorderRadius.circular(30.0),
                                      //       // border: Border.all(color: Colors.grey, width: 1.2)
                                      //     ),
                                      //     child:DropdownButton(
                                      //       isExpanded: true,
                                      //       itemHeight: 50,
                                      //       icon: Icon(Icons.pin_drop),
                                      //       iconSize:30.0,
                                      //       value: country_id,
                                      //       dropdownColor: Colors.white,
                                      //       onChanged: (value){
                                      //            setState(() {
                                      //              country_id=value;
                                      //              value=value;
                                      //              print(country_id);
                                      //              // Country=true;
                                      //            });
                                      //       },
                                      //       hint:Text(" اختيار المنطقة ",
                                      //         style: TextStyle(
                                      //           fontSize: 16.0,
                                      //           fontFamily: 'Changa',
                                      //           color: Color(0xFF666360),
                                      //           fontWeight: FontWeight.bold,
                                      //         ),),
                                      //       underline: Container(color: Colors.transparent),
                                      //       style: TextStyle(
                                      //         fontSize: 16.0,
                                      //         fontFamily: 'Changa',
                                      //         color: Color(0xFF666360),
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //       items:country.map((value){
                                      //         return DropdownMenuItem(
                                      //           child: Container(
                                      //             height: 50,
                                      //             width: 260.0,
                                      //             child: Text(value, textAlign: TextAlign.right),
                                      //           ),
                                      //           value: value,
                                      //         );
                                      //       }).toList(),
                                      //
                                      //     )
                                      // ),),
                                      Country ? Container(
                                          child: Text('',textAlign:TextAlign.end,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Changa',
                                              color: Colors.red,

                                            ),)
                                      ): Container(
                                        margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                        child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),
                                      ),
                                      Container(
                                          margin: EdgeInsets.fromLTRB(0,0,0,0),
                                          padding: EdgeInsets.symmetric(),
                                          width: size.width * 0.8,
                                          height: 60,
                                          child: TextFormField(
                                            controller: phone_Num,
                                            keyboardType: TextInputType.phone,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                Phone=false;
                                                return null;
                                              } else {
                                                Phone=true;
                                                return null;
                                              }

                                            },
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              prefixIcon: Icon(Icons.phone,color: Color(0xFF666360),),
                                              enabledBorder: new OutlineInputBorder(
                                                borderRadius: new BorderRadius.circular(30.0),
                                                borderSide:  BorderSide(color:Colors.grey[100]),
                                              ),
                                              focusedBorder: new OutlineInputBorder(
                                                borderRadius: new BorderRadius.circular(30.0),
                                                borderSide:  BorderSide(color:Colors.grey[100]),

                                              ),
                                              hintText: ('رقم الهاتف'),
                                              hintStyle: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Changa',
                                                color: Color(0xFF666360),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                            ),
                                            onChanged: (val) {
                                              setState(() {
                                                this.phoneNo = val;
                                              });
                                            },
                                            cursorColor: kPrimaryColor,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Changa',

                                            ),
                                          )),
                                      Phone ? Container(
                                          child: Text('',textAlign:TextAlign.end,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Changa',
                                              color: Colors.red,

                                            ),)
                                      ): Container(
                                        margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
                                        child: Text('هذا الحقل مطلوب !',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),
                                      ),
                                      Invaled_Phone ? Container(): Container(
                                        margin: EdgeInsets.fromLTRB(1, 0,0, 0),
                                        child: Text('يجب أن يكون رقم الهاتف على الصورة [number][country] + ',textAlign:TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Changa',
                                            color: Colors.red,

                                          ),),
                                      ),
                                      invalid_OTP?Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(29),
                                          child: FlatButton(
                                              padding: EdgeInsets.symmetric(vertical: 9, horizontal: 50),
                                              color: Color(0xFF1C1C1C),
                                              child:Text("إعادة إرسال الكود",
                                                style:TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: 'Changa',
                                                  color: Color(0xFF666360),
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                              onPressed: (){
                                                if (formKey.currentState.validate()) {print('validate');}
                                                else{print('not validate');}
                                                if(Phone){
                                                  _verifyPhone(phoneNo);
                                                  setState(() {

                                                  });
                                                }
                                              }
                                          ),
                                        ),
                                      ):Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(29),
                                          child: FlatButton(
                                              padding: EdgeInsets.symmetric(vertical:0, horizontal:0),
                                              color: Colors.white,
                                              child:Text("اضغط لإرسال الكود",
                                                style:TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: 'Changa',
                                                  color: Color(0xFF666360),
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                              onPressed: (){
                                                if (formKey.currentState.validate()) {print('validate');}
                                                else{print('not validate');}
                                                if(Phone){
                                                  _verifyPhone(phoneNo);
                                                  setState(() {
                                                  });
                                                }
                                                //   if(Phone){
                                                //   verifyPhone(phoneNo);
                                                //   setState(() {
                                                //
                                                //   });
                                                // }
                                              }
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   child: RaisedButton(
                                      //     //child:Text("jH;d] الكود"),
                                      //     onPressed: (){
                                      //       if(codeSent){
                                      //         print("send");
                                      //         signInWithOTP(smsCode, verificationId);
                                      //       }
                                      //     },
                                      //   ),
                                      // ),
                                      codeSent?Center(
                                        child:Directionality(textDirection: TextDirection.ltr,
                                        child:Container(
                                          margin: EdgeInsets.only(top:0,bottom: 89,left: 15,right:5),
                                          // padding: EdgeInsets.only(top:0.05),
                                          height: 55,
                                          // color:Colors.grey.withOpacity(0.1),
                                          child: PinEntryTextField(
                                            fields: 6,
                                            fontSize: 16.0,
                                            fieldWidth: 45.0,
                                            showFieldAsBox: true,
                                            onSubmit: (String pin){

                                              setState((){
                                                this.smsCode=pin;
                                                smscode=pin;
                                              },
                                              );
                                            },
                                          ), //
                                        ),),):Container(height: 145,),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 400,
                                  margin: EdgeInsets.only(left: 145,right: 145,top: 10),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        side: BorderSide(color: Colors.transparent)
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                                    color: D,
                                    onPressed: () async {
                                      if(!card1) {
                                        setState(() {
                                          if (country_id == null) {
                                            print("ggg");
                                            Country = false;
                                          }
                                          else {
                                            print("fff");
                                            Country = true;
                                          }
                                        });
                                      }
                                      if (formKey.currentState.validate()) {print('validate');}
                                      else{print('not validate');}
                                      if(card1){
                                        if(Name_Null && Namefirst_Null && Namelast_Null& Pass_Null && Pass_Mismatch &&  Pass_S && !nameController.text.isEmpty && !namefirstController.text.isEmpty && !namelastController.text.isEmpty && !passController.text.isEmpty && !passController2.text.isEmpty){
                                          card1=false;
                                          print(!passController.text.isEmpty);
                                        }}
                                      else{
                                          if(country_id=="اختيار المنطقة"){Country=false;}
                                          else{Country=true;}
                                        if(Phone && codeSent && Country){
                                          print(country_id);
                                          try {
                                            await FirebaseAuth.instance
                                                .signInWithCredential(PhoneAuthProvider.credential(
                                                verificationId: _verificationCode, smsCode: smscode))
                                                .then((value) async {
                                              if (value.user != null) {
                                                senddata();
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => U_PROFILE(name_Me: nameController.text,)),
                                                        (route) => false);
                                              }
                                            });
                                          } catch (e) {
                                            invalid_OTP=true;
                                            // FocusScope.of(context).unfocus();
                                            // _scaffoldkey.currentState
                                            //     .showSnackBar(SnackBar(content: Text('invalid OTP')));
                                          }

                                          // _verifyPhone(phoneNo);
                                        }
                                      }
                                      // if(Name_Null &&  Pass_Null &&  Pass_Mismatch &&  Phone &&  Pass_S){
                                      //   // codeSent ? signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                                      // }
                                      setState(() {
                                      });
                                      //else{card1=true;}
                                      // if(Name_Null &&  Pass_Null &&  Pass_Mismatch &&  Phone &&  Pass_S){
                                      //   // codeSent ? signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                                      // }
                                    },
                                    child: Center(child: !card1 ? Text('تأكيد',
                                      style: TextStyle(
                                        fontSize: 21.0,
                                        fontFamily: 'Changa',
                                        color:  Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),):Text('استمرار',
                                        style: TextStyle(
                                          fontSize: 21.0,
                                          fontFamily: 'Changa',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ))),
                                  ),
                                ),
                                Row(children:[
                                  Container(
                                    width: 10.0,
                                    height: 10.0,
                                    margin: EdgeInsets.only(top: 30,left: 0,right: 190),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: card1 ? D :  Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                  Container(
                                    width: 10.0,
                                    height: 10.0,
                                    margin: EdgeInsets.only(top: 30,left: 100,right: 10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: card1 ?  Colors.grey.withOpacity(0.5):D,
                                    ),
                                  ),

                                ],),
                              ],
                            ),
                          ),),
                      ),
                    )
                ), ],),),
        ),),);
  }
  _verifyPhone(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            // if (value.user != null) {
            //   Navigator.pushAndRemoveUntil(
            //       context,
            //       MaterialPageRoute(builder: (context) => InsideAPP()),
            //           (route) => false);
            // }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          String c=e.code;
          if(c=='invalid-phone-number'){setState(() {Invaled_Phone=false;});}
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
            codeSent=true;Invaled_Phone=true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }
  // Future<void> verifyPhone(phoneNo) async {
  //
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithCredential(PhoneAuthProvider.credential(
  //         verificationId: _verificationCode, smsCode: phoneNo))
  //         .then((value) async {
  //       if (value.user != null) {
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (context) => Home()),
  //                 (route) => false);
  //       }
  //     });
  //   } catch (e) {
  //     FocusScope.of(context).unfocus();
  //     _scaffoldkey.currentState
  //         .showSnackBar(SnackBar(content: Text('invalid OTP')));
  //   }
  //
  //
  //   // final PhoneVerificationCompleted verified = (AuthCredential authResult) {
  //   //   AuthService().signIn(authResult);
  //   // };
  //   //
  //   // final PhoneVerificationFailed verificationfailed =
  //   //     (FirebaseAuthException authException) {
  //   //   print('${authException.message}');
  //   //   String c=authException.code;
  //   //   if(c=='invalid-phone-number'){setState(() {Invaled_Phone=false;});}
  //   // };
  //   //
  //   // final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
  //   //   this.verificationId = verId;
  //   //   setState(() {
  //   //     this.codeSent = true;
  //   //   });
  //   // };
  //   //
  //   // final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
  //   //   this.verificationId = verId;
  //   // };
  //   //
  //   // await FirebaseAuth.instance.verifyPhoneNumber(
  //   //     phoneNumber: phoneNo,
  //   //     timeout: const Duration(seconds: 5),
  //   //     verificationCompleted: verified,
  //   //     verificationFailed: verificationfailed,
  //   //     codeSent: smsSent,
  //   //     codeAutoRetrievalTimeout: autoTimeout);
  // }
  Widget Drop(){
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Container(
          width: 300,
         // color: Colors.yellow,
          padding: EdgeInsets.only(right: 238),
          alignment: Alignment.topLeft,
        child:Align(
         // alignment: Alignment(10,20),
          child: ClipPath(
            clipper: ArrowClipper(),
            child:Container(
              height: 20,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 0.02,
                    color: Colors.black,
                  ),
                ],
                  // boxShadow:
                ),
            // child: Card(
            //   elevation: 5,
            //   //margin: EdgeInsets.only(left: 50,right: 50),
            //   // height: 20,
            //   // width: 30,
            ),
          ),
        ),),
        Material(
          elevation: 5,
          //shape: ArrowShape(),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child:SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  DropDownItem("جنين"),
                  DropDownItem("نابلس"),
                  DropDownItem("طوباس"),
                  DropDownItem("طولكرم"),
                  DropDownItem("رام الله"),
                  DropDownItem("بيت لحم"),
                  DropDownItem("الخليل"),
                  DropDownItem("قلقيلية"),
                  DropDownItem("عكا"),
                  DropDownItem("حيفا"),
                  DropDownItem("يافا"),
                ],
              ),
            ),
          ),
        ),],
    );
  }
  Widget image_profile(){
    return Center(
      child:Stack (children: <Widget>[
        CircleAvatar(
          backgroundImage: image_file==null? AssetImage('assets/icons/signup.jpg'):FileImage(File(image_file.path)),
          radius: 60.0,
        ),
        Positioned(
          bottom:10.0,
          right:3.0,
          child: InkWell(
            onTap:(){
              showModalBottomSheet(context: context, builder: (builder) => buttom_camera(),);
            },
            child:Icon(Icons.camera_alt,color: Colors.grey,size: 35.0,),),),
      ],
      ),);
  }
  Widget DropDownItem(String text) {

    return Directionality(textDirection: TextDirection.ltr,
      child:Container(
        width:300,
        height: 50,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          color:Colors.white,
        ),
        //margin: EdgeInsets.only(right: 16,),
        padding: EdgeInsets.only(left: 50, top: 8,bottom: 8),
        child: Container(
          width: 100,
          margin: EdgeInsets.only(right: 5,),
          padding: EdgeInsets.only(right: 5,),
          alignment: Alignment.topRight,
          child:FlatButton(
            onPressed: (){
              print(text);
              setState(() {
                isDropdownOpened=false;
                floatingDropdown.remove();
                country_id=text;
              });
            },
            child: Text(text,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Changa',
                color: Color(0xFF666360),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),),);
  }
  Widget buttom_camera(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
      child: Column(children: <Widget>[
        Text('Choose Profile Photo'),
        SizedBox(height: 20.0,),
        Row(mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.camera_alt),
            onPressed: (){
              takePhoto(ImageSource.camera);
            },
            label: Text("Camera"),),
          FlatButton.icon(
            icon: Icon(Icons.image),
            onPressed: (){
              takePhoto(ImageSource.gallery);
            },
            label: Text("Gallery"),),
        ],),
      ],),
    );
  }
  void takePhoto(ImageSource source)async{
    final file =await image_picker.getImage(
      source:source,
    );
    setState(() {
      if(file==Null){image_file=Image.asset("assets/icons/signup.png") as PickedFile;}
      else{image_file=file;}
    });
  }
  //SignIn
  // signIn(AuthCredential authCreds) {
  //   FirebaseAuth.instance.signInWithCredential(authCreds);
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.onAuthStateChanged,
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           // FirebaseAuth.instance.signOut();
  //           print(snapshot.data.toString());
  //           return InsideAPP();
  //         } else {
  //           return SignuserScreen();
  //         }
  //       });
  // }

  Future senddata()async{
    if(image_file==null){
      print("image null");
      var url = 'https://'+IP4+'/testlocalhost/signup.php';
      var ressponse = await http.post(url, body: {
        "name": nameController.text,
        "namefirst": namefirstController.text,
        "namelast": namelastController.text,
        "pass": passController.text,
        "phone": phone_Num.text,
        "imagename": "signup.jpg",
        "image64": '',
        "mytoken":mytoken,
        "country": country_id,
      });
      String massage= json.decode(ressponse.body);
      print(massage);
    }
    else{ String base64;
    String imagename;
    _file = File(image_file.path);
    base64 = base64Encode(_file.readAsBytesSync());
    imagename = _file.path.split('/').last;
    var url = 'https://'+IP4+'/testlocalhost/signup.php';
    var ressponse = await http.post(url, body: {
      "name": nameController.text,
      "namefirst": namefirstController.text,
      "namelast": namelastController.text,
      "pass": passController.text,
      "phone": phone_Num.text,
      "country": country_id,
      "imagename": imagename,
      "image64": base64,
      "mytoken":mytoken,
    });
    String massage= json.decode(ressponse.body);
    print(massage);
    }

  }
}

class CurvePainter extends CustomPainter {

  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = A;
    paint.style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.5, outterCurve ? size.height + 110 : size.height - 110, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Clipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.5,size.height - 110, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

      path.moveTo(0, size.height);
      path.lineTo(size.width /2, 0);
      path.lineTo(size.width, size.height);

      return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
