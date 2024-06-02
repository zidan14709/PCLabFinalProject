import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key,});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int quizNumber = 1;
  int questionIndex = 0;
  int score = 0;
  bool isAnswered = false;

  String selectedCategory = "General Knowledge"; // Default category

  int quizTimeInSeconds = 15; // 15 seconds
  int timeRemaining = 15; // Initially set to quiz time

  List<String> categories = ["General Knowledge", "Science", "History"];
  Map<String, List<String>> categoryQuestions = {
    "General Knowledge": [
      'What is the capital of France?',
      'Who painted the Mona Lisa?',
      'What is the largest planet in our solar system?',
      'How many continents are there in the world?',
      'What is the largest mammal?',
    ],
    "Science": [
      'What is the largest planet in our solar system?',
      'Which gas do plants absorb from the atmosphere?',
      'What is the powerhouse of the cell?',
      'Who developed the theory of relativity?',
      'What is the chemical symbol for water?',
    ],
    "History": [
      'In which year did Christopher Columbus discover America?',
      'Who is known as the "Father of Modern Physics"?',
      'Who was the first President of the United States?',
      'When did World War II end?',
      'Who wrote "Romeo and Juliet"?',
    ],
  };

  Map<String, List<List<String>>> categoryOptions = {
    "General Knowledge": [
      ['Paris', 'London', 'Madrid', 'Rome'],
      [
        'Leonardo da Vinci',
        'Pablo Picasso',
        'Vincent van Gogh',
        'Claude Monet'
      ],
      ['Saturn', 'Mars', 'Earth', 'Jupiter'],
      ['5', '6', '7', '8'],
      ['Elephant', 'Giraffe', 'Blue Whale', 'Hippopotamus'],
    ],
    "Science": [
      ['Jupiter', 'Mars', 'Earth', 'Saturn'],
      ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
      ['Mitochondria', 'Nucleus', 'Ribosome', 'Endoplasmic Reticulum'],
      ['Albert Einstein', 'Isaac Newton', 'Galileo Galilei', 'Niels Bohr'],
      ['H2O', 'CO2', 'O2', 'N2'],
    ],
    "History": [
      ['1492', '1607', '1776', '1789'],
      ['Albert Einstein', 'Isaac Newton', 'Galileo Galilei', 'Niels Bohr'],
      ['George Washington', 'John Adams', 'Thomas Jefferson', 'James Madison'],
      ['1945', '1940', '1949', '1939'],
      ['William Shakespeare', 'Jane Austen', 'Charles Dickens', 'Mark Twain'],
    ],
  };

  Map<String, List<String>> categoryCorrectAnswers = {
    "General Knowledge": [
      'Paris',
      'Leonardo da Vinci',
      'Jupiter',
      '7',
      'Blue Whale',
    ],
    "Science": [
      'Jupiter',
      'Carbon Dioxide',
      'Mitochondria',
      'Albert Einstein',
      'H2O',
    ],
    "History": [
      '1492',
      'Albert Einstein',
      'George Washington',
      '1945',
      'William Shakespeare',
    ],
  };

  List<String> questions = [];
  List<List<String>> options = [];
  List<String> correctAnswers = [];
  List<String> selectedAnswers = [];

  void shuffleQuestionsAndOptions() {
    final random = Random();
    for (var i = questions.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);

      // Swap questions
      final tempQuestion = questions[i];
      questions[i] = questions[j];
      questions[j] = tempQuestion;

      // Swap options
      final tempOptions = options[i];
      options[i] = options[j];
      options[j] = tempOptions;

      // Swap correct answers
      final tempAnswer = correctAnswers[i];
      correctAnswers[i] = correctAnswers[j];
      correctAnswers[j] = tempAnswer;
    }
  }

  void initializeQuestions() {
    questions = categoryQuestions[selectedCategory]!;
    options = categoryOptions[selectedCategory]!;
    correctAnswers = categoryCorrectAnswers[selectedCategory]!;
  }

  @override
  void initState() {
    super.initState();
    initializeQuestions();
    shuffleQuestionsAndOptions();
    startQuizTimer();
  }

  void handleAnswer(bool isCorrect) {
    if (isCorrect) {
      setState(() {
        score++;
      });
    }
    setState(() {
      isAnswered = true;
    });
  }

  void handleNextQuestion() {
    if (questionIndex < categoryQuestions[selectedCategory]!.length - 1) {
      setState(() {
        questionIndex++;
        isAnswered = false;
      });
    } else {
      showResults();
    }
  }

  void showResults() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Results'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Score: $score/${categoryQuestions[selectedCategory]!.length}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  score = 0;
                  quizNumber++;
                  questionIndex = 0;
                  timeRemaining = quizTimeInSeconds;
                  isAnswered = false;
                });
                Navigator.pop(context);
              },
              child: Text('Restart Quiz'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        );
      },
    );
  }

  void handleQuizTime(int seconds) {
    if (seconds == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Time\'s Up!'),
            content: Text('You ran out of time.'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    timeRemaining = quizTimeInSeconds;
                  });
                  Navigator.pop(context);
                },
                child: Text('Restart Quiz'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go Back'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        timeRemaining = seconds;
      });
    }
  }

  void checkAnswer(String selectedOption) {
    if (isAnswered) {
      return; // Prevent multiple answer selections
    }

    String correctAnswer = correctAnswers[questionIndex];
    bool isCorrect = selectedOption == correctAnswer;

    setState(() {
      selectedAnswers.add(selectedOption);
      isAnswered = true;

      if (isCorrect) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (questionIndex < questions.length - 1) {
          questionIndex++;
          isAnswered = false;
          timeRemaining =
              quizTimeInSeconds; // Reset timer for the next question
        } else {
          // Quiz completed, perform any desired actions
          timeRemaining = quizTimeInSeconds; // Reset timer for the next quiz
          shuffleQuestionsAndOptions(); // Shuffle questions and options for the next quiz
        }
      });
    });
  }

  void startQuizTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (timeRemaining > 0) {
          timeRemaining--;
          startQuizTimer(); // Recursively call to update the timer
        } else {
          // Time's up, perform any desired actions here
          timeRemaining =
              quizTimeInSeconds; // Reset the timer for the next quiz
          shuffleQuestionsAndOptions(); // Shuffle questions and options for the next quiz
          // You can add actions to proceed to the next question or end the quiz
          // based on your requirements when the time is up.
        }
      });
    });
  }

  void shareScore() {
    String message =
        'I scored $score out of ${questions.length} in the quiz app!';
    Share.share(message);
  }

  void resetQuiz() {
    setState(() {
      selectedAnswers.clear();
      questionIndex = 0;
      quizNumber++;
      score = 0;
      isAnswered = false;
      timeRemaining = quizTimeInSeconds; // Reset timer for the next quiz
      shuffleQuestionsAndOptions(); // Shuffle questions and options for the next quiz
    });
  }

  String getQuizResult() {
    if (score >= 3) {
      return "Pass";
    } else {
      return "Fail";
    }
  }

  Color getResultColor() {
    if (score >= 3) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    String result = getQuizResult();
    Color resultColor = getResultColor();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz App',
          style: TextStyle(
            color: Colors.black, // Black text color for AppBar title
            fontSize: 24, // Change the font size of the AppBar title
            fontFamily: 'Roboto', // Change the font family of the AppBar title
            fontWeight: FontWeight.bold, // Add font weight to AppBar title
          ),
        ),
        backgroundColor: Colors.blueGrey[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Quiz #$quizNumber',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black, // Black text color
                fontFamily: 'Roboto', // Change the font family
                fontWeight: FontWeight.bold, // Add font weight
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Category: $selectedCategory',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black, // Black text color
                fontFamily: 'Roboto', // Change the font family
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Question ${questionIndex + 1}/${questions.length}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black, // Black text color
                fontFamily: 'Roboto', // Change the font family
              ),
            ),
            const SizedBox(height: 20),
            Text(
              questions[questionIndex],
              style: TextStyle(
                fontSize: 18,
                color: Colors.black, // Black text color
                fontFamily: 'Roboto', // Change the font family
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: options[questionIndex]
                  .map(
                    (option) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[200], // Change the button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Black text color for options
                        fontFamily: 'Roboto', // Change the font family
                      ),
                    ),
                    onPressed: isAnswered
                        ? null
                        : () => checkAnswer(option),
                    child: Text(
                      option,
                      style: TextStyle(
                        color: isAnswered
                            ? (option == correctAnswers[questionIndex]
                            ? Colors.green
                            : (option ==
                            selectedAnswers[questionIndex]
                            ? Colors.red
                            : Colors.black))
                            : Colors.black, // Change text color for options
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
            const SizedBox(height: 20),
            if (isAnswered)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[400], // Change the button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Black text color for buttons
                    fontFamily: 'Roboto', // Change the font family
                  ),
                ),
                onPressed: handleNextQuestion,
                child: const Text('Next Question'),
              ),
            const SizedBox(height: 20),
            Text(
              'Time Remaining: $timeRemaining seconds',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red, // Red text color for timer
                fontFamily: 'Roboto', // Change the font family
                fontWeight: FontWeight.bold, // Add font weight to timer
              ),
            ),
            const SizedBox(height: 20),
            if (questionIndex == questions.length - 1)
              Column(
                children: [
                  Text(
                    'Quiz Result: $result',
                    style: TextStyle(
                      fontSize: 20,
                      color: resultColor, // Change text color based on result
                      fontFamily: 'Roboto', // Change the font family
                      fontWeight: FontWeight.bold, // Add font weight to result
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[400], // Change the button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Black text color for buttons
                        fontFamily: 'Roboto', // Change the font family
                      ),
                    ),
                    onPressed: shareScore,
                    child: const Text('Share Score'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[400], // Change the button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Black text color for buttons
                        fontFamily: 'Roboto', // Change the font family
                      ),
                    ),
                    onPressed: resetQuiz,
                    child: const Text('Restart Quiz'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
