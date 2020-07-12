import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz_covid19/components/centered_circular_progress.dart';
import 'package:quiz_covid19/components/centered_message.dart';
import 'package:quiz_covid19/components/question_container.dart';
import 'package:quiz_covid19/components/answer_container.dart';
import 'package:quiz_covid19/components/finish_dialog.dart';
import 'package:quiz_covid19/components/result_dialog.dart';
import 'package:quiz_covid19/controllers/quiz_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _controller = QuizController();
  List<Widget> _scoreKeeper = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _controller.initialize();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('QUIZ POKEMON ( ${_scoreKeeper.length}/20 )'),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildQuiz(),
        ),
      ),
    );
  }

  _buildQuiz() {
    if (_loading) return CenteredCircularProgress();

    if (_controller.questionsNumber == 0)
      return CenteredMessage(
        'Sem questões',
        icon: FontAwesomeIcons.exclamationCircle,
      );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        QuizQuestion(question: _controller.getQuestion()),
        QuizAnswer(answer: _controller.getAnswer1(), onTap: () {
            bool correct = _controller.correctAnswer(_controller.getAnswer1());

            ResultDialog.show(
              context,
              question: _controller.question,
              correct: correct,
              onNext: () {
                setState(() {
                  _scoreKeeper.add(
                    Icon(
                      correct ? FontAwesomeIcons.checkCircle : FontAwesomeIcons.timesCircle,
                      color: correct ? Colors.green : Colors.red,
                    ),
                  );

                  if (_scoreKeeper.length < 20) {
                    _controller.nextQuestion();
                  } else {
                    FinishDialog.show(
                      context,
                      hitNumber: _controller.hitNumber,
                    );
                  }
                });
              },
            );
          }),
        QuizAnswer(answer: _controller.getAnswer2(), onTap: () {
            bool correct = _controller.correctAnswer(_controller.getAnswer2());

            ResultDialog.show(
              context,
              question: _controller.question,
              correct: correct,
              onNext: () {
                setState(() {
                  _scoreKeeper.add(
                    Icon(
                      correct ? FontAwesomeIcons.checkCircle : FontAwesomeIcons.timesCircle,
                      color: correct ? Colors.green : Colors.red,
                    ),
                  );

                  if (_scoreKeeper.length < 20) {
                    _controller.nextQuestion();
                  } else {
                    FinishDialog.show(
                      context,
                      hitNumber: _controller.hitNumber,
                    );
                  }
                });
              },
            );
          }),
        _buildScoreKeeper(),
      ],
    );
  }

  _buildScoreKeeper() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _scoreKeeper,
      ),
    );
  }
}
