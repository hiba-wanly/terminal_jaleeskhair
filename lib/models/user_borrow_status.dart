import 'package:jaleskhair/models/book_borrows.dart';

class UserBorrowStatus {
  late dynamic userId;
  late dynamic userName;
  late bool allowedToBorrow;
  late dynamic reason;
  late dynamic allowedToBorrowCount;
  late dynamic allBorrowsCount;
  late List<BookBorrows>? allBorrows;
  late dynamic currentBorrowsCount;
  late List<BookBorrows>? currentBorrows;
  late dynamic lateBorrowsCount;
  late List<BookBorrows>? lateBorrows;
/////
  late dynamic library;
  late dynamic userGrade;
  late dynamic userClass;
  late dynamic returnedBorrowsCount;
  late List<BookBorrows>? returnedBorrows;


  UserBorrowStatus({
    required this.userId,
    required this.userName,
    required this.allowedToBorrow,
    required this.reason,
    required this.allowedToBorrowCount,
    required this.allBorrowsCount,
    required this.allBorrows,
    required this.currentBorrowsCount,
    required this.currentBorrows,
    required this.lateBorrowsCount,
    required this.lateBorrows,
    required this.library,
    required this.userGrade,
    required this.userClass,
    required this.returnedBorrowsCount,
    required this.returnedBorrows
});

  UserBorrowStatus.fromJson(Map<String ,dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    allowedToBorrow = json['allowedToBorrow'];
    reason = json['reason'];
    allowedToBorrowCount = json['allowedToBorrowCount'];
    allBorrowsCount = json['allBorrowsCount'];
    // allBorrows = (json['allBorrows'] as List).map((e) => BookBorrows.fromJson(e)).toList();
    returnedBorrows = (json['returnedBorrows'] as List).map((e) => BookBorrows.fromJson(e)).toList();
    library = json['library'];
    userGrade = json['userGrade'];
    userClass = json['userClass'];
    returnedBorrowsCount = json['returnedBorrowsCount'];

    currentBorrowsCount = json['currentBorrowsCount'];
    currentBorrows = (json['currentBorrows'] as List).map((e) => BookBorrows.fromJson(e)).toList();
    lateBorrowsCount = json['lateBorrowsCount'];
    lateBorrows = (json['lateBorrows'] as List).map((e) => BookBorrows.fromJson(e)).toList();
  }

}

