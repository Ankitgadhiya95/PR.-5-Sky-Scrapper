import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky/screens/screens.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  List<String> locationListData = [];

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getStringList('locationList'));
    setState(() {
      locationListData = pref.getStringList('locationList')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Location"),
      ),
      body: Center(
          child: ListView.builder(
              itemCount: locationListData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoadingScreen(
                            fromPage: 'city',
                            cityName: locationListData[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              locationListData[index],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            IconButton(
                                onPressed: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  List<String> list = [];
                                  setState(() {
                                    if (pref.getStringList('locationList') !=
                                        null) {
                                      list =
                                          pref.getStringList('locationList')!;
                                    }

                                    setState(() {
                                      locationListData.removeAt(index);
                                    });
                                    pref.setStringList(
                                        'locationList', locationListData);
                                  });
                                },
                                icon: Icon(CupertinoIcons.delete))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
