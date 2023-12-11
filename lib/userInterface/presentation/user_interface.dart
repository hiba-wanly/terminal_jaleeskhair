import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaleskhair/borrowbook/presentation/borrow_book.dart';
import 'package:jaleskhair/login/bloc/cubit_login.dart';
import 'package:jaleskhair/login/bloc/state_login.dart';
import 'package:jaleskhair/login/presentation/login_page.dart';
import 'package:jaleskhair/readbook/presentation/read_book.dart';
import 'package:jaleskhair/returnbook/presentation/return_book.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:jaleskhair/unit/widgets.dart';
import 'package:jaleskhair/userInterface/bloc/cubit_library_info.dart';
import 'package:jaleskhair/userInterface/bloc/state_library_info.dart';
import 'package:jaleskhair/userInterface/datalayer/library_information.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speed_test_dart/classes/classes.dart';
import 'package:speed_test_dart/speed_test_dart.dart';

class UserInterface extends StatefulWidget {
  const UserInterface({Key? key}) : super(key: key);

  @override
  State<UserInterface> createState() => _UserInterfaceState();
}

class _UserInterfaceState extends State<UserInterface>
    with SingleTickerProviderStateMixin {
  late TabController tabcontroller;

  final GlobalKey<ScaffoldState> _sKey = GlobalKey();

  late String library_name = "";
  late LibraryInformation libraryInformation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabcontroller = TabController(length: 3, vsync: this, initialIndex: 2);
    SharedPreferences.getInstance().then((shard) {
      setState(() {
        library_name = shard.getString("library_name")!;
      });
    });
    BlocProvider.of<LibraryInformationCubit>(context).GetLibraryInfo();
  }

  @override
  void dispose() {
    tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return  BlocConsumer<LibraryInformationCubit,LibraryInformationState>(
      listener: (context,state){
        if(state is LibraryInformationLoadedState){
          this.libraryInformation = state.libraryInformation;
          currentBookscount = libraryInformation.currentBooksCount.toString();
          currentUserscount = libraryInformation.currentUsersCount.toString();
          currentBorrowscount = libraryInformation.currentBorrowsCount.toString();
          borrowscount = libraryInformation.borrowsCount.toString();
        }
      },
      builder: (context,state){
        return Scaffold(
          key: _sKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(h * 0.09),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 6,
                    blurRadius: 6,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: AppBar(
                title: Padding(
                  padding: EdgeInsets.only(top: h * 0.03,bottom: h * 0.001),
                  child: Text(
                    "مكتبة " + library_name,
                    style: TextStyle(
                        fontFamily: Almarai,
                        fontSize: w * 0.055,
                        color: Colors.black),
                  ),
                ),
                centerTitle: true,
                backgroundColor: appbarcolor,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    padding: EdgeInsets.only(top: h * 0.04),
                    onPressed: () {
                      _sKey.currentState?.openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: w*0.06,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            // margin: EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding:
              EdgeInsets.only(top: h * 0.02, left: w * 0.1, right: w * 0.1,bottom: h *0.07),
              child: Column(
                children: [
                  Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        DefaultTabController(
                          length: 3,
                          child: TabBar(
                            controller: tabcontroller,
                            labelColor: bsbodycolor,
                            indicatorColor: primarycolor,
                            unselectedLabelColor: sbbodycolor,
                            indicatorWeight: 3,
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(width: 2.3, color: primarycolor),
                              insets: EdgeInsets.symmetric(
                                  horizontal: w * 0.27, vertical: 0),
                            ),
                            tabs: [
                              Tab(
                                child: Text(
                                  "قراءة",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: Almarai, fontSize: w * 0.04),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "إعادة",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: Almarai, fontSize: w * 0.04),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "استعارة",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: Almarai, fontSize: w * 0.04),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          child: Divider(
                            color: sbbodycolor2,
                            height: 0,
                            thickness: 1,
                          ),
                        )
                      ]),
                  Expanded(
                    child: TabBarView(
                      controller: tabcontroller,
                      children: [
                        ReadBook(),
                        ReturnBook(),
                        BorrowBook(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: h * 0.15,
                  child: DrawerHeader(
                    padding: EdgeInsets.only(top: h * 0.05),
                    decoration: BoxDecoration(
                      color: primarycolor,
                    ),
                    child: Text(
                      "مكتبة " + library_name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: Almarai, fontSize: w * 0.055),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "واجهة الاستخدام",
                    style: TextStyle(fontFamily: Almarai, fontSize: w * 0.04),
                  ),
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>BlocProvider(
                            create: (context) => LibraryInformationCubit(InitLibraryInformationState()),
                            child: UserInterface()
                        ),
                      ),
                    );
                  },
                ),
                BlocProvider(
                  create: (context) => AuthCubit(AuthInitialState()),
                  child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LogoutLoaddedState) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                          FlushBar(state.message, h, context);
                        }
                        if (state is AuthLoadedErrorState) {
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
                      }, builder: (context, state) {
                    return ListTile(
                      leading: Icon(Icons.logout),
                      onTap: () {
                        BlocProvider.of<AuthCubit>(context).Logout();
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
          bottomSheet: Row(
            children: [
              Expanded(
                child: Container(
                  height: h * 0.07,
                  color: Color(0xffddbdf1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "الاستعارات" ,
                        style: TextStyle(
                            fontSize: w * 0.03
                        ),
                      ),
                      Text(
                          borrowscount
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: h * 0.07,
                  color: Color(0xffffb6c1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "الاستعارات الحالية" ,
                        style: TextStyle(
                            fontSize: w * 0.03
                        ),
                      ),
                      Text(
                          currentBorrowscount
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: h * 0.07,
                  color: Color(0xff90ee90),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "المستخدمون",
                        style: TextStyle(
                            fontSize: w * 0.03
                        ),
                      ),
                      Text(
                          currentUserscount
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: h * 0.07,
                  color: Color(0xffadd8e6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "الكتب" ,
                        style: TextStyle(
                            fontSize: w * 0.03
                        ),
                      ),
                      Text(
                          currentBookscount
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
