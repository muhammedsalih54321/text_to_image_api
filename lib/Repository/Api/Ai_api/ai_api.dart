import 'dart:convert';



import 'package:http/http.dart';
import 'package:image_to_text_ai/Repository/Api/api_client.dart';
import 'package:image_to_text_ai/Repository/Model/ai_model.dart';



class AiApi {
  ApiClient apiClient = ApiClient();


  Future<Almodel> getAi(String text) async {
    String trendingpath = 'https://ai-text-to-image-generator-api.p.rapidapi.com/realistic';
    var body ={
    "inputs":text
};
    Response response = await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));

    return Almodel.fromJson(jsonDecode(response.body));
  }
}