import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

class AlertWidget extends StatelessWidget {
  final String btnTxt;
  final String content;
  final Function() onClick;
  final String errorType;
  const AlertWidget(
      {super.key,
      required this.btnTxt,
      required this.onClick,
      required this.content,
      required this.errorType});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                iconSize: 25,
              ),
            ],
          ),
          // SizedBox(
          //   height: MediaQuery.sizeOf(context).width * 0.4,
          //   child: Lottie.asset(
          //     'assets/lottie/$errorType.json',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          if (errorType == 'location')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                  )),
                  Expanded(
                    child: Align(
                      child: TextButton(
                        onPressed: onClick,
                        child: Text(
                          btnTxt,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (errorType != 'location')
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  btnTxt,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
