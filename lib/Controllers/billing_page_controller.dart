import 'package:get/get.dart';

class Billingcontroller extends GetxController{
  var currentStep=0.obs;
  RxString total="".obs;

  void increment(){
    currentStep++;
  }
}