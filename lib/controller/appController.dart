import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';

class AppController extends GetxController implements DisposableInterface{
  //Bottom navigation
  var currentNavIndex=0.obs;
  var selectedCards = List<bool>.filled(5, false).obs;

   void toggleSelection(int index) {
    selectedCards[index] = !selectedCards[index];
  }


 }

