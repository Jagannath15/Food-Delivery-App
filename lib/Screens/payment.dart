
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/Screens/cart.dart';
import 'package:get/get.dart';
import '../Controllers/billing_page_controller.dart';
import '../Controllers/payement_type_controller.dart';

class Billing extends StatelessWidget {
  final total;
  
  Billing({Key? key, required this.total}) : super(key: key);

  final Billingcontroller b = Get.put(Billingcontroller());
  final payemnt_type pt=Get.put(payemnt_type());
  @override
  Widget build(BuildContext context) {
   
    

    TextEditingController fname = TextEditingController();
    TextEditingController lname = TextEditingController();
    TextEditingController addrs = TextEditingController();
    TextEditingController lnd = TextEditingController();
    TextEditingController city = TextEditingController();
    TextEditingController pincode = TextEditingController();


    List<Step> steps() {
      return [
        Step(
            title: Text("Personal Information"),
            content: Column(
              children: [
                TextField(
                  controller: fname,
                  decoration: InputDecoration(
                    hintText: "Enter First Name",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: lname,
                  decoration: InputDecoration(
                    hintText: "Enter Last Name",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
            isActive: b.currentStep >= 0,
            state: b.currentStep.value > 0
                ? StepState.complete
                : StepState.indexed),
        Step(
            
            title: Text("Address"),
            content: Column(
              children: [
                TextField(
                  controller: addrs,
                  decoration: InputDecoration(
                    hintText: "Enter the address to get delivery",
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: lnd,
                  decoration: InputDecoration(
                    hintText: "Enter nearest Landmark",
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: pincode,
                  decoration: InputDecoration(
                    hintText: "Enter Pin-Code",
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: city,
                  decoration: InputDecoration(
                    hintText: "Enter City",
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            isActive: b.currentStep.value >= 1,
            state: b.currentStep.value > 1
                ? StepState.complete
                : StepState.indexed),
        Step(
          title: Text("Payemnt"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Amount to be paid ₹"+total),
                 Row(
                children: [
                  Obx(
                    ()=>Radio(
                        value: "Cash on delivery",
                        groupValue: pt.payemnttype.value,
                        onChanged: (value) {pt.onchange(value);},
                        activeColor: Colors.black,
                        fillColor: MaterialStateProperty.all(Colors.black),
                        ),
                  ),
                  Text("Cash on Delivery"),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Container(
                    height: 35,
                    width: 35,
                    color: Colors.transparent,
                    child: Image.asset("assets/cash.png")
                    
                  )
                ],
              ),

               Row(
                children: [
                  Obx(
                    ()=> Radio(
                        value: "Google Pay",
                        groupValue:pt.payemnttype.value,
                        onChanged: (value) {pt.onchange(value);},
                        activeColor: Colors.black,
                        fillColor: MaterialStateProperty.all(Colors.black),
                        ),
                  ),
                  Text("Google Pay"),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Container(
                    height: 35,
                    width: 35,
                    color: Colors.transparent,
                    child: Image.asset("assets/google-pay-logo.png")
                    
                  )
                ],
              ),

               Row(
                children: [
                  Obx(
                    ()=> Radio(
                        value: "Phone Pe/ Patym",
                        groupValue: pt.payemnttype.value,
                        onChanged: (value) {pt.onchange(value);},
                        activeColor: Colors.black,
                        fillColor: MaterialStateProperty.all(Colors.black),
                        ),
                  ),
                  Text("PhonePe/Patym"),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Container(
                    height: 35,
                    width: 35,
                    color: Colors.transparent,
                    child: Image.asset("assets/PhonePe_Logo.png")
                    
                  )
                ],
              ),


               Row(
                children: [
                  Obx(()=>
                      Radio(
                        value: "Credit / Debit card",
                        groupValue: pt.payemnttype.value,
                        onChanged: (value) {pt.onchange(value);},
                        activeColor: Colors.black,
                        fillColor: MaterialStateProperty.all(Colors.black),
                        ),
                  ),
                  Text("Credit/Debit card"),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Container(
                    height: 35,
                    width: 45,
                    color: Colors.transparent,
                    child: Image.asset("assets/visa.jpg")
                    
                  )
                ],
              )
            ],
          ),
          isActive: b.currentStep.value >= 2,
        )
      ];
    }




    return Scaffold(
     
      appBar: AppBar(
        title: Text("Confirm Order",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){()=>Get.to(CartPage());}, icon: Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.black,
              ), ),
        child: SingleChildScrollView(
            child: Obx(() => Stepper(
                
                type: StepperType.vertical,
                
                currentStep: b.currentStep.value,
                steps: steps(),
                onStepContinue: () {
                  if (b.currentStep.value == 2) {
                    Get.snackbar("Succes", "suceess");
                  } else {
                    b.currentStep.value++;
                  }
                },
                physics: BouncingScrollPhysics(),
                onStepCancel: () {
                  b.currentStep.value == 0 ? null : b.currentStep.value--;
                },
                onStepTapped: (index) {
                  b.currentStep.value = index;
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails controls) {
                  return Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: Text(b.currentStep.value == steps().length - 1
                                ? "Submit"
                                : "Next"),
                            onPressed: controls.onStepContinue,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        if (b.currentStep.value != 0)
                          Expanded(
                            child: ElevatedButton(
                              child: const Text("Previous"),
                              onPressed: controls.onStepCancel,
                            ),
                          ),
                      ],
                    ),
                  );
                }))),
      ),
    );
  }
}
