import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:jaleskhair/unit/unit.dart';

Widget boxController(TextEditingController controller, String label, double h,double w,
    TextInputType textInputType) =>
    // SizedBox(
    //   height: h*0.08,
     TextFormField(
        textDirection: TextDirection.ltr,
        autocorrect: false,
        autofocus: true,
        controller: controller,
        style: TextStyle(
          color: Colors.black,
          fontSize: h * 0.018,
          fontWeight: FontWeight.w500,
          fontFamily: Almarai,
        ),
        cursorColor: primarycolor,
        keyboardType: textInputType,
        onFieldSubmitted: (val) {
          debugPrint(val);
        },
        validator: (value) {
          if(value!.isEmpty || value == null){
            return " ";
          }
          return null;
        },

        maxLines: 1,
        decoration: InputDecoration(
          // floatingLabelStyle: TextStyle(color: primarycolor),
          // border: UnderlineInputBorder(
          //   borderSide: BorderSide(color: primarycolor),
          // ),
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: primarycolor),
          //
          // ),
          // alignLabelWithHint: true,
          filled: true,
          // fillColor: Colors.grey[200],
          hoverColor: greybox,
          contentPadding:const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primarycolor),
          ),
          label: Text(label,
            style: TextStyle(
                fontFamily: Almarai,
                fontSize: w * 0.03
            ),),

          // contentPadding: EdgeInsets.only(bottom: 0),
        ),
      )
      // ,
    // )
;
    // Container(
    //   height: h*0.05,
    //   margin: EdgeInsets.only(top: h * 0.005),
    //   color: Colors.grey[200],
    //   child: TextFormField(
    //     autocorrect: false,
    //     controller: controller,
    //     style: TextStyle(
    //       color: Colors.black,
    //       fontSize: h * 0.02,
    //       fontWeight: FontWeight.w500,
    //       fontFamily: Almarai,
    //     ),
    //     keyboardType: textInputType,
    //     onFieldSubmitted: (val) {
    //       debugPrint(val);
    //     },
    //     validator: (value) {
    //        if(value!.isEmpty){
    //          return "";
    //        }
    //        return null;
    //     },
    //
    //     maxLines: 1,
    //     decoration: InputDecoration(
    //         // floatingLabelStyle: TextStyle(color: primarycolor),
    //         // border: UnderlineInputBorder(
    //         //   borderSide: BorderSide(color: primarycolor),
    //         // ),
    //         // focusedBorder: UnderlineInputBorder(
    //         //   borderSide: BorderSide(color: primarycolor),
    //         //
    //         // ),
    //       alignLabelWithHint: true,
    //       contentPadding:const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    //       enabledBorder: UnderlineInputBorder(
    //         borderSide: BorderSide(color: primarycolor),
    //       ),
    //         label: Text(label,
    //           style: TextStyle(
    //               fontFamily: Almarai,
    //               fontSize: w * 0.03
    //           ),),
    //
    //         // contentPadding: EdgeInsets.only(bottom: 0),
    //     ),
    //   ),
    // );


Widget Button(double h  , double w, String text) =>
    Container(
      // margin: EdgeInsets.only(
      // //   left: w * 0.005,
      // //   // right: w * 0.05,
      // //   bottom: w * 0.05,
      //   top:  w * 0.09,),
      height:  h * 0.05,
      width: w * 0.2,
      decoration: BoxDecoration(
          color: sbbodycolor2,
          borderRadius: BorderRadius.circular(w* 0.015),
          boxShadow: kElevationToShadow[2]),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: w * 0.04,
            fontFamily: Almarai,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

Future FlushBar (String message, double h ,BuildContext context) =>
    Flushbar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
      messageColor: Colors.black,
      messageSize: h * 0.02,
      message: message,
    ).show(context);


Widget Loading(double h  , double w)=> Container(
  height:  h * 0.05,
  width: w * 0.2,
  decoration: BoxDecoration(
      color: sbbodycolor2,
      borderRadius: BorderRadius.circular(
          w * 0.015),
      boxShadow: kElevationToShadow[2]),
  child: Center(
    child: Padding(
      padding:
      EdgeInsets.only(
        top: h * 0.009, bottom: h * 0.009,left: w * 0.065,right: w * 0.065
      ),
      child: const CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
  ),
);

