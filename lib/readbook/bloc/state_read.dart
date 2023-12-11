import 'package:jaleskhair/models/local_book_status.dart';
import 'package:jaleskhair/models/user_borrow_status.dart';

abstract class ReadState {}

class InitReadState extends ReadState {}

class ReadLoadingState extends ReadState {}

class ReadLoadingErrorState extends ReadState {
  final String message;
  ReadLoadingErrorState({required this.message});
}

class UserReadLoadedState extends ReadState {
  late UserBorrowStatus userBorrowStatus;
  UserReadLoadedState({required this.userBorrowStatus});
}

class BookReadLoadedState extends ReadState {
  late LocalBookStatus localBookStatus;
  BookReadLoadedState({required this.localBookStatus});
}

class ReadLoadedState extends ReadState {
  final String message;
  ReadLoadedState({required this.message});
}

class NoTokenState extends ReadState {}
