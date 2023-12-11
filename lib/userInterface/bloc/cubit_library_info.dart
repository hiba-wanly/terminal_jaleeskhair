import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaleskhair/login/server/login_server.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:jaleskhair/userInterface/bloc/state_library_info.dart';
import 'package:jaleskhair/userInterface/datalayer/library_information.dart';
import 'package:jaleskhair/userInterface/server/library_information_server.dart';

class LibraryInformationCubit extends Cubit<LibraryInformationState> {
  LibraryInformationCubit(LibraryInformationState initialState)
      : super(initialState);

  static LibraryInformationCubit get(context) => BlocProvider.of(context);

  AuthApi authApi = AuthApi();
  LibraryInformationServer libraryInformationServer = LibraryInformationServer();
  late LibraryInformation libraryInformation;

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
          emit(LibraryInformationLoadedState(libraryInformation: libraryInformation));
      }
    }
    else {
      debugPrint("get0006");
      emit(LibraryInformationLoadingErrorState(message: 'لا يمكن اتمام العملية'));
    }
  }
}