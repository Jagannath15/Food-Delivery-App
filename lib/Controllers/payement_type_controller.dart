import 'package:get/get.dart';

class payemnt_type extends GetxController{
  var payemnttype="".obs;
  
   onchange(var finalpaymenttype){
    payemnttype.value=finalpaymenttype;
  }
}