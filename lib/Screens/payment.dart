import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../Controllers/billing_page_controller.dart';

class Billing extends StatelessWidget {
   Billing({Key? key}) : super(key: key);

  final Billingcontroller b=Get.put(Billingcontroller());
  @override
  Widget build(BuildContext context) {

    


    TextEditingController fname=TextEditingController();
    TextEditingController lname=TextEditingController();
    TextEditingController addrs=TextEditingController();
    TextEditingController lnd=TextEditingController();
    TextEditingController city=TextEditingController();
    TextEditingController pincode=TextEditingController();
   

   List payemnt_type=["Cash on Delivery","Google Pay","Phone Pe/Patym","Debit/Credit Card"];

    List<Step> steps(){
      return [
        Step(title: Text("Personal Information"), content: Column(
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
          SizedBox(height: 10,),
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
        isActive: b.currentStep>=0,
        state: b.currentStep.value>0?StepState.complete:StepState.indexed
        ),



        Step(title: Text("Address"), content:Column(
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
            SizedBox(height: 10,),
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
            SizedBox(height: 10,), TextField(
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
            SizedBox(height: 10,),
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
            SizedBox(height: 10,)
            
          ],
        ),
        isActive: b.currentStep.value>=1,
        state: b.currentStep.value>1?StepState.complete:StepState.indexed
        ),

        Step(title: Text("payemnt"), content:Column(
          children: [
            ListView.builder(
              itemCount: payemnt_type.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return Text(payemnt_type[index]);
              }
              
              )
          ],
        ),
        isActive: b.currentStep.value>=2,
        )
      ];
    }
  
      

    return Scaffold(
      body: SingleChildScrollView(
        child:Obx(() =>  Stepper(
               type: StepperType.vertical,
               currentStep: b.currentStep.value,
              steps: steps( ),
              onStepContinue: (){
                  if(b.currentStep.value==2){
                    Get.snackbar("Succes", "suceess");
                  }
                  else{
                    b.currentStep.value++;
                  }   
              },
              onStepCancel: (){
                b.currentStep.value==0?null:b.currentStep.value--;
              },
              onStepTapped: (index){
                b.currentStep.value=index;
              }, 
             controlsBuilder: (BuildContext context, ControlsDetails controls) {
              return Container(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(b.currentStep.value==steps().length-1?"Submit":"Next"),
                        onPressed: controls.onStepContinue ,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    if(b.currentStep.value!=0)
                      Expanded(
                        child: ElevatedButton(
                          child: const Text("Previous"),
                          onPressed: controls.onStepCancel,
                        ),
                      ),
                  ],
                ),
              );
            }
          )
        )
      ),
    );
  }
}