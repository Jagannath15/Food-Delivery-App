import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/Authentication/phone.dart';
import 'package:food_delivery_app/Screens/home.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerify extends StatefulWidget {
  final String verificationId;
  const OtpVerify({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  TextEditingController otp=new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  
  bool Checkuser=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 100,),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/authentication.png"))
              ),
            ),
            Text("OTP Verification",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.all(15),
              child: Text("Enter the OTP sent on your mobile number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400))),
            
           Container(
            margin: EdgeInsets.all(15),
             child: Pinput(
              controller: otp,
               length: 6,
              keyboardType: TextInputType.number,
             ),
           ),
            SizedBox(height: 80,),
            
            
             InkWell(
                  onTap: () async{
                     final credential=PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otp.text);
              try{
                await auth.signInWithCredential(credential);  
                SharedPreferences prefs=await SharedPreferences.getInstance();
                prefs.setBool("finalLogin", false);

             Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>Home()), (route) => false);        
            
             
              }catch(e){
                Get.snackbar("Error","Please re-enter your OTP ");
              }
                  },
                  child: Container(
                     margin: EdgeInsets.all(15),
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.password),
                        SizedBox(width: 5,),
                        Text("Verify & Proceed",style: TextStyle(fontSize: 15),)
                    ],)
                  ),
                ),
                 
          ],
        ),
      ),
    );
  }
}