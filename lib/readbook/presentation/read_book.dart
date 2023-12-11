import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaleskhair/login/presentation/login_page.dart';
import 'package:jaleskhair/models/local_book_status.dart';
import 'package:jaleskhair/models/user_borrow_status.dart';
import 'package:jaleskhair/readbook/bloc/cubit_read.dart';
import 'package:jaleskhair/readbook/bloc/state_read.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:jaleskhair/unit/widgets.dart';

class ReadBook extends StatefulWidget {
  const ReadBook({Key? key}) : super(key: key);

  @override
  _ReadBookState createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
  int currentStep = 0;

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController booknamecontroller = TextEditingController();

  late UserBorrowStatus userBorrowStatus;
  late LocalBookStatus localBookStatus;
  String userName = "";
  String bookName = "";
  int getimage = 0;

  var formkey = GlobalKey<FormState>();
  var formkey2 = GlobalKey<FormState>();

  double h = 0;
  double w = 0;

  void initStateread() {
    final isLastStep = currentStep==(getSteps().length -1);
    if(isLastStep) {
      setState(() {
        currentStep=0;
        formkey = GlobalKey<FormState>();
        formkey2 = GlobalKey<FormState>();
        usernamecontroller = TextEditingController();
        booknamecontroller = TextEditingController();
        UserBorrowStatus userBorrowStatus;
        LocalBookStatus localBookStatus;
        userName = "";
        bookName = "";
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
          //   final isLastStep = currentStep==(getSteps().length -1);
          //   if(isLastStep) {
          //     setState(() {
          //       currentStep=0;
          //       formkey = GlobalKey<FormState>();
          //       formkey2 = GlobalKey<FormState>();
          //       usernamecontroller = TextEditingController();
          //       booknamecontroller = TextEditingController();
          //       UserBorrowStatus userBorrowStatus;
          //       LocalBookStatus localBookStatus;
          //       userName = "";
          //       bookName = "";
          //       getimage = 0;
          //     });
          //   }
          //   },

          // onStepContinue: (){
          //   final isLastStep = currentStep==(getSteps().length -1);
          //   if(isLastStep) {
          //   setState(() {
          //       currentStep=0;
          //       formkey = GlobalKey<FormState>();
          //       formkey2 = GlobalKey<FormState>();
          //       usernamecontroller = TextEditingController();
          //       booknamecontroller = TextEditingController();
          //        UserBorrowStatus userBorrowStatus;
          //        LocalBookStatus localBookStatus;
          //        userName = "";
          //        bookName = "";
          //        getimage = 0;
          //   });
          //   }
          // },

        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: Text(
            "أدخل اسم المستخدم",
            style: TextStyle(fontFamily: Almarai, fontSize: w * 0.035),
          ),
          content: Form(
            key: formkey,
            child: Column(
              children: [
                boxController(usernamecontroller, "اسم المستخدم*", h, w,
                    TextInputType.text),
                SizedBox(
                  height: h * 0.02,
                ),
                BlocProvider(
                    create: (context) => ReadCubit(InitReadState()),
                    child: BlocConsumer<ReadCubit, ReadState>(
                      listener: (context, state) {
                        if (state is UserReadLoadedState) {
                          this.userBorrowStatus = state.userBorrowStatus;
                          if(userBorrowStatus.userName != null){
                            this.userName = userBorrowStatus.userName;
                          }
                          setState(() {
                            currentStep += 1;
                          });
                        }
                        if (state is ReadLoadingErrorState) {
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
                        if (state is ReadLoadingState) {
                          return Loading(h, w);
                        } else {
                          return InkWell(
                            onTap: () {
                              if(formkey.currentState!.validate()){
                              BlocProvider.of<ReadCubit>(context)
                                  .UserReadstatus(usernamecontroller.text);}
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
            "أدخل الباركود الخاص بالكتاب",
            style: TextStyle(fontFamily: Almarai, fontSize: w * 0.035),
          ),
          content: Form(
            key: formkey2,
            child: Column(
              children: [
                Text(
                  "اسم المستخدم : " + userName,
                  style: TextStyle(fontFamily: Almarai, fontSize: w * 0.03),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                boxController(
                    booknamecontroller, "الباركود", h, w, TextInputType.text),
                SizedBox(
                  height: h * 0.02,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentStep -= 1;
                      });
                    },
                    child: Button(h, w, "السابق"),
                  ),
                  BlocProvider(
                      create: (context) => ReadCubit(InitReadState()),
                      child: BlocConsumer<ReadCubit, ReadState>(
                        listener: (context, state) {
                          if (state is BookReadLoadedState) {
                            this.localBookStatus = state.localBookStatus;
                            if(localBookStatus.title != null){
                              this.bookName = localBookStatus.title;
                            }
                            this.getimage = localBookStatus.globalBookEditionId;
                            setState(() {
                              currentStep += 1;
                            });
                          }
                          if (state is ReadLoadingErrorState) {
                            FlushBar(state.message, h, context);
                          }
                          if(state is NoTokenState) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ReadLoadingState) {
                            return Loading(h, w);
                          } else {
                            return InkWell(
                              onTap: () {
                                if(formkey2.currentState!.validate()){
                                BlocProvider.of<ReadCubit>(context)
                                    .BookReadstatus(booknamecontroller.text);}
                              },
                              child: Button(h, w, "التالي"),
                            );
                          }
                        },
                      )),
                ]),
              ],
            ),
          ),
        ),
        Step(
            isActive: currentStep >= 2,
            title: Text(
              "تأكيد القراءة",
              style: TextStyle(fontFamily: Almarai, fontSize: w * 0.035),
            ),
            content: Column(
              children: [
                Text(
                  "اسم المستخدم : " + userName,
                  style: TextStyle(fontFamily: Almarai, fontSize: w * 0.03),
                ),
                SizedBox(height: h * 0.01,),
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
                          create: (context) => ReadCubit(InitReadState()),
                          child: BlocConsumer<ReadCubit, ReadState>(
                            listener: (context, state) {
                              if (state is ReadLoadedState) {
                                FlushBar(state.message, h, context);
                                setState(() {
                                  currentStep += 1;
                                });
                                Timer( Duration(seconds: cometofirststep),() {
                                  initStateread();
                                });
                              }
                              if (state is ReadLoadingErrorState) {
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
                              if (state is ReadLoadingState) {
                               return Loading(h, w);
                              }
                              else {
                                return InkWell(
                                  onTap: () {
                                    BlocProvider.of<ReadCubit>(context)
                                        .ReadLocalBook(userBorrowStatus.userId,
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
          isActive: currentStep >= 3,
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
