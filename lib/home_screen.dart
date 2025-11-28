import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  int? _lastScore;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
      _lastScore = prefs.getInt('lastScore');
    });
  }

  void _saveCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
    await prefs.setInt('lastScore', _counter);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _saveCounter();
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
    _saveCounter();
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    _saveCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent[100],
        elevation: 3,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue[100]!, Colors.pink[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Counter Value:',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 15),
              Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.3),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              if (_lastScore != null)
                Text(
                  'Your last counted value was $_lastScore',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    child: Text('-'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(70, 70),
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: const Color.fromARGB(255, 245, 177, 60),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: _resetCounter,
                    child: Text('Reset'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(90, 70),
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: const Color.fromARGB(255, 247, 137, 174),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: Text('+'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(70, 70),
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: const Color.fromARGB(255, 184, 251, 107),
                      elevation: 5,
                    ),
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
