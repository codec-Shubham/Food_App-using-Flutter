import 'package:food_app3/utils/app_contants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;

  late Map<String, String>  _mainHeadres;  // Map(basically used for storing data locally) is a key value pair and both return as a string

  ApiClient({required this.appBaseUrl})
  {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 20);     // how long the request to server

    token = AppConstants.TOKEN;

    _mainHeadres = {
      'Content-type': 'application/json; charset=UTF-8',   // these are to make communication with the server and make get and post requests in the form of json as we pass(/json)
      //'Accept': 'application/json',
      'Authorization': 'Bearer $token',   // here bearer is the token type
    };
  }

  Future<Response>  getData(String uri,) async{
    try {
     Response response =  await get(uri);   // get method
     return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
    }
  }

