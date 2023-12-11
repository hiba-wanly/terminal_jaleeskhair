import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaleskhair/login/presentation/login_page.dart';
import 'package:jaleskhair/models/local_book_status.dart';
import 'package:jaleskhair/returnbook/bloc/cubit_return.dart';
import 'package:jaleskhair/returnbook/bloc/state_return.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:jaleskhair/unit/widgets.dart';
class ReturnBook extends StatefulWidget {
  const ReturnBook({Key? key}) : super(key: key);

  @override
  _ReturnBookState createState() => _ReturnBookState();
}

class _ReturnBookState extends State<ReturnBook> {
  int currentStep = 0;

  TextEditingController booknamecontroller = TextEditingController();

  late LocalBookStatus localBookStatus;

  String bookName = "";
  String lastborrowDate ="";
  String lastborrowerName = "";
  String lastborrowerGrade = "";
  dynamic lastborrowerClass ="";
  int getimage = 0;

  var formkey = GlobalKey<FormState>();

  double h = 0;
  double w = 0;

  void initStatereturn() {
    final isLastStep = currentStep==(getSteps().length -1);
    if(isLastStep) {
      setState(() {
        currentStep=0;
        formkey = GlobalKey<FormState>();
        booknamecontroller = TextEditingController();
        LocalBookStatus localBookStatus;
         bookName = "";
         lastborrowDate ="";
         lastborrowerName = "";
         lastborrowerGrade = "";
         lastborrowerClass ="";
         getimage = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    this.h = MediaQuery.of(context).size.height;
    this.w = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: ThemeData(
          // canvasColor: Colors.yellow,
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primarycolor,
          ),
        ),
        child: Stepper(
          physics: ClampingScrollPhysics(),
          type: StepperType.vertical,
          steps: getSteps(),
          currentStep: currentStep,
          controlsBuilder: (context, _) {
            return SizedBox();
          },
          // onStepTapped: (index){
          //   setState(() {
          //     currentStepread = index;
          //   });
          //   },

          // onStepContinue: (){
          //   setState(() {
          //     debugPrint(currentStepread.toString());
          //     currentStepread += 1;
          //   });
          // },
        ),
      ),
    );
  }

  List<Step> getSteps() => [
    Step(
      isActive: currentStep >= 0,
      title: Text(
        "أدخل الباركود الخاص بالكتاب",
        style: TextStyle(fontFamily: Almarai, fontSize: w * 0.035),
      ),
      content: Form(
        key: formkey,
        child: Column(
          children: [
            boxController(booknamecontroller, "الباركود*", h, w,
                TextInputType.text),
            SizedBox(
              height: h * 0.02,
            ),
            BlocProvider(
                create: (context) => ReturnCubit(InitReturnState()),
                child: BlocConsumer<ReturnCubit, ReturnState>(
                  listener: (context, state) {
                    if (state is BookReturnLoadedState) {
                      this.localBookStatus = state.localBookStatus;
                      if(localBookStatus.title != null){
                        this.bookName = localBookStatus.title;
                      }
                      this.getimage = localBookStatus.globalBookEditionId;
                      if(localBookStatus.lastBorrowDate != null){
                        this.lastborrowDate = localBookStatus.lastBorrowDate;
                      }
                      if( localBookStatus.lastBorrowerName != null){
                        this.lastborrowerName = localBookStatus.lastBorrowerName;
                      }
                     if(localBookStatus.lastBorrowerGrade != null){
                       this.lastborrowerGrade = localBookStatus.lastBorrowerGrade;
                     }
                      if(localBookStatus.lastBorrowerClass.toString().isNotEmpty){
                        this.lastborrowerClass = localBookStatus.lastBorrowerClass;
                      } else {
                        this.lastborrowerClass = "null";
                      }

                      setState(() {
                        currentStep += 1;
                      });
                    }
                    if (state is ReturnLoadingErrorState) {
                      FlushBar(state.message, h, context);
                    }
                    if(state is NoTokenState){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ReturnLoadingState) {
                      return Loading(h, w);
                    } else {
                      return InkWell(
                        onTap: () {
                          if(formkey.currentState!.validate()){
                          BlocProvider.of<ReturnCubit>(context)
                              .Bookreturnstatus(booknamecontroller.text);}
                        },
                        child: Button(h, w, "التالي"),
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    ),
    Step(
        isActive: currentStep >= 1,
        title: Text(
          "تأكيد الاعادة",
          style: TextStyle(fontFamily: Almarai, fontSize: w * 0.035),
        ),
        content: Column(
          children: [
            Text(
              "عنوان الكتاب : " + bookName,
              style: TextStyle(fontFamily: Almarai, fontSize: w * 0.03),
            ),
            // SizedBox(height: h * 0.01,),
            // Image.network(
            //   'https://jaleeskhair.com/img/books/${getimage}_front_face.jpg',
            //   width: w * 0.25,
            //   height: h* 0.3,
            //   fit: BoxFit.fitWidth,
            // ),
            FadeInImage(
              image: NetworkImage('https://jaleeskhair.com/img/books/${getimage}_front_face.jpg',),
              placeholder: const AssetImage(
                  "images/bookwithoutback.png"),
              imageErrorBuilder:
                  (context, error, stackTrace) {
                return Image.asset(
                    'images/bookwithoutback.png',
                    fit: BoxFit.fitWidth);
              },
              width: w * 0.25,
              height: h* 0.3,
              fit: BoxFit.fitWidth,
            ),
            // SizedBox(height: h * 0.01,),
            Text(
              "اخر استعارة : " + lastborrowDate,
              style: TextStyle(fontFamily: Almarai, fontSize: w * 0.03),
            ),
            SizedBox(height: h * 0.01,),
            Text(
              "اخر مستعير : " + lastborrowerName,
              style: TextStyle(fontFamily: Almarai, fontSize: w * 0.03),
            ),
            SizedBox(height: h * 0.01,),
            Text(
              "الصف : " + lastborrowerGrade,
              style: TextStyle(fontFamily: Almarai, fontSize: w * 0.03),
            ),
            SizedBox(height: h * 0.01,),
            Text(
              "الشعبة : " + lastborrowerClass.toString(),
              style: TextStyle(fontFamily: Almarai, fontSize: w * 0.03),
            ),
            SizedBox(height: h * 0.01,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentStep -= 1;
                      });
                    },
                    child: Button(h, w, "السابق"),
                  ),
                  BlocProvider(
                      create: (context) => ReturnCubit(InitReturnState()),
                      child: BlocConsumer<ReturnCubit, ReturnState>(
                        listener: (context, state) {
                          if (state is ReturnLoadedState) {
                            FlushBar(state.message, h, context);
                            setState(() {
                              currentStep += 1;
                            });
                            Timer( Duration(seconds: cometofirststep),() {
                              initStatereturn();
                            });
                          }
                          if (state is ReturnLoadingErrorState) {
                            FlushBar(state.message, h, context);
                          }
                          if(state is NoTokenState){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ReturnLoadingState) {
                            return Loading(h, w);
                          }
                          else {
                            return InkWell(
                              onTap: () {
                                BlocProvider.of<ReturnCubit>(context)
                                    .ReturnLocalBook(
                                    localBookStatus.localBookId);
                              },
                              child: Button(h, w, "التالي"),
                            );
                          }
                        },
                      )),
                ]),
          ],
        )),
    Step(
      isActive: currentStep >= 2,
      title: Text(
        "تم",
        style: TextStyle(fontFamily: Almarai, fontSize: w * 0.035),
      ),
      content: Column(
        children: [
          Text(
            "تمت العملية بنجاح",
            style: TextStyle(fontFamily: Almarai, fontSize: w * 0.045),
          ),
        ],
      ),
    ),
  ];
}
