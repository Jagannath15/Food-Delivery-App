
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/Screens/details.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/Screens/cart.dart';
import 'package:food_delivery_app/Screens/setting.dart';
import 'package:food_delivery_app/Widgets/recommended_items.dart';
import 'package:food_delivery_app/Widgets/topcategories.dart';
import 'package:food_delivery_app/main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String ?mobno;
  int currentindex=0;

  final Screens=[
    Homepage(),
    CartPage(),
    SettingPage()
  ];

  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xfff6f5f8),
  
      body: Screens[currentindex],
      
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xfff6f5f8),
        color: Color(0xff1f1f1f),
        height: 48,
        index: currentindex,
        onTap: (index)=>setState(() {
          currentindex=index;
        }),
        items: [
          Icon(Icons.home,color: Colors.white,),
          Icon(Icons.shopping_cart_checkout,color: Colors.white),
          Icon(Icons.settings,color: Colors.white),
        ]
        
      ),
      );
  }
}


//--------------------------HomePage-------------------------------------------------------------------------------------------
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
    final CollectionReference _products =
      FirebaseFirestore.instance.collection('foods');

      final CollectionReference _specials =
      FirebaseFirestore.instance.collection('specials');

    

      final CollectionReference _noofitems=FirebaseFirestore.instance.collection("add_to_cart").doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection("items");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
           child: SingleChildScrollView(child: Column(
            children: [
             Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff1f1f1f),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18),bottomRight: Radius.circular(18))
              ),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(      
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text("Eat and Greet",style: TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.bold))),   
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                      InkWell(
                        onTap: () => Get.to(CartPage()),
                        child: Container(
                          height: 30,
                          width: 60,             
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xffccff01),
                            borderRadius: BorderRadius.circular(9),
                          ),
                            child: Center(
                              child: StreamBuilder(
                                 stream: FirebaseFirestore.instance.collection("add_to_cart").doc(FirebaseAuth.instance.currentUser!.phoneNumber).collection("items").snapshots(),
                                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                  if(streamSnapshot.hasData){
                                    return Row(
                                children: [
                                SizedBox(width: 11,),
                                Icon(Icons.shopify_rounded,),
                                SizedBox(width: 2,),
                                Text(streamSnapshot.data!.docs.length.toString())
                              ],);
                                  }
                                  return Row(
                                children: [
                                SizedBox(width: 11,),
                                Icon(Icons.shopify_rounded,),
                                SizedBox(width: 2,),
                                Text("0")
                              ],);
                                },)
                      
                            ),
                        ),
                      ),
                    ],
                  ), 
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 5),
                          child: TextField(
                            cursorColor: Color(0xff969696),
                            style: TextStyle(color: Color(0xff969696)),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search,size: 30,color: Color(0xff969696),),
                              filled: true,
                              fillColor: Color(0xff393939),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              hintText: "Search Something for Tasty...",
                              hintStyle: TextStyle(color: Color(0xff969696)),
                               )         
                    ),
                        ),             
                ],
              ),
             ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("Top Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  InkWell(
                    child: Row(
                      children: [
                        Text("View all",style: TextStyle(fontSize: 13,color: Color(0xff969696)),),
                        Icon(Icons.arrow_forward,size: 18,color: Color(0xff969696),)
                      ],
                    )                  )
                ],
              ),
            ),
          SizedBox(height: 10,),
           Container(
           height: 45,
          margin: EdgeInsets.all(5),
             child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,             
              children: [
              Topcategories("Burger","assets/icons/burger.png"),
              Topcategories("Pizza","assets/icons/pizza.png"),
              Topcategories("Sandwich","assets/icons/sandwich.png"),
              Topcategories("Chicken","assets/icons/chicken.png"),
              Topcategories("Wrap","assets/icons/wrap.png"),
              Topcategories("Veg Salad","assets/icons/vegsalad.png"),
              Topcategories("Desert","assets/icons/desert.png"),             
              ],
             ),
           ),
   
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                children: [
                  Text("Recommended for You",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  InkWell(
                    child: Row(
                      children: [
                        Text("View all",style: TextStyle(fontSize: 13,color: Color(0xff969696)),),
                        Icon(Icons.arrow_forward,size: 18,color: Color(0xff969696),)
                      ],
                    )                  )
                ],
              ),
            ),
                  
          Container(
            height: 200,
            
            child: StreamBuilder(
              stream: _products.snapshots(),
              builder:  (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(documentSnapshot: documentSnapshot)));
                    },
                    child: Container(
                      height: 190,
                      width: 160,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                              height: 150,
                              width: 170,
                              color: Colors.transparent,
                              child: Image.network(documentSnapshot['imageUrl']),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text(documentSnapshot['name']),
                                Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Text(documentSnapshot['Price'])
                        ],
                      ),
                        ]
                    ),
                    ),
                  );

                  },
                  );
                }
              return Center(child: CircularProgressIndicator(color: Colors.black12,));
            }),
          ),

        SizedBox(height: 5,),

          Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                children: [
                  Text("Eat & Greet specials",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  InkWell(
                    child: Row(
                      children: [
                        Text("View all",style: TextStyle(fontSize: 13,color: Color(0xff969696)),),
                        Icon(Icons.arrow_forward,size: 18,color: Color(0xff969696),)
                      ],
                    )                  ),  
                ],
              ),
          ),



          Container(
            height: 200,
            
            child: StreamBuilder(
              stream: _specials.snapshots(),
              builder:  (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(documentSnapshot: documentSnapshot)));
                    },
                    child: Container(
                      height: 190,
                      width: 160,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                              height: 150,
                              width: 170,
                              color: Colors.transparent,
                              child: Image.network(documentSnapshot['imageUrl']),
                            ),
                            SizedBox(height: 10,),
                            Wrap(
                              children:[Row(
                                children: [
                                  Text(documentSnapshot['name'],textDirection: TextDirection.ltr),
                                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                                  Text(documentSnapshot['Price'])
                                                    ],
                                                  ),]
                            ),
                        ]
                    ),
                    ),
                  );

                  },
                  );
                }
              return Center(child: CircularProgressIndicator(color: Colors.black12,));
            }),
          ),
            ],
                 ),
                 ),      
               
         ), 
    );
  }
}