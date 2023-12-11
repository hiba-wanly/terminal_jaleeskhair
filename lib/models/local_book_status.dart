class LocalBookStatus {
  late dynamic localBookId;
  late dynamic title;
  late dynamic globalBookEditionId;
  late dynamic canBorrow;
  late dynamic canBorrowStatus;
  late dynamic statusId;
  late dynamic status;
  late dynamic lastBorrowDate;
  late dynamic lastBorrowerName;
  late dynamic lastBorrowerGrade;
  late dynamic lastBorrowerClass;

  LocalBookStatus({
    required this.localBookId,
    required this.title,
    required this.globalBookEditionId,
    required this.canBorrow,
    required this.canBorrowStatus,
    required this.statusId,
    required this.status,
    required this.lastBorrowDate,
    required this.lastBorrowerName,
    required this.lastBorrowerGrade,
    required this.lastBorrowerClass
});

  LocalBookStatus.fromJson(Map<String ,dynamic> json) {
    localBookId = json['localBookId'];
    title = json['title'];
    globalBookEditionId = json['globalBookEditionId'];
    canBorrow = json['canBorrow'];
    canBorrowStatus = json['canBorrowStatus'];
    statusId = json['statusId'];
    status = json['status'];
    lastBorrowDate = json['lastBorrowDate'];
    lastBorrowerName = json['lastBorrowerName'];
    lastBorrowerGrade = json['lastBorrowerGrade'];
    lastBorrowerClass = json['lastBorrowerClass'];
  }
}