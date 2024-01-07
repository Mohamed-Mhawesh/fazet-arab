
import 'package:f_a/services/app_services.dart';
import 'package:get/get.dart';


validInput(String val, int min, int max, String type, String message) {
  AppServices appServices=Get.find();
  if (type == "invitationCode") {
    return;
  }
  if (val.isEmpty) {
    return "لا يمكن أن يكون الحقل فارغاً";
  }
  if(type=="email"){
    if(!GetUtils.isEmail(val)){
      return "البريد الذي أدخلته غير صحيح";
    }
    if(message=="this phone number is already exist"){
      return "البريد الذي أدخلته مستخدم بالفعل";
    }
  }
  if (type == "loginPhone") {
    if (message == "Phone number does not exist") {
      return "هذا البريد الإلكتروني غير موجود";
    }
  }
  if (type == "phoneToResetPassword") {
    if (message == "this phone number is valid to use") {
      return "هذا البريد الإلكتروني غير موجود";
    }
  }
  if (type == "loginPassword") {
    if (message == "Password not matched") {
      return "كلمة المرور غير صحيحة";
    }
  }
  // if (type == "verifyCode") {
  //   if (val != appServices.sharedPreferences.getString("verifyCode")) {
  //     return "الرمز غير صحيح ";
  //   }
  // }

  if (type == "confirmPassword") {
    if (val != appServices.sharedPreferences.getString("password")) {
      return "غير مطابقة لكلمة السر ";
    }
  }


  if (val.length < min) {
    return "لا يجب أن يكون أقل من $min محارف";
  }
  if (val.length > max) {
    return "لا يجب أن يكون أكثر من $max محارف";
  }
}

usernameValidInput(String val, int min, int max, String checkUsernameMessage) {
  if (val.isEmpty) {
    return "لا يمكن أن يكون الحقل فارغاً";
  }

  if (checkUsernameMessage == "this username is already exist") {
    return "هذا الاسم مستخدم ";
  }

  if (val.length < min) {
    return "لا يجب أن يكون أقل من $min محارف";
  }
  if (val.length > max) {
    return "لا يجب أن يكون أكثر من $max محارف";
  }
}

phoneValidInput(String val, int min, int max, String checkPhoneMessage) {
  if (val.isEmpty) {
    return "لا يمكن أن يكون الحقل فارغاً";
  }

  if (checkPhoneMessage == "this phone number is already exist") {
    return "هذا الرقم مستخدم";
  }

  if (val.length < min) {
    return "لا يجب أن يكون أقل من $min محارف";
  }
  if (val.length > max) {
    return "لا يجب أن يكون أكثر من $max محارف";
  }
}
