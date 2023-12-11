
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jaleskhair/borrowbook/bloc/state_borrow.dart';
import 'package:jaleskhair/borrowbook/serverborrow/server_borrow.dart';
import 'package:jaleskhair/login/server/login_server.dart';
import 'package:jaleskhair/models/local_book_status.dart';
import 'package:jaleskhair/models/user_borrow_status.dart';
import 'package:jaleskhair/server/user_book_status.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:jaleskhair/userInterface/datalayer/library_information.dart';
import 'package:jaleskhair/userInterface/server/library_information_server.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BorrowCubit extends Cubit<BorrowState> {

  BorrowCubit(BorrowState InitState) :super(InitState);

  static BorrowCubit get(context) => BlocProvider.of(context);

  UserBookStatus userBookStatus = UserBookStatus();
  BorrowBookApi borrowBookApi = BorrowBookApi();

  late UserBorrowStatus userBorrowStatus;
  late LocalBookStatus localBookStatus;
  AuthApi authApi = AuthApi();
  LibraryInformationServer libraryInformationServer = LibraryInformationServer();
  late LibraryInformation libraryInformation;

  Userborrowstatus(dynamic user) async
  {
    debugPrint("get01");
    emit(BorrowLoadingState());
    String? token = await authApi.getToken();
    debugPrint(token);
    final user_info = await userBookStatus.UserBorrowStatus(user,token);
    debugPrint("get02");

    debugPrint("get03");
    debugPrint(user_info.toString());
    if(user_info != null){
      if(user_info == 500){
        emit(NoTokenState());
      }
      if(user_info == "User not found"){
        emit(BorrowLoadingErrorState(message: user_info));
      }
      else{
        this.userBorrowStatus = UserBorrowStatus.fromJson(user_info);
        if(userBorrowStatus.allowedToBorrow == true){
          emit(UserBorrowLoadedState(userBorrowStatus: userBorrowStatus));
        }else {
          emit(BorrowLoadingErrorState(message: userBorrowStatus.reason));
        }
      }
    }
    else {
      debugPrint("get0006");
      emit(BorrowLoadingErrorState(message: 'لا يمكن اتمام العملية '));
    }
  }

  Bookborrowstatus(dynamic book) async
  {
    debugPrint("get01");
    emit(BorrowLoadingState());

    String? token = await authApi.getToken();
    debugPrint(token);
    final book_info = await userBookStatus.LocalBookStatus(book,token);
    debugPrint("get02");

    debugPrint("get03");
    debugPrint(book_info.toString());
    if(book_info != null){
      if(book_info == 500){
        emit(NoTokenState());
      }
      if(book_info == "Local Book not found"){
        emit(BorrowLoadingErrorState(message: book_info));
      }
      else{
        this.localBookStatus = LocalBookStatus.fromJson(book_info);
        if(localBookStatus.canBorrow == 1 && localBookStatus.statusId == 1){
          emit(BookBorrowLoadedState(localBookStatus: localBookStatus));
        }
        else if(localBookStatus.canBorrow == 0){
          emit(BorrowLoadingErrorState(message: localBookStatus.canBorrowStatus));
        }
        else if(localBookStatus.statusId == 0){
          emit(BorrowLoadingErrorState(message: localBookStatus.status));
        }
        else {
          emit(BorrowLoadingErrorState(message: 'لا يمكن استعارة الكتاب'));
        }
      }
    }
    else {
      debugPrint("get0006");
      emit(BorrowLoadingErrorState(message: 'لا يمكن اتمام العملية'));
    }
  }

  BorrowLocalBook(dynamic userId,dynamic bookId) async
  {
    debugPrint("get01");
    emit(BorrowLoadingState());
    String? token = await authApi.getToken();
    debugPrint(token);
    Map<String , dynamic> data = {
      'local_book_id' : bookId,
      'user_id' : userId
    };
    final read = await borrowBookApi.BorrowLocalBook(data,token);
    debugPrint("get02");
    debugPrint(read.toString() );
    if(read != null){
      if(read == 500){
        emit(NoTokenState());
      }
      else{
        emit(BorrowLoadedState(message: read.toString()));
        GetLibraryInfo();
      }
    }
    else {
      debugPrint("get0006");
      emit(BorrowLoadingErrorState(message: 'لا يمكن اتمام العملية'));
    }
  }
  GetLibraryInfo() async
  {
    debugPrint("get01");
    // emit(LibraryInformationLoadingState());

    String? token = await authApi.getToken();
    debugPrint(token);
    String? id = await authApi.getLibraryId();
    debugPrint(id);
    final library_info = await libraryInformationServer.GetLibraryInformation(id,token);
    debugPrint("get02");

    debugPrint("get03");
    debugPrint(library_info.toString());
    if(library_info != null){
      if(library_info == 500){
        // emit(NoTokenStateLibrary());
      }
      else{
        this.libraryInformation = LibraryInformation.fromJson(library_info);

        currentBookscount = libraryInformation.currentBooksCount.toString();
        currentUserscount = libraryInformation.currentUsersCount.toString();
        currentBorrowscount = libraryInformation.currentBorrowsCount.toString();
        borrowscount = libraryInformation.borrowsCount.toString();
        // emit(LibraryInformationLoadedState(libraryInformation: libraryInformation));
      }
    }
    else {
      debugPrint("get0006");
      // emit(LibraryInformationLoadingErrorState(message: 'لا يمكن اتمام العملية'));
    }
  }

}