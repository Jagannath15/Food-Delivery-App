import 'package:get/get.dart';

class DetailController extends GetxController{
  var quantity=0.obs;

  increment(){
    quantity++;
  }

  decrement(){
    if(quantity<=0){
      Get.snackbar("Quantity can not be zero", "Please enter valid quantity");

    }
    else{
      quantity--;
    }
  }
}