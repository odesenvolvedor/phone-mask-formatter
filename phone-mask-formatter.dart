import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneMaskFormatter extends TextInputFormatter {
  
   String _phoneMask(String phone) {

    String onlyNumbers = phone.replaceAll(RegExp(r'[\Dg]'), "");
    onlyNumbers = onlyNumbers.replaceAll(RegExp(r'^0'), "");

    if (onlyNumbers.length > 10) {
      onlyNumbers = onlyNumbers.replaceAllMapped(
          RegExp(r'^(.{2})(.{0,5})(.{0,4}).*'),
          (Match m) => "(${m[1]}) ${m[2]}-${m[3]}");
    } else if (onlyNumbers.length > 6) {
      onlyNumbers = onlyNumbers.replaceAllMapped(
          RegExp(r'^(.{2})(.{0,4})(.{0,4}).*'),
          (Match m) => "(${m[1]}) ${m[2]}-${m[3]}");
    } else if (onlyNumbers.length > 2) {
      onlyNumbers = onlyNumbers.replaceAllMapped(
          RegExp(r'^(.{2})(.{0,4}).*'), (Match m) => "(${m[1]}) ${m[2]}");
    } else if (onlyNumbers.length > 2) {
      onlyNumbers = onlyNumbers.replaceAllMapped(
          RegExp(r'^(.{0,2}).*'), (Match m) => "(${m[0]})");
    } else if (onlyNumbers.length > 0) {
      onlyNumbers = onlyNumbers.replaceAllMapped(
        RegExp(r'^(.{0,2}).*'), (Match m) => "(${m[0]}");
    } else {
      onlyNumbers = '';
    }
    return onlyNumbers;
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    
    String newText = _phoneMask(newValue.text);
    int offset = newValue.selection.base.offset < newValue.text.length 
    ? newValue.selection.base.offset 
    : newText.length;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: offset,
      ),
    );
  }
}
