
import 'package:flutter/material.dart';

const String renk="E9F8F9";
const String mavirenk="32C0CB";
const String grirenk="5B8FB9";
const String arkarenk="2E8B57";
class Renk_Belirle extends Color{
  static int _donustur(String hexColor){
   hexColor=hexColor.toUpperCase().replaceAll("#", "");
   if(hexColor.length==6){

     hexColor="FF"+hexColor;
   }
    return int.parse(hexColor,radix: 16);
  }
  Renk_Belirle(final String renk_kodu):super(_donustur(renk_kodu));
}