import 'package:jaleskhair/models/local_book_status.dart';
import 'package:jaleskhair/models/user_borrow_status.dart';

abstract class BorrowState {}

class InitBorrowState extends BorrowState {}

class BorrowLoadingState extends BorrowState {}

class BorrowLoadingErrorState extends BorrowState {
  final String message;
  BorrowLoadingErrorState({required this.message});
}

class UserBorrowLoadedState extends BorrowState {
  late UserBorrowStatus userBorrowStatus;
  UserBorrowLoadedState({required this.userBorrowStatus});
}

class BookBorrowLoadedState extends BorrowState {
  late LocalBookStatus localBookStatus;
  BookBorrowLoadedState({required this.localBookStatus});
}

class BorrowLoadedState extends BorrowState {
  final String message;
  BorrowLoadedState({required this.message});
}

class NoTokenState extends BorrowState {}
