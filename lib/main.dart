// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> myWork = [];
  List<bool>? ischecked;
  TextEditingController textEditingController = new TextEditingController();
  late FocusNode myFocusNode;
  late SharedPreferences prefs;

  //String value = "";
  //bool _value = false;
  @override
  void initState() {
    // TODO: implement initState
    retrievedata();
    retrieveBoolData();
    // prefs.remove("checkBoxList");R
    // ischecked = List.filled(myWork.length, false, growable: true);
    ischecked = List.filled(myWork.length, false, growable: true);
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text(
          'TO DO APP',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
        leading: IconButton(
            iconSize: 20,
            onPressed: () {
              delete();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Work',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Text(
                ischeckedfunction(ischecked!),
                style: TextStyle(fontSize: 19),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          indent: 15,
          endIndent: 10,
          color: Colors.black,
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: ListView.builder(
                itemCount: myWork.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) {
                      setState(() {
                        myWork.removeAt(index);
                        ischecked!.removeAt(index);
                      });
                      savedata();
                      saveBoolData();
                    },
                    child: Card(
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          myWork[index],
                          style: TextStyle(
                              decoration: ischecked![index]
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        value: ischecked![index],
                        onChanged: (value) {
                          setState(() {
                            ischecked![index] = value!;
                          });
                          saveBoolData();
                        },
                        // secondary: IconButton(
                        // onPressed: () {
                        // delete();
                        // },
                        // icon: Icon(Icons.delete)),
                      ),
                    ),
                    background: Container(
                      color: Colors.red,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Icon
                      ( Icons.delete,color: Colors.white),
                             
                    ),
                  );
                })),
      ]),
      // Container(
      //   height: MediaQuery.of(context).size.width,
      //   child: Column(children: [
      //     const SizedBox(
      //       height: 10,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(14.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: const [
      //           Text(
      //             'Work',
      //             style: TextStyle(
      //                 color: Colors.black,
      //                 fontSize: 14,
      //                 fontWeight: FontWeight.w400),
      //           ),
      //   ]        Text(
      //             '3',
      //             style: TextStyle(
      //                 color: Colors.black,
      //                 fontSize: 14,
      //                 fontWeight: FontWeight.w400),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Row(
      //       children: const [
      //         Expanded(
      //           child: Divider(
      //               color: Colors.black,
      //               indent: 17,
      //               endIndent: 17,
      //               thickness: 1,
      //               height: 13),
      //         )
      //       ],
      //     ),

      //     CheckboxListTile(
      //       title: const Text('Hello world'),
      //       controlAffinity: ListTileControlAffinity.leading,
      //       autofocus: false,
      //       activeColor: Colors.black,
      //       checkColor: Colors.white,
      //       selected: _value,
      //       value: _value,
      //       onChanged: (value) {
      //         setState(() {
      //           _value = value!;
      //         });
      //       },
      //     ),

      //     // Row(children: const [
      //     //   Mycheckbox(),
      //     //   Text(
      //     //     'Breakfast',
      //     //     style: TextStyle(
      //     //         color: Colors.black,
      //     //         fontSize: 14,
      //     //         fontWeight: FontWeight.w500),
      //     //   )
      //     // ]),
      //     // Row(children: const [
      //     //   Mycheckbox(),
      //     //   Text(
      //     //     'Meet with HR',
      //     //     style: TextStyle(
      //     //         color: Colors.black,
      //     //         fontSize: 14,
      //     //         fontWeight: FontWeight.w500),
      //     //   )
      //     // ]),
      //     // Row(
      //     //   children: const [
      //     //     Mycheckbox(),
      //     //     Text(
      //     //       'Lunch',
      //     //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      //     //     )
      //     //   ],
      //     // ),
      //     // Row(children: const [
      //     //   Mycheckbox(),
      //     //   Text(
      //     //     'Football match at 7pm',
      //     //     style: TextStyle(
      //     //         color: Colors.black,
      //     //         fontSize: 14,
      //     //         fontWeight: FontWeight.w500),
      //     //   )
      //     // ]),
      //   ]),
      // ),

      floatingActionButton: Material(
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            shape: BoxShape.circle,
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              myFocusNode.requestFocus();
              showDialog(
                  context: context,
                  builder: (context) => Center(
                        child: AlertDialog(
                          content: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                                focusNode: myFocusNode,
                                controller: textEditingController,
                                decoration: const InputDecoration(
                                    hintText: "enter the work here ",
                                    contentPadding: EdgeInsets.all(15),
                                    border: OutlineInputBorder())),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("cancel")),
                            ElevatedButton(
                                onPressed: () {
                                  savedata();
                                  if (textEditingController.text != null &&
                                      textEditingController.text != "") {
                                    setState(() {
                                      ischecked!.insert(myWork.length, false);
                                      // ischecked!.add(false);
                                      myWork.add(textEditingController.text);
                                    });
                                    saveBoolData();
                                    textEditingController.clear();
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text("submit")),
                          ],
                        ),
                      ));
            },
          ),
        ),
      ),
    ));
  }

  savedata() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setStringList('mylist', myWork);
    // ischecked = List.filled(myWork.length, false, growable: true);
  }

  saveBoolData() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? listOFStatus = [];
    for (int i = 0; i < ischecked!.length; i++) {
      if (ischecked![i]) {
        // print("gjf");
        // prefs.setStringList(key, value);
        listOFStatus.add("true");
      } else {
        // print("kshf");
        listOFStatus.add("false");
      }
    }
    // print(listOFStatus);

    if (prefs.getStringList("checkBoxList") != null) {
      prefs.remove("checkBoxList");
    }
    prefs.setStringList('checkBoxList', listOFStatus);
    // ischecked = List.filled(myWork.length, false, growable: true);
  }

  retrieveBoolData() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('checkBoxList') != null) {
      if (ischecked != null) {
        ischecked!.clear();
      }
      var statusOfWorkBool = prefs.getStringList("checkBoxList");

      // List<String>? listOFStatus;
      // listOFStatus!.addAll(prefs.getStringList("checkBoxList"));
      // print("shvh");
      prefs.getStringList("checkBoxList")!.forEach((element) {
        if (element == "true") {
          // ischecked[element.indexOf(pattern)]

          ischecked!.add(true);
        } else {
          ischecked!.add(false);
        }
      });
      // statusOfWork = List.filled(myWork.length, false, growable: true);
      // ischecked = List.filled(myWork.length, false, growable: true);
    }
    print(ischecked);
    setState(() {});
  }

  retrievedata() async {
    prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    if (prefs.getStringList('mylist') != null) {
      myWork.addAll(prefs.getStringList('mylist')!);
      // statusOfWork = List.filled(myWork.length, false, growable: true);
      ischecked = List.filled(myWork.length, false, growable: true);
    }
    setState(() {});
  }

  ischeckedfunction(List ischecked) {
    int count = 0;
    for (int i = 0; i < ischecked.length; i++) {
      if (ischecked[i] == false) {
        count++;
      }
    }
    return count.toString();
  }

  delete() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('mylist');
  }
}

 // class Mycheckbox extends StatefulWidget {
//   const Mycheckbox({Key? key}) : super(key: key);

//   @override
//   State<Mycheckbox> createState() => _MycheckboxState();
// }

// class _MycheckboxState extends State<Mycheckbox> {
//   bool isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     /*Color getColor(Set<MaterialState> states) {
//       const Set<MaterialState> interactiveStates = <MaterialState>{
//         MaterialState.pressed,
//         MaterialState.hovered,
//         MaterialState.focused,
//       };
//       if (states.any(interactiveStates.contains)) {
//         return Colors.blue;
//       }
//       return Colors.black;
//     }*/

//     return Checkbox(
//       checkColor: Colors.white,
//       //    fillColor: MaterialStateProperty.resolveWith(getColor),
//       value: isChecked,
//       activeColor: Colors.black,
//       splashRadius: 25,
//       onChanged: (bool? value) {
//         setState(() {
//           isChecked = value!;
//         });
//       },
//     );
//   }
// }