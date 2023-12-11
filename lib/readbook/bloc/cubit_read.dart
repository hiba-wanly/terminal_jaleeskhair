import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jaleskhair/login/server/login_server.dart';
import 'package:jaleskhair/models/local_book_status.dart';
import 'package:jaleskhair/models/user_borrow_status.dart';
import 'package:jaleskhair/readbook/bloc/state_read.dart';
import 'package:jaleskhair/readbook/serverread/server_read.dart';
import 'package:jaleskhair/server/user_book_status.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:jaleskhair/userInterface/bloc/cubit_library_info.dart';
import 'package:jaleskhair/userInterface/datalayer/library_information.dart';
import 'package:jaleskhair/userInterface/server/library_information_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadCubit extends Cubit<ReadState> {

  ReadCubit(ReadState InitState) :super(InitState);

  static ReadCubit get(context) => BlocProvider.of(context);

  UserBookStatus userBookStatus = UserBookStatus();
  ReadBookApi readBookApi = ReadBookApi();
  AuthApi authApi = AuthApi();
  late UserBorrowStatus userBorrowStatus;
  late LocalBookStatus localBookStatus;
  LibraryInformationServer libraryInformationServer = LibraryInformationServer();
  late LibraryInformation libraryInformation;

  UserReadstatus(dynamic user) async
  {
    debugPrint("get01");
    emit(ReadLoadingState());

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
        emit(ReadLoadingErrorState(message: user_info));
      }
      else {
        this.userBorrowStatus = UserBorrowStatus.fromJson(user_info);
        emit(UserReadLoadedState(userBorrowStatus: userBorrowStatus));
      }
    }
    else {
      debugPrint("get0006");
      emit(ReadLoadingErrorState(message: 'لا يمكن اتمام العملية '));
    }
  }

  BookReadstatus(dynamic book) async
  {
    debugPrint("get01");
    emit(ReadLoadingState());

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
        emit(ReadLoadingErrorState(message: book_info));
      }
      else{
        this.localBookStatus = LocalBookStatus.fromJson(book_info);
        if(localBookStatus.statusId == 1){
          emit(BookReadLoadedState(localBookStatus: localBookStatus));
        }else if(localBookStatus.statusId == 0){
          emit(ReadLoadingErrorState(message: localBookStatus.status));
        }
        else{
          emit(ReadLoadingErrorState(message: 'الكتاب غير متاح حاليا'));
        }
      }
    }
    else {
      debugPrint("get0006");
      emit(ReadLoadingErrorState(message: 'لا يمكن اتمام العملية '));
    }
  }

  ReadLocalBook(dynamic userId,dynamic bookId) async
  {
    debugPrint("get01");
    emit(ReadLoadingState());
    String? token = await authApi.getToken();
    debugPrint(token);
    Map<String , dynamic> data = {
      'local_book_id' : bookId,
      'user_id' : userId
    };
    final read = await readBookApi.ReadLocalBook(data,token);
    debugPrint("get02");
    debugPrint(read.toString() );
    if(read != null){
      if(read == 500){
        emit(NoTokenState());
      }
      else {
        emit(ReadLoadedState(message: read.toString()));
       GetLibraryInfo();
      }
    }
    else {
      debugPrint("get0006");
      emit(ReadLoadingErrorState(message: 'لا يمكن اتمام العملية '));
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