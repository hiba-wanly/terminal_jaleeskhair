import 'package:jaleskhair/models/local_book_status.dart';

abstract class ReturnState {}

class InitReturnState extends ReturnState {}

class ReturnLoadingState extends ReturnState {}

class ReturnLoadingErrorState extends ReturnState {
  final String message;
  ReturnLoadingErrorState({required this.message});
}

class BookReturnLoadedState extends ReturnState {
  late LocalBookStatus localBookStatus;
  BookReturnLoadedState({required this.localBookStatus});
}

class ReturnLoadedState extends ReturnState {
  final String message;
  ReturnLoadedState({required this.message});
}

class NoTokenState extends ReturnState {}

