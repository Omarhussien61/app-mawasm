import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/modal/User.dart';
import 'package:shoppingapp/pages/login_page.dart';
import 'package:shoppingapp/service/loginservice.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/widgets/commons/auth_header.dart';
import 'package:shoppingapp/widgets/commons/custom_textfield.dart';
import 'package:validators/validators.dart' as validator;
import 'package:shoppingapp/widgets/commons/shadow_button.dart';
import 'package:shoppingapp/utils/screen.dart';

import '../main.dart';
class NextRegisterPage extends StatefulWidget {
  User userM;
  NextRegisterPage(this.userM);
  @override
  _NextRegisterPageState createState() => _NextRegisterPageState();
}

class _NextRegisterPageState extends State<NextRegisterPage> {

  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool _isLoading = false;
  String CountryNo='+20';
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  String smsOTP;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: themeColor.getColor(),
      ),
      child: SafeArea(
        child: WillPopScope(
          // ignore: missing_return
          onWillPop: () {
            Nav.routeReplacement(context, LoginPage());
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AuthHeader(
                    headerTitle: "Register",
                    headerBigTitle: "New",
                    isLoginHeader: false,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 14, right: 36, left: 48),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topCenter,
                                child: MyTextFormField(
                                  labelText: "User Name",
                                  hintText: 'User Name',
                                  isPhone: true,

                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Enter your USER NAME';
                                    } else if (value.length < 6) {
                                      return 'Enter your USER NAME';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    widget.userM.username =value;

                                  },
                                ),
                              ),
                          Container(
                          alignment: Alignment.topCenter,
                            child: MyTextFormField(
                              labelText: "Phone number",
                              hintText: 'Phone number',
                              isPhone: true,
                              prefix:Container(
                                width: ScreenUtil.getWidth(context)/4,
                                child: CountryCodePicker(

                                  textStyle: TextStyle(
                                      color: Provider.of<ThemeNotifier>(context).color),
                                  onChanged: (v){
                                    setState(() {
                                      this.CountryNo=v.toString();
                                      print(this.CountryNo);

                                    });
                                  },
                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                  initialSelection: 'EG',
                                  favorite: ['SA','EG'],
                                  // optional. Shows only country name and flag
                                  showCountryOnly: true,
                                  // optional. Shows only country name and flag when popup is closed.
                                  showOnlyCountryWhenClosed: false,
                                  // optional. aligns the flag and the Text left
                                  alignLeft: true,
                                ),
                              ) ,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Enter your Phone number';
                                } else if (value.length < 10) {
                                  return 'Enter your Phone number';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                widget.userM.phone =this.CountryNo+value;

                              },
                            ),
                          ),
                          Container(
                                height: 48,
                                width: ScreenUtil.getWidth(context),
                                margin: EdgeInsets.only(top: 12, bottom: 0),
                                child: ShadowButton(
                                  borderRadius: 12,
                                  height: 40,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(8.0),
                                    ),
                                    color: themeColor.getColor(),
                                    onPressed: () async
                                    {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        setState(() => _isLoading = true);
                                        verifyPhone();

                                      }
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _isLoading ? Container(
                          height: ScreenUtil.getHeight(context),
                          width: double.infinity,
                          color: Colors.black45,
                          child: Center(child:  CircularProgressIndicator(
                              valueColor:  AlwaysStoppedAnimation<Color>(themeColor.getColor()))))
                          : Container()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      Navigator.of(context).pop();
      var result =  await LoginService().Register(
          widget.userM );
      if(result.runtimeType==String)
      {
        setState(() => _isLoading = false);
        showAlertDialog(result.toString(),'Alart');
      }
      else
      {
        SharedPreferences.getInstance().then((prefs){
          prefs.setString('image_url', widget.userM.avatarUrl);
        });
        setState(() => _isLoading = false);
        Nav.routeReplacement(context, InitPage());
        Provider.of<ThemeNotifier>(context).setLogin(true);
      }
    } catch (e) {
      handleError(e);
    }
  }
  handleError(PlatformException error) {
    setState(() => _isLoading = false);
    print(error);
    switch (error.code) {
      case 'خطأ فى الكود':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'كود غير صحيح';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }
  Future<void> verifyPhone() async {

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      setState(() => _isLoading = false);

      smsOTPDialog(context).then((value) {
        print('Signed in');
      });
    };
    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      setState(() => _isLoading = false);

      filedDialog(context,exception.message);
      print('${exception.message}');
    };

    print(widget.userM.phone);

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: widget.userM.phone,
          codeAutoRetrievalTimeout: autoRetrieve,
          codeSent: smsCodeSent,
          timeout: const Duration(seconds: 5),
          verificationCompleted:  (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: veriFailed);
      final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verId;
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
      };
    } catch (e) {
      handleError(e);
    }
  }

  Future<bool> filedDialog(BuildContext context,String error) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Center(child: Text('خطأ')),
            content: Container(
                child: Text(error)
            ),


          );
        });
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text(getTransrlate(context, 'CodeConfirm')),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },

                ),
                (errorMessage != ''
                    ? Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[

              FlatButton(
                child: Text(getTransrlate(context, 'Confirm'),
                  style:  TextStyle(
                    color: Colors.black,
                    fontSize:15,
                  ),
                ),
                onPressed: () {
                  signIn();
                },
              )

            ],
          );
        });
  }


  void showAlertDialog(String title, String msg){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(msg),
          content: new Text(title),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

}