import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView(
        children: [
          NotificationItem(
            title: 'Notification Title 1',
            description: 'Notification description goes here.',
            time: '10:00 AM',
          ),
          NotificationItem(
            title: 'Notification Title 2',
            description: 'Notification description goes here.',
            time: '11:30 AM',
          ),
          // Add more NotificationItems as needed
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.notifications),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(description),
      trailing: Text(time),
      onTap: () {
        // Add your notification item on tap logic here
      },
    );
  }
}

void main() {
  runApp(NotificationApp());
}

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotificationPage(),
    );
  }
}