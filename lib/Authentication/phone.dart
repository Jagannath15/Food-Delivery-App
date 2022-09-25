import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/Authentication/verify_otp.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Phone extends StatefulWidget {
  
  const Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  
  static TextEditingController ph=new TextEditingController();
 
   
  FirebaseAuth auth = FirebaseAuth.instance;
  void verify() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber:"+91 "+ph.text,
  verificationCompleted: (PhoneAuthCredential credential) async {
    await auth.signInWithCredential(credential);
  },
  verificationFailed: (FirebaseAuthException e) {
    if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  },
  codeSent: (String verificationId, int? resendToken) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerify(verificationId:verificationId ,)));
  },
  codeAutoRetrievalTimeout: (String verificationId) {},
);
  }

  
  @override

  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
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
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("We will send you ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
              Text("One Time Password",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              
            ],),
            Text("on your mobile number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300)),
            SizedBox(height: 60,),
            Text("Enter Your mobile number",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
           
            Container(
            margin: EdgeInsets.all(15),
              child: TextField(
                
                cursorColor: Colors.amber,
                cursorHeight: 5,
                keyboardType: TextInputType.number,
                controller: ph,
                
                decoration: InputDecoration(
                    
                  prefix: Text("+91 "),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: 4
                    )
                  ),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: 4
                    )),
                  
      
                )
              ),
            ),
           SizedBox(height: 30,),
      
            InkWell(
                onTap: () async{
                  if(ph.text==null || ph.text.length>10){
                    Get.snackbar("Please verify your number", "Re enter your mobile number");
                  }
                  else{
                  verify();
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  prefs.setString("UserMobile", ph.text);
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
                      Text("Send OTP",style: TextStyle(fontSize: 15),)
                  ],)
                ),
              ) 
      
    
                    ],
          
        ),
      ),
    );
  }
}