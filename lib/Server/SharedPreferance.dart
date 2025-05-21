// ini adalah SharedPreferance untuk menyimpan Cache seperti token dan sebagainya
import 'package:shared_preferences/shared_preferences.dart';


Future<String> SharedToken() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  if(pref.getString("token")!= null){
    return pref.getString("token")!;
  }else{
    return "";
  }
}
