import 'dart:async';

import 'package:app_management/app_management.dart';
import 'package:app_management/model/service.dart';
import 'package:flutter/material.dart';

import 'animation.dart';

List<bool> active = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

class MemmoryUI extends StatefulWidget {
  const MemmoryUI({Key? key}) : super(key: key);

  @override
  State<MemmoryUI> createState() => _MemmoryUIState();
}

class _MemmoryUIState extends State<MemmoryUI> {
  AppManagement catc = AppManagement();
  Memory? memory = Memory(available: 1, percentage: 1, total: 1);
  @override
  void initState() {
    super.initState();
    catc.startWhatsappService().listen((event) {
      print(event);
    });
    // Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   memory = await AppManagement.memoryInfo;
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    if (memory == null) {
      return const Scaffold();
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(children: [
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ScaleAnimation(
                    delay: Duration(milliseconds: 500),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  ScaleAnimation(
                    delay: Duration(milliseconds: 500),
                    child: Text(
                      'Manage Memory',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 50,
              // ),
              // Row(
              //   children: [
              //     Image.asset(
              //       'assets/file.png',
              //       width: 24,
              //     ),
              //     const SizedBox(
              //       width: 12,
              //     ),
              //     const Text(
              //       'Media',
              //       style: TextStyle(color: Colors.white, fontSize: 18),
              //     ),
              //     const Expanded(child: SizedBox()),
              //     const Icon(
              //       Icons.more_horiz,
              //       color: Colors.white,
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 10,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          ScaleAnimation(
                            delay: const Duration(milliseconds: 500),
                            child: Text(
                              (((memory?.total ?? 0) - (memory?.available ?? 0)) / 1000).toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 40),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                ScaleAnimation(
                                  delay: Duration(milliseconds: 550),
                                  child: Text(
                                    'GB',
                                    style: TextStyle(color: Colors.white70, fontSize: 11),
                                  ),
                                ),
                                ScaleAnimation(
                                  delay: Duration(milliseconds: 580),
                                  child: Text(
                                    'Used',
                                    style: TextStyle(color: Colors.white70, fontSize: 11),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ScaleAnimation(
                            delay: const Duration(milliseconds: 550),
                            child: Text(
                              '${((memory?.available ?? 0) / 1000).toString()} Gb',
                              style: const TextStyle(color: Colors.white70, fontSize: 11),
                            ),
                          ),
                          const ScaleAnimation(
                            delay: Duration(milliseconds: 580),
                            child: Text(
                              'Free',
                              style: TextStyle(color: Colors.white70, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.white30,
                child: SizedBox(
                  height: 5,
                  child: Row(
                    children: [
                      Expanded(
                        flex: ((((memory?.total ?? 0) - (memory?.available ?? 0)) / (memory?.total ?? 0)) * 100).floor(),
                        child: const SizedBox(
                          height: 5,
                          child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: (((memory?.available ?? 0) / (memory?.total ?? 0)) * 100).floor(),
                        child: const SizedBox(
                          height: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          ScaleAnimation(
                            delay: Duration(milliseconds: 520),
                            child: Text(
                              'Media Files',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          ScaleAnimation(
                            delay: Duration(milliseconds: 530),
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: active.length,
                        itemBuilder: (context, index) {
                          final data = active[index];
                          final check = CheckIcon(
                            status: data,
                          );
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: ScaleAnimation(
                              delay: Duration(milliseconds: (index * 10)),
                              child: InkWell(
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  data ? active[index] = false : active[index] = true;
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Image.asset(
                                            'assets/file.png',
                                            width: 50,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: check,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'File Berbahaya',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            '50 MB, 23 Mei 2022',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.memory),
        onPressed: () async {
          setState(() {});
        },
      ),
    );
  }
}
