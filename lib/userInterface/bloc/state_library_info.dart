import 'package:jaleskhair/userInterface/datalayer/library_information.dart';

abstract class LibraryInformationState {}

class InitLibraryInformationState extends LibraryInformationState {}

class LibraryInformationLoadingState extends LibraryInformationState {}

class LibraryInformationLoadingErrorState extends LibraryInformationState {
  final String message;
  LibraryInformationLoadingErrorState({required this.message});
}

class LibraryInformationLoadedState extends LibraryInformationState {
  late LibraryInformation libraryInformation;
  LibraryInformationLoadedState({required this.libraryInformation});
}

class NoTokenStateLibrary extends LibraryInformationState {}
