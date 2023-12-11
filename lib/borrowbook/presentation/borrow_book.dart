import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaleskhair/borrowbook/bloc/cubit_borrow.dart';
import 'package:jaleskhair/borrowbook/bloc/state_borrow.dart';
import 'package:jaleskhair/login/presentation/login_page.dart';
import 'package:jaleskhair/models/local_book_status.dart';
import 'package:jaleskhair/models/user_borrow_status.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:jaleskhair/unit/widgets.dart';

class BorrowBook extends StatefulWidget {
  const BorrowBook({Key? key}) : super(key: key);

  @override
  _BorrowBookState createState() => _BorrowBookState();
}

class _BorrowBookState extends State<BorrowBook> {
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

  void initStateborrow() {
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
        child:Stepper(
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
                create: (context) => BorrowCubit(InitBorrowState()),
                child: BlocConsumer<BorrowCubit, BorrowState>(
                  listener: (context, state) {
                    if (state is UserBorrowLoadedState) {
                      this.userBorrowStatus = state.userBorrowStatus;
                      if(userBorrowStatus.userName != null){
                        this.userName = userBorrowStatus.userName;
                      }
                      setState(() {
                        currentStep += 1;
                      });
                    }
                    if (state is BorrowLoadingErrorState) {
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
                    if (state is BorrowLoadingState) {
                      return Loading(h, w);
                    } else {
                      return InkWell(
                        onTap: () {
                          if(formkey.currentState!.validate()){
                          BlocProvider.of<BorrowCubit>(context)
                              .Userborrowstatus(usernamecontroller.text);}
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
                  create: (context) => BorrowCubit(InitBorrowState()),
                  child: BlocConsumer<BorrowCubit, BorrowState>(
                    listener: (context, state) {
                      if (state is BookBorrowLoadedState) {
                        this.localBookStatus = state.localBookStatus;
                        if(localBookStatus.title != null){
                          this.bookName = localBookStatus.title;
                        }
                        this.getimage = localBookStatus.globalBookEditionId;
                        setState(() {
                          currentStep += 1;
                        });
                      }
                      if (state is BorrowLoadingErrorState) {
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
                      if (state is BorrowLoadingState) {
                        return Loading(h, w);
                      } else {
                        return InkWell(
                          onTap: () {
                            if(formkey2.currentState!.validate()){
                            BlocProvider.of<BorrowCubit>(context)
                                .Bookborrowstatus(booknamecontroller.text);}
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
          "تأكيد الاستعارة",
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
                      create: (context) => BorrowCubit(InitBorrowState()),
                      child: BlocConsumer<BorrowCubit, BorrowState>(
                        listener: (context, state) {
                          if (state is BorrowLoadedState) {
                            FlushBar(state.message, h, context);
                            setState(() {
                              currentStep += 1;
                            });
                            Timer( Duration(seconds: cometofirststep),() {
                              initStateborrow();
                            });
                          }
                          if (state is BorrowLoadingErrorState) {
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
                          if (state is BorrowLoadingState) {
                            return Loading(h, w);
                          }
                          else {
                            return InkWell(
                              onTap: () {
                                BlocProvider.of<BorrowCubit>(context)
                                    .BorrowLocalBook(userBorrowStatus.userId,
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
