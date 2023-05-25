import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:medical_bot/Suggestion_box.dart';
import 'package:medical_bot/openai_service.dart';
import 'package:medical_bot/pallete.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Home_page extends StatefulWidget {

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {

  final speechToText =SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  String lastWords='';
  String? generateContent;
  final openAIService =OpenAIService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeech();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async
  {
    await flutterTts.setSharedInstance(true);
    setState(() {

    });
  }

  void initSpeech() async {
    var speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    var onSpeechResult;
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  Future<void> onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async
  {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Your Health buddy'),
        leading: Icon(Icons.menu),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color:Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image:DecorationImage(image:AssetImage('assets/images/virtualAssistant.png'),),
                  ),
                ),
              ],
            ),
            // chat bubble
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 13
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                )
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child:  Text(generateContent == null ?'Good Morning How can I help You':generateContent!,style: TextStyle(
                  fontSize: generateContent == null ? 30: 18,
                  fontWeight: FontWeight.bold,
                //  fontStyle: FontStyle.italic,
                  fontFamily: 'Cera Pro'
                ),),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, left: 22),
              child: const Text('Here is are few Suggestion',
                style: TextStyle(color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //  features List
            Column(
              children: const [
                Suggestion_box(color: Pallete.firstSuggestionBoxColor, headerText: 'some health related query', discriptionText: 'A dev version',),
                  Suggestion_box(color: Pallete.secondSuggestionBoxColor, headerText: 'some suggestion', discriptionText: 'discriptionText'),
                    Suggestion_box(color: Pallete.thirdSuggestionBoxColor, headerText: 'third', discriptionText: 'discriptionText'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        if(await speechToText.hasPermission && speechToText.isNotListening){
          startListening();
        }
        else if(speechToText.isListening)  {
         final speech = await openAIService.isArtPromptAPI(lastWords);
         if(speech.contains('https')){
           generateContent =  speech;
           setState(() {

           });
           await systemSpeak(speech);
         }
         await systemSpeak(speech);
           await stopListening();
        }
        else{
          initSpeech();
        }
      },child: Icon(Icons.mic_none),) ,
    );
  }
}
