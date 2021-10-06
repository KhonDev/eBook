import 'package:flutter/material.dart';
import 'package:flutter11/resources/resources.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController();

  int currnetPage = 0;

  final Map<int, dynamic> onboardData = {
    0: {
      'image': Images.ebook,
      'title': 'A reader liver a thousend lives',
      'subtitle': 'The man who never reads lives only one',
    },
    1: {
      'image': Images.learn,
      'title': 'Featured Books',
      'subtitle': 'Available right at your fingerprints',
    },
    2: {
      'image': Images.manthumbs,
      'title': 'Simple UI',
      'subtitle': 'For enhanced reading exoerience',
    },
    3: {
      'image': Images.readingbook,
      'title': 'Today a reader, tomorrow a leader',
      'subtitle': 'Start your journey',
    }
  };

  toNextpage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.linear,
    );
  }

  toSkip() {
    controller.animateToPage(
      3,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  changeCurrnetPage(int page) {
    setState(() {
      currnetPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 740.0,
                child: PageView.builder(
                  onPageChanged: (value) => changeCurrnetPage(value),
                  controller: controller,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return OnboardWidget(
                      image: onboardData[index]['image'],
                      title: onboardData[index]['title'],
                      subtitle: onboardData[index]['subtitle'],
                      isLastPage: index == 3 ? true : false,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  currnetPage != 3
                      ? TextButton(
                          onPressed: toSkip,
                          child: const Text('Skip'),
                        )
                      : const SizedBox(
                          width: 50.0,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Circularindicator(
                          isActive: currnetPage == index ? true : false),
                    ),
                  ),
                  currnetPage != 3
                      ? TextButton(
                          onPressed: toNextpage,
                          child: const Icon(Icons.arrow_forward),
                        )
                      : TextButton(
                          onPressed: toNextpage,
                          child: const Text('Read'),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Circularindicator extends StatelessWidget {
  const Circularindicator({Key? key, required this.isActive}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      width: isActive ? 24.0 : 14.0,
      height: 14,
      decoration: BoxDecoration(
          borderRadius: isActive
              ? BorderRadius.circular(12.0)
              : BorderRadius.circular(50.0),
          color: isActive ? Colors.blue : Colors.grey),
    );
  }
}

class OnboardWidget extends StatelessWidget {
  const OnboardWidget(
      {Key? key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.isLastPage})
      : super(key: key);

  final String image;
  final String title;
  final String subtitle;
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 30),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 50.0),
          Image.asset(image),
          const SizedBox(height: 70.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              height: 1.4,
              fontSize: 28.0,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 50.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 23.0,
            ),
          ),
          if (isLastPage)
            ElevatedButton(
              onPressed: () {},
              child: const Text('Start Reading'),
            )
        ],
      ),
    );
  }
}
