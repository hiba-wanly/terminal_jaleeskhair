
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jaleskhair/login/server/login_server.dart';
import 'package:jaleskhair/models/local_book_status.dart';
import 'package:jaleskhair/models/user_borrow_status.dart';
import 'package:jaleskhair/returnbook/bloc/state_return.dart';
import 'package:jaleskhair/returnbook/serverreturn/server_return.dart';
import 'package:jaleskhair/server/user_book_status.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:jaleskhair/userInterface/datalayer/library_information.dart';
import 'package:jaleskhair/userInterface/server/library_information_server.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ReturnCubit extends Cubit<ReturnState> {

  ReturnCubit(ReturnState InitState) :super(InitState);

  static ReturnCubit get(context) => BlocProvider.of(context);

  UserBookStatus userBookStatus = UserBookStatus();
  ReturnBookApi returnBookApi = ReturnBookApi();
  AuthApi authApi = AuthApi();

  late UserBorrowStatus userBorrowStatus;
  late LocalBookStatus localBookStatus;
  LibraryInformationServer libraryInformationServer = LibraryInformationServer();
  late LibraryInformation libraryInformation;

  Bookreturnstatus(dynamic book) async
  {
    debugPrint("get01");
    emit(ReturnLoadingState());
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
        emit(ReturnLoadingErrorState(message: book_info));
      }
      else {
        this.localBookStatus = LocalBookStatus.fromJson(book_info);
        if(localBookStatus.status == "available"){
          emit(ReturnLoadingErrorState(message: localBookStatus.status+ " لا يمكن إعادة الكتاب " + localBookStatus.title + " لأنه " ));
        }
        else
          emit(BookReturnLoadedState(localBookStatus: localBookStatus));
      }
    }
    else {
      debugPrint("get0006");
      emit(ReturnLoadingErrorState(message: 'لا يمكن اتمام العملية '));
    }
  }

  ReturnLocalBook(dynamic bookId) async
  {
    debugPrint("get01");
    emit(ReturnLoadingState());
    String? token = await authApi.getToken();
    debugPrint(token);
    Map<String , dynamic> data = {
      'local_book_id' : bookId
    };
    final read = await returnBookApi.ReturnLocalBook(data,token);
    debugPrint("get02");
    debugPrint(read.toString() );
    if(read != null){
      if(read == 500){
        emit(NoTokenState());
      }
      else{
        emit(ReturnLoadedState(message: read.toString()));
        GetLibraryInfo();
      }
    }
    else {
      debugPrint("get0006");
      emit(ReturnLoadingErrorState(message: 'لا يمكن اتمام العملية  '));
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