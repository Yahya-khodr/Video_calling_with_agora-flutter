import 'package:chatting_with_mentors/models/call.dart';
import 'package:chatting_with_mentors/provider/user_provider.dart';
import 'package:chatting_with_mentors/resources/call_methods.dart';
import 'package:chatting_with_mentors/screens/callscreens/pickup/pickup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:provider/provider.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();

  PickupLayout({
    @required this.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return (userProvider != null && userProvider.getUser != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: userProvider.getUser.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data() != null) {
                Call call = Call.fromMap(snapshot.data.data());

                if (!call.hasDialled) {
                  FlutterRingtonePlayer.playRingtone();
                  return PickupScreen(call: call);
                }
                print("=====================////====");
                FlutterRingtonePlayer.stop();
                return scaffold;
              }
              FlutterRingtonePlayer.stop();
              return scaffold;
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
