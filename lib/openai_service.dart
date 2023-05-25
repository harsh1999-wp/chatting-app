import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medical_bot/Secrets.dart';
class OpenAIService{
  final List<Map<String ,String>> messages = [];
  Future<String> isArtPromptAPI(String prompt)async{
       try{
          final res =await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
            headers: {
            'Content-Type': 'application/json'
            'Authorization'  'Bearer $OpenAIApikey',
          },
          body: jsonEncode({
            "model" :"gpt-3.5-turbo",
            "messages": [{"role": "user", "content": 'Does this message want to generate an AI picture , art ,or anything similar? $prompt .Simply answer with yes or not'}]
          }),
          );
          print('res.body');
          if(res.statusCode == 200){
                String content =  jsonDecode(res.body)["choices"][0]['message']['content'];
                content =content.trim();

                switch(content){
                  case 'YES':
                  case 'yes':
                  case 'yes.':
                  case 'YES.':

                  final res = await DallEAPI(prompt);
                  return res;
                  default:
                    final res= await chatgptAPI(prompt);
                    return res;
                }
          }
          return 'An Internal Error';
       }
       catch(e){
     return e.toString();
    }
  }

  Future<String> chatgptAPI(String prompt)async{
    messages.add({
      'role': 'user',
      'content' : prompt,
    });
    try{
      final res =await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json'
              'Authorization'  'Bearer $OpenAIApikey',
        },
        body: jsonEncode({
          "model" :"gpt-3.5-turbo",
          "messages": messages,}
      ));
      if(res.statusCode == 200){
        String content =  jsonDecode(res.body)["choices"][0]['message']['content'];
        content =content.trim();

        messages.add({
          'role': 'assistant',
          'content' : content,
        });
        return content;
      }
      return 'An Internal Error';
    }
    catch(e){
      return e.toString();
    }
  }
  Future<String> DallEAPI(String promt)async{
   return "DALL_-E";
  }
}