class BookBorrows {
  late dynamic library;
  late dynamic borrowerName;
  late dynamic grade;
  late dynamic classS;
  late dynamic localBookId;
  late dynamic localBookName;
  late dynamic pages;
  late dynamic localBookBarcode;
  late dynamic borrowStartDate;
  late dynamic expectedReturnDate;
  late dynamic realReturnDate;
  late dynamic returned;
  late dynamic late;

  BookBorrows({
    required this.library,
    required this.borrowerName,
    required this.grade,
    required this.classS,
    required this.localBookId,
    required this.localBookName,
    required this.pages,
    required this.localBookBarcode,
    required this.borrowStartDate,
    required this.expectedReturnDate,
    required this.realReturnDate,
    required this.returned,
    required this.late
});

  BookBorrows.fromJson(Map<String ,dynamic> json) {
    // library = json['library'];
    // borrowerName = json['borrowerName'];
    // grade = json['grade'];
    // classS = json['class'];
    localBookId = json['localBookId'];
    localBookName = json['localBookName'];
    pages = json['pages'];
    localBookBarcode = json['localBookBarcode'];
    borrowStartDate = json['borrowStartDate'];
    expectedReturnDate = json['expectedReturnDate'];
    realReturnDate = json['realReturnDate'];
    returned = json['returned'];
    late = json['late'];
  }

}