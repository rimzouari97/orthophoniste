import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
enum VirusStatus { none, visible, whacked }
const BASE_URL = "https://orthobackend.herokuapp.com/";
//const BASE_URL = "http://192.168.1.14:3000/";
const headers = {"Content-Type": "application/json"};
