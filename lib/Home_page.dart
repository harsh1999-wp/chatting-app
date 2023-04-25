import 'package:flutter/material.dart';
import 'package:medical_bot/Suggestion_box.dart';
import 'package:medical_bot/pallete.dart';
import '';

class Home_page extends StatefulWidget {

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Your Health buddy'),
        leading: Icon(Icons.menu),
      ),
      body: Column(
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
            child: const Text('Good Morning How can I help You',style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            //  fontStyle: FontStyle.italic,
              fontFamily: 'Cera Pro'
            ),),
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
              Suggestion_box(color: Pallete.firstSuggestionBoxColor, headerText: 'Chatgpt', discriptionText: 'A dev version',),
                Suggestion_box(color: Pallete.secondSuggestionBoxColor, headerText: 'headerText', discriptionText: 'discriptionText'),
                  Suggestion_box(color: Pallete.thirdSuggestionBoxColor, headerText: 'third', discriptionText: 'discriptionText'),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {  },child: Icon(Icons.mic_none_outlined),) ,
    );
  }
}
