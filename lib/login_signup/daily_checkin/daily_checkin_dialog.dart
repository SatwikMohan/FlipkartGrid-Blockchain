import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class DailyCheckDialog extends StatefulWidget {
  const DailyCheckDialog({super.key});

  @override
  State<DailyCheckDialog> createState() => _DailyCheckDialogState();
}

class _DailyCheckDialogState extends State<DailyCheckDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "Daily Check Reward",
            widget: const Column(
              children: [
                Text("5 days streak!"),
                Text("You are awarded 2 SUPERCOINS"),
                Text("Come back again for more!"),
              ],
            ),
            confirmBtnText: "Claim Reward!",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            barrierDismissible: false,
          );
        },
      ),
    );
  }
}
