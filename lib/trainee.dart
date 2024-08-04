import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'traineeExercisePage.dart';
import 'traineeWeightLossPage.dart';
import 'traineeWeightGainPage.dart';
import 'traineeSnacksPage.dart';
import 'traineeCoachesPage.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'NormalLoginPage.dart';

//i want to see if a trainee when he logged in and navigate to HomePage to
// check if the trainee id is not in table registeredcoach (rcID,userID,coachID,date(timestamp) )
final EncryptedSharedPreferences _encryptedData= EncryptedSharedPreferences();

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final List<String> photoPaths = ['bi_.jpg', 'test.jpg', 'deadlift.jpg', 'legs.jpg'];
  final List<String> secondPhotoPaths = ['tpose1.jpg', 'treepose8.jpg', 'warriorpose.jpg'];
  final List<String> thirdPhotoPaths = ['weightgain.jpg', 'weightloss.jpg', 'snacks.jpg'];
  final String coachesBackground = 'coaches.jpg';
  final String anotherButtonBackground = 'detected.jpg';
  String name="";
//ss
  // Add descriptions for each exercise
  final List<String> exerciseDescriptions = [
    'Shoulder-width stance, palms forward, curl dumbbells to shoulders, elbows tight. Lower with control, repeat.',
    'Stand, dumbbells at sides, palms inward. Lift arms parallel, engage shoulders. Lower slowly.',
    'Feet hip-width, grip barbell, hinge at hips, lower. Push through heels, stand tall, squeeze glutes.',
    'Feet shoulder-width, barbell on upper back. Bend knees, keep chest up, descend. Drive through heels to stand.',
    'Stand tall, arms to sides, extend to T-shape, palms down. Engage core, lengthen spine, hold, release.',
    'Start standing, feet together. Shift weight, bend knee, foot to inner thigh or calf. Hands at heart or overhead.',
    'Wide stance, arms parallel, turn right foot out, bend knee. Hold, gaze over hand. Switch sides.',
  ];
@override
  void initState(){
    // TODO: implement initState
    super.initState();
   setName();
  }
  void setName(){
    Future.delayed(const Duration(seconds: 1), () async{
      String temp=await _encryptedData.getString('name');
      setState((){
        name=temp;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            _encryptedData.remove('traineeID');
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NormalLoginPage()));
          }, icon: Icon(Icons.logout)),
        ],
        title: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 250,
                child: CarouselSlider(
                  items: ['Biceps', 'Shoulders', 'Back', 'Legs'].asMap().entries.map((entry) {
                    final int index = entry.key;
                    final String part = entry.value;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExercisePage(
                              photoPath: 'assets/${photoPaths[index]}',
                              description: exerciseDescriptions[index],
                              exerciseName: part,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/${photoPaths[index]}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            part,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    height: 200,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 250,
                child: CarouselSlider(
                  items: ['Tpose', 'Treepose', 'Warrior2 pose'].asMap().entries.map((entry) {
                    final int index = entry.key;
                    final String item = entry.value;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExercisePage(
                              photoPath: 'assets/${secondPhotoPaths[index]}',
                              description: exerciseDescriptions[4 + index],
                              exerciseName: item,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/${secondPhotoPaths[index]}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    height: 200,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 250,
                child: CarouselSlider(
                  items: ['Weight Gain', 'Weight Loss', 'Snacks'].asMap().entries.map((entry) {
                    final int index = entry.key;
                    final String item = entry.value;
                    return GestureDetector(
                      onTap: () {
                        if (item == 'Weight Loss') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WeightLossPage()),
                          );
                        } else if (item == 'Weight Gain') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WeightGainPage()),
                          );
                        } else if (item == 'Snacks') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SnacksPage()),
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/${thirdPhotoPaths[index]}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    height: 200,
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  print('Coaches');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoachesPage()),
                  );
                },
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/$coachesBackground'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Coaches',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  print('Activity Log');
                },
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/$anotherButtonBackground'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Activity Log',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
