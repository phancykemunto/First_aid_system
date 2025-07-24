import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const FirstAidApp());
}

class FirstAidApp extends StatelessWidget {
  const FirstAidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Take a Breathe. You have Got This.',
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // Start with Login screen
    );
  }
}

// ------------------ LOGIN SCREEN ------------------ //

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String email = _emailController.text;
      String password = _passwordController.text;

      String correctEmail = "test@example.com";
      String correctPassword = "123456";

      await Future.delayed(const Duration(seconds: 2)); // Simulate a delay

      if (email == correctEmail && password == correctPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Welcome to First Aid App',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator(color: Colors.white))
                          : const Text("Login"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------ FIRST AID TOPIC MODEL ------------------ //

class FirstAidTopic {
  final String title;
  final String imagePath;
  final List<String> steps;
  final List<String>? stepImages;

  const FirstAidTopic({
    required this.title,
    required this.imagePath,
    required this.steps,
    this.stepImages,
  });
}

// ------------------ HOME PAGE ------------------ //
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<FirstAidTopic> topics = const [
    FirstAidTopic(
      title: 'Nose Bleeding',
      imagePath: 'assets/images/Nose_bleeding.jpeg',
      steps: [
        'Sit the person down and lean them slightly forward.',
        'Pinch the soft part of the nose together.',
        'Hold for 10 minutes while breathing through the mouth.',
        'Do not tilt the head backward.',
        'Seek help if bleeding doesn’t stop after 20 minutes.',
      ],
    ),
    FirstAidTopic(
      title: 'Cardiopulmonary Resuscitation (CPR)',
      imagePath: 'assets/images/CPR.jpeg',
      steps: [
        'Gently shake or tap the person and shout, “Are you okay?” If there’s no response, check for breathing: look at the chest, listen for breath, and feel for air. If not breathing or only gasping, continue.',
        'Call emergency services immediately. Put the phone on speaker or have someone else call while you begin CPR.',
        'Place the heel of one hand in the center of the chest and the other hand on top. Push hard and fast (at least 5 cm deep) at a rate of 100–120 compressions per minute. Let the chest fully rise between compressions.',
        'After 30 compressions, tilt the head back, lift the chin, pinch the nose, and give 2 rescue breaths. Blow steadily into the mouth for 1 second each, watching the chest rise.',
        'Repeat the cycle of 30 compressions and 2 breaths until help arrives, an AED is available, or the person starts breathing.',
      ],
      stepImages: [
        'assets/images/CPR_step1.jpeg',
        'assets/images/CPR_step2.jpeg',
        'assets/images/CPR_step3.jpeg',
        'assets/images/CPR_step4.jpeg',
        'assets/images/CPR_step1.jpeg',
      ],
    ),
    FirstAidTopic(
      title: 'Burns',
      imagePath: 'assets/images/Burns.jpeg',
      steps: [
        'Cool the burn under cold running water for at least 10 minutes.',
        'Do not apply ice or butter.',
        'Cover with a sterile non-stick dressing or clean cloth.',
        'Avoid breaking any blisters.',
        'Seek medical help for large or deep burns.',
      ],
    ),
    FirstAidTopic(
      title: 'Cuts',
      imagePath: 'assets/images/Cuts.jpeg',
      steps: [
        'Wash hands thoroughly.',
        'Clean the wound gently with water.',
        'Apply pressure with a clean cloth to stop bleeding.',
        'Cover with a sterile bandage.',
        'Change the dressing daily and watch for infection.',
      ],
    ),
    FirstAidTopic(
      title: 'Fracture',
      imagePath: 'assets/images/Fracture.jpeg',
      steps: [
        'Stop any bleeding. Apply pressure to the wound with a sterile bandage, a clean cloth or a clean piece of clothing.',
        'Do not move the person unless necessary.',
        'Keep the injured area from moving. Do not try to realign the bone or push a bone that is sticking out back in.',
        'Apply ice packs to limit swelling and help relieve pain. Do not apply ice directly to the skin.',
        'Treat for shock. Lay the person down with the head slightly lower than the trunk. Raise the legs if possible.',
      ],
    ),
    FirstAidTopic(
      title: 'Heart Attack',
      imagePath: 'assets/images/heart_attack.jpeg',
      steps: [
        'Call emergency services immediately.',
        'Take aspirin, if recommended.',
        'Take nitroglycerin, if prescribed.',
        'Start CPR if there is no pulse or breathing.',
        'Use an AED if available.',
      ],
    ),
    FirstAidTopic(
      title: 'Seizures',
      imagePath: 'assets/images/seizures.jpeg',
      steps: [
        'Stay calm and protect the person from injury.',
        'Clear the area of harmful objects.',
        'Do not restrain or put anything in their mouth.',
        'Place them on their side once the seizure stops.',
        'Stay with them until full recovery or help arrives.',
      ],
    ),
    FirstAidTopic(
      title: 'Chest Pain',
      imagePath: 'assets/images/chest_pain.jpeg',
      steps: [
        'Call emergency services immediately.',
        'Help the person to sit down and rest.',
        'Loosen any tight clothing.',
        'Keep them calm and reassure them.',
        'If prescribed, assist them in taking nitroglycerin.',
      ],
    ),
    FirstAidTopic(
      title: 'Choking',
      imagePath: 'assets/images/choking.jpeg',
      steps: [
        'Ask if the person can speak or cough.',
        'If not, give 5 back blows between the shoulder blades.',
        'Follow with 5 abdominal thrusts (Heimlich maneuver).',
        'Repeat the cycle until the object is expelled.',
        'If unconscious, begin CPR and call for help.',
      ],
    ),
  ];

  void _callEmergency() async {
    final Uri uri = Uri(scheme: 'tel', path: '+254703174882');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Breathe. You have Got This.'),
        actions: [
          IconButton(icon: const Icon(Icons.phone), onPressed: _callEmergency),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: topics.length + 1,
          itemBuilder: (context, index) {
            if (index < topics.length) {
              final topic = topics[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(topic: topic),
                  ),
                ),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Image.asset(topic.imagePath, fit: BoxFit.contain),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          topic.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FAQPage()),
                ),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.amber.shade100,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.question_answer, size: 50, color: Colors.black),
                      SizedBox(height: 10),
                      Text(
                        'FAQs',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
// ------------------ DETAIL PAGE ------------------ //

class DetailPage extends StatelessWidget {
  final FirstAidTopic topic;

  const DetailPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final hasImages = topic.stepImages != null &&
        topic.stepImages!.length == topic.steps.length;

    return Scaffold(
      appBar: AppBar(title: Text(topic.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < topic.steps.length; i++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasImages)
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Image.asset(
                        topic.stepImages![i],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      '${i + 1}. ${topic.steps[i]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const Divider(height: 30),
            ],
          ],
        ),
      ),
    );
  }
}
// ------------------ FAQ PAGE ------------------ //
class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'question': 'How do I give back blows?',
        'answer':
            '• Position yourself to the side and slightly behind the person.\n• Place one arm diagonally across their chest.\n• Bend them forward so the upper body is parallel to the ground.\n• Firmly strike between the shoulder blades 5 times with the heel of your hand.\n• Each back blow should be separate and forceful.',
      },
      {
        'question': 'How do I give abdominal thrusts?',
        'answer':
            '• Have the person stand.\n• Find the question navel and place your fist above it.\n• Cover your fist with your other hand.\n• Pull inward and upward 5 times, forcefully and separately.',
      },
      {
        'question': 'What should I do if the person can cough, cry, or speak?',
        'answer':
            'Encourage them to continue coughing. Do not leave them alone. Be prepared to act if their condition worsens.',
      },
      {
        'question': 'Are the steps always the same for everyone who is choking?',
        'answer':
            'Some situations require modified care:\n• Large person or pregnant: use chest thrusts.\n• Person in wheelchair: kneel behind and give abdominal or chest thrusts.\n• As a last resort, remove the person from the wheelchair.',
      },
      {
        'question': 'What if I’m alone and start choking?',
        'answer':
            'Call emergency services immediately. Even if you can’t speak, the dispatcher will send help.\nGive yourself abdominal thrusts or press your abdomen against a firm surface (e.g., chair). Avoid sharp edges or unstable railings.',
      },
      {
        'question': 'Do I treat a child the same as an adult?',
        'answer':
            'Yes, but you may need to kneel behind them. Use the same pattern: 5 back blows followed by 5 abdominal thrusts. Never hang a child upside down.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choking FAQs'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ExpansionTile(
              title: Text(
                faq['question']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(faq['answer']!),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

