
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Authentication/phone.dart';
import 'package:food_delivery_app/Authentication/verify_otp.dart';
import 'package:food_delivery_app/Screens/home.dart';
import 'package:food_delivery_app/Screens/order_successfull.dart';
import 'package:food_delivery_app/Screens/payment.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp()
  //MaterialApp(home: MyApp())
  );

}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool ?login;
  @override
  void initState() {
    // TODO: implement initState  
    login=true;
    finalstate();
  }
  @override
  

  void finalstate() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
     setState(() {
      login=prefs.getBool("finalLogin");
    });
  }

  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
     home:login==false? Home(): StartPage(),
    
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: double.infinity,
        width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/image.png"),
             fit: BoxFit.cover,
            ),
          ),

         child: Padding(padding: EdgeInsets.only(top: 50,left: 10,right: 10,bottom: 10),
          // main
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Text("GET DELIVERED",style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold),),
              Text("FAST FOOD AT",style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold)),
              Text("AT YOUR",style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold,)),
              Text("DOOR.",style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold,)),
             SizedBox(height: 10,),
              Text("Hate cooking? We’re for you.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,)),
             SizedBox(height: 280,),
              InkWell(
                onTap: (){
                  Get.to(Phone());
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD207),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call,color: Colors.white,),
                      SizedBox(width: 5,),
                      Text("Continue with Mobile Number",style: TextStyle(fontSize: 15,),)
                  ],)
                ),
              )
            ],
          ),
          )
      ) ,

    );
  }
}