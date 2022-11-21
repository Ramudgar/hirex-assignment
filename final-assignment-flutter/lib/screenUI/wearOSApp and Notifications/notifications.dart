import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int counter = 1;
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Builder(builder: (context) {
        return Center(
          child: Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    AwesomeNotifications().createNotification(
                        content: NotificationContent(
                            id: counter,
                            channelKey: 'basic_channel',
                            title: 'Notification title',
                            body:
                                "this is my body where a long test message is shown"));
                    setState(() {
                      counter++;
                    });
                  },
                  child: const Text("Button"),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
