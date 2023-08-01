import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient{
  final Uri currrncyURL = Uri.https("free.currconv.com","/api/v7/currencies",
  {"apiKey": " 6042d4462f67428d1f54"});
//Now Lets make the function to get the curriencies list
Future<List<String>> getCurrencies() async {
http.Response res = await http.get(currrncyURL);
if(res.statusCode == 200){
  var body = jsonDecode(res.body);
  var list = body["results"];
  List<String> currencies =(list.keys).toList();
  print(currencies);
  return currencies;

}else{
  throw Exception("Failed to Connect API");


}
}
//getting exchange rate
Future<double> getRate(String from, String to) async{
  final Uri rateUrl =Uri.https('free.currconv.com','/api/v7/convert',
  {
    "apiKey": " 6042d4462f67428d1f54",
    "q":"${from}_${to}",
    "compact":"ultra"
  });
  http.Response res = await http.get(rateUrl);
  if(res.statusCode ==200){
    var body = jsonDecode(res.body);
    // ignore: unnecessary_brace_in_string_interps
    return body ("${from}_${to}");
  }else{
    throw Exception("failed to connect api.");
  }


}

  void call(String s) {}



  


}
//