import 'package:flutter/material.dart';
import 'package:chip_list/chip_list.dart';



class ChipChoiceTry extends StatelessWidget {
  const ChipChoiceTry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chip List Demo',
      theme: ThemeData(primarySwatch: Colors.teal, primaryColor: Colors.teal),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _aminitesList = [
    'Roof Top',
    'Party',
    'Bar',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [



          // Using [extraOnToggle]
          const SizedBox(
            height: 20,
          ),
          Text(_aminitesList[_currentIndex]),
          const SizedBox(
            height: 10,
          ),
          ChipList(
            listOfChipNames: _aminitesList,
            activeBgColorList: [Colors.red],
            inactiveBgColorList: const [Colors.white],
            activeTextColorList: const [Colors.white],
            inactiveTextColorList: [Colors.black],
            listOfChipIndicesCurrentlySeclected: [_currentIndex],
            inactiveBorderColorList: const [Colors.red],
            extraOnToggle: (val) {
              _currentIndex = val;
              setState(() {});
            },
          ),
          // Using [shouldWrap]
          const SizedBox(
            height: 20,
          ),


        ],
      ),
    );
  }
}