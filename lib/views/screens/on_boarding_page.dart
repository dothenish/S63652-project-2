/*=====================================================
* Program: on_boarding_page.dart
* Purpose: Introduction to user regarding the app key features & user engagement (Visually appealing)
* Notes: 
*======================================================
*/
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart'; //fluid page transaction
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // indicator at bottom of the screen
import 'package:google_fonts/google_fonts.dart';


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = LiquidController(); //control liquid swipe widget
  int currentPage = 0;

    //callback function triggered when  user swipes
    void onPageChangedCallback(int activePageIndex) {
    setState(() { //update state
      currentPage = activePageIndex; //current page is updated align with the current active page in lqd swipe wdgt
    });
    
  }
    // navigate to homepage
    void navigateToLoginPage() {
      Navigator.pushReplacementNamed(context, '/loginpage');
    }


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      alignment: Alignment.center,
      children: [
        LiquidSwipe(
          // Making on boarding screen into 3 pages
          pages: [

            //Page 1
            Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.purple[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/on-boarding/attendance_onboarding.png",
                  width: 250,
                  ),
                  const SizedBox(height: 50),
                  Column(
                    children: [
                      Text("Digitalize Students \n& Teacher\'s details",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 27.0,
                        color: Colors.black
                        )),
                        const SizedBox(height: 30),
                        Text(
                          "Effortlessly digitize student & teacher details with \nour app, ensuring accurate and efficient record-keeping for a more streamlined school \nexperience.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                          fontSize: 16.0,
                          color: Colors.black,
                        )),
                        const SizedBox(height: 50.0)
                      ],
                    ),
                  ],
                ),
              ),

              //Page 2
              Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/on-boarding/discipline_onboarding.png",
                    width: 270,
                    ),
                    Column(
                      children: [
                        Text("Track Student Discipline Records",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 27.0,
                          color: Colors.black
                        ),),
                        const SizedBox(height: 30),
                        Text(
                          "Stay in control of student behavior by effortlessly tracking and managing discipline records, \nfostering a positive and conducive learning environment.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),),
                        const SizedBox(height: 50.0)
                      ],
                    ),
                  ],
                ),
              ),

              //Page 3
              Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.purple[100],
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/on-boarding/result_onboarding.png",
                        width: 300,
                        ),
                        const SizedBox(height: 50),
                        Column(
                          children: [
                            Text("Streamline Everyday School Workflows",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: 27.0,
                              color: Colors.black
                            ),),
                            const SizedBox(height: 30),
                            Text(
                              "Experience the ease of streamlined everyday school workflows as our app simplifies administrative \ntasks, empowering educators to focus on what matters most – student success.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),),
                            const SizedBox(height: 50.0)
                          ],
                        ),
                      ],
                    ),
                    if (currentPage == 2) //Page 3
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0), 
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, 
                              vertical: 16.0),
                              minimumSize: const Size(200.0, 40.0),
                            ),
                            onPressed: navigateToLoginPage,
                            child: Text("Get Started",
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            //Arrow to swipe through screen
            liquidController: controller,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
            onPageChangeCallback: onPageChangedCallback,
            ),
            
            //"skip" button
            Positioned(
              bottom: 50,
              child: currentPage == 0 || currentPage == 1
                  ? TextButton(
                      onPressed: () => controller.jumpToPage(page: 2),
                      child: Text(
                        "Skip", 
                        style: GoogleFonts.nunito(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : const SizedBox(), // show nothing
            ),

            //the dots at the bottom when swiping
            //active index must have controller
            Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                activeIndex: controller.currentPage,
                count: 3,
                effect: const WormEffect(
                  activeDotColor: Color(0xff272727),
                  dotHeight: 5.0
                ),
              )
            )
          ],
        ),
      );
    }
  }



