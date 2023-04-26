import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MainApp());
}

class Controller extends GetxController {
  var number = 0.obs;
  var websiteLength = 0.obs;
  void increaseNumber() => number++;
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final TextEditingController _urlController = TextEditingController();
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: _urlController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'address'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.all(20),
                        child: ElevatedButton(
                            onPressed: () async {
                              String url = 'https://${_urlController.text}';
                              final result = await http.get(Uri.parse(url));
                              controller.websiteLength.value =
                                  result.body.toString().length;
                            },
                            child: const Text("GO")),
                      ),
                      Obx(
                        () => Text(
                            "response length: ${controller.websiteLength}"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () async {
                          await Future.delayed(const Duration(seconds: 5));
                          controller.increaseNumber();
                        },
                        child: const Text("NEXT NUMBER")),
                    Obx(
                      () => Text(controller.number.value.toString()),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
