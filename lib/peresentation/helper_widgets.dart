import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultFormField({
  TextInputType type = TextInputType.text,
  required TextEditingController controller,
  required String lable,
  required IconData prefixicon,
  IconData? suffixIcon,
  void Function()? suffixFun,
  void Function(String)? onChange,
  void Function()? onTap,
  String? Function(String?)? onValidate,

}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: lable,
          prefixIcon: Icon(prefixicon),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: suffixFun,
          ),
      ),
      keyboardType: type,
      onChanged: onChange,
      onTap: onTap,
      validator: onValidate,
    );

Widget defaultMaterialButton({
  required Function()? onPressed,
  required String text,
}) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10.0),
  child:   Container(
    width: double.infinity,
    height: 50,
    color: Colors.blue,
    child:   MaterialButton(
          onPressed:onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white
        ),


      ),

        ),
  ),
);
