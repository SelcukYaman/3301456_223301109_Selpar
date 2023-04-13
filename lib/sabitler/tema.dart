import 'package:flutter/material.dart';
import 'package:selpar_selcuk_yamann_223301109/sabitler/renk.dart';
import 'package:google_fonts/google_fonts.dart';

class Tema{
  InputDec(String yazi,IconData icon){
    return InputDecoration(
      border:  InputBorder.none,
      hintStyle: GoogleFonts.roadRage(color: Colors.white),

      prefixIcon: Icon(icon,color: Colors.white,),
      hintText: yazi,
    );
  }
  BoxDec(){
    return BoxDecoration(
      color: Renk_Belirle("75DAAD"),
      borderRadius: BorderRadius.circular(12),
    );
  }

}