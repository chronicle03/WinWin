import 'package:flutter/material.dart';

class ValidasiForm extends StatelessWidget {
  const ValidasiForm ({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50.0),
        _buildValidasiRegister1(),
        SizedBox(height: 20.0),
        _buildValidasiRegister2(),
        SizedBox(height: 40.0),
        _buildValidasiRegister3(),
      ],
    );
  }

  Widget _buildValidasiRegister1() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 2.0,
            height: 48.0,
            color: Colors.white,
          ),
          SizedBox(width: 16.0),
          Icon(
            Icons.warning,
            size: 28.0,
            color: Colors.white,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              'Please fill in all the necessary information!',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidasiRegister2() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 2.0,
            height: 48.0,
            color: Colors.white,
          ),
          SizedBox(width: 16.0),
          Icon(
            Icons.check_circle,
            size: 28.0,
            color: Colors.white,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              'Congratulations, you have successfully registered!',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidasiRegister3() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 2.0,
            height: 48.0,
            color: Colors.white,
          ),
          SizedBox(width: 16.0),
          Icon(
            Icons.warning,
            size: 28.0,
            color: Colors.white,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              'Oops! The password you entered is incorrect.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValidasiForm(),
      ),
    );
  }
}