import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final picker = ImagePicker();
  File _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 180,
      maxHeight: 180,
    );

    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pizza_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              child: Container(
                width: deviceWidth * 0.8,
                height: deviceHeight * 0.6,
                padding: EdgeInsets.all(
                  20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Is this a Pizza?',
                            style: GoogleFonts.londrinaSolid(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: deviceHeight * 0.35,
                          width: double.infinity,
                          child: Image(
                            fit: BoxFit.cover,
                            image: _pickedImage != null
                                ? FileImage(_pickedImage)
                                : AssetImage('assets/insert.jpg'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () {
                            _pickImage();
                          },
                          borderSide: BorderSide(color: Colors.orange),
                          child: Text(
                            'Insert picture',
                            style: GoogleFonts.londrinaSolid(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: _pickedImage == null ? null : () {},
                          color: Colors.orange,
                          child: Text(
                            'Let\'s check it',
                            style: GoogleFonts.londrinaSolid(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
