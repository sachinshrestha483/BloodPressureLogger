import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/pages/allreadings/allreadings.dart';
import 'package:mvp1/pages/charts/view/charts_page.dart';
import 'package:mvp1/pages/statistics/view/statistics_page.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

int currentIndex = 0;

class _AnalysisPageState extends State<AnalysisPage> {
  List<Widget> screens = [
    AllReadingsPage(),
    StatisticsPage(),
    ChartsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: screens,
        index: currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
  
        selectedItemColor: Colors.blue,
        onTap: (int choosedIndex) {
          setState(() {
            currentIndex = choosedIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
  
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste),
            label: "All Readings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: "Statistics",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: "Charts",
          )
        ],
      ),
      
    );
  }
}
