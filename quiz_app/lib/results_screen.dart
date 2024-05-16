import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers});

  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary =[];

for(var i=0; i<chosenAnswers.length; i++){
  //loop body
  summary.add({
    'question_index': i,
    'question':questions[i].text,
    'correct_answer':questions[i].answers[0],
    'user_answer':chosenAnswers[i],
  });
}

    return summary;
  }

  @override
  Widget build(context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You answeredX out of Y question correctly'),
            SizedBox(
              height: 30,
            ),
            Text('List of answers and question ...'),
            SizedBox(
              height: 30,
            ),
            //TextButton(
            //  onPressed: () {},
            //  child: Text('Restart quiz!'),
            //),
          ],
        ),
      ),
    );
  }
}
