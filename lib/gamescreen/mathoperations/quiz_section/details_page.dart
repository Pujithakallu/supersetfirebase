import 'package:flutter/material.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/quiz_section/single_question_details.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class DetailsPage extends StatelessWidget {
  final List<Map<String, dynamic>> questionResults;
  final String questionType;
  const DetailsPage({
    Key? key,
    required this.questionResults,
    required this.questionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Adjust AppBar height
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Transparent AppBar Layer
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false, // Prevents default back button
            ),

            // Back Button (Styled as FloatingActionButton)
            Positioned(
              left: 16,
              top: 12,
              child: FloatingActionButton(
                heroTag: "backButton",
                onPressed: () => Navigator.pop(context),
                foregroundColor: Colors.black,
                backgroundColor: Colors.lightBlue,
                shape: const CircleBorder(),
                mini: true, // Smaller button
                child: const Icon(Icons.arrow_back_rounded, size: 32),
              ),
            ),

            // PIN Display (Smaller Width, Centered)
            Positioned(
              top: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6), // Reduced padding
                constraints: const BoxConstraints(
                  maxWidth:
                      120, // Limits the width to prevent it from being too wide
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(12), // Slightly rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'PIN: $userPin',
                    style: const TextStyle(
                      fontSize: 14, // Slightly smaller font for better fit
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),

            // Logout Button (Styled as FloatingActionButton)
            Positioned(
              right: 16,
              top: 12,
              child: FloatingActionButton(
                heroTag: "logoutButton",
                onPressed: () => logout(context),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                mini: true, // Smaller button
                child: const Icon(Icons.logout_rounded, size: 32),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            screenWidth * 0.05, screenWidth * 0.05, screenWidth * 0.05, 0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Mathoperations/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 160.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05),
              Text(
                'Details',
                style: TextStyle(
                    fontSize: (screenWidth / 20).clamp(16.0, 40.0),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.03),
              Expanded(
                // Makes the ListView take all the space minus AppBar and padding
                child: ListView.builder(
                  itemCount: questionResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> question = questionResults[index];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        40.0)), // Rounded corners
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxHeight: screenHeight *
                                          0.8), // Ensures the dialog doesn't take full height
                                  child: SingleQuestionPage(
                                    questionData: question,
                                    questionType: questionType,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        //onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        // builder: (context) => SingleQuestionPage(questionData: question),
                        //  ));
                        //},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              question['is_right'] ? Colors.green : Colors.red,
                          minimumSize: Size(
                              double.infinity,
                              (screenHeight * 0.08).clamp(16.0,
                                  50.0)), // Ensures the button stretches to fill the width
                          padding: EdgeInsets.symmetric(
                              vertical: (screenHeight *
                                  0.02)), // Increases button height
                        ),
                        child: Text(
                          'Question ${index + 1}',
                          style: TextStyle(
                              fontSize: (screenWidth / 20).clamp(16.0, 40.0),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
