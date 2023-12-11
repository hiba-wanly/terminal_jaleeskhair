class  LibraryInformation{
  late dynamic id;
  late dynamic libraryName;
  late dynamic currentUsersCount;
  late dynamic currentBooksCount;
  late dynamic currentBooksUniqueTitleCount;
  late dynamic borrowsAvg;
  late dynamic borrowsCount;
  late dynamic currentBorrowsCount;
  late dynamic booksToUsersRatio;
  late dynamic reservations;
  late dynamic statistics;
  late dynamic borrowsAvgPerDay;

  LibraryInformation({
   required this.id,
   required this.libraryName,
   required this.currentUsersCount,
   required this.currentBorrowsCount,
   required this.currentBooksUniqueTitleCount,
   required this.borrowsAvg,
   required this.borrowsCount,
   required this.currentBooksCount,
   required this.booksToUsersRatio,
   required this.reservations,
   required this.statistics,
   required this.borrowsAvgPerDay
});

  LibraryInformation.fromJson(Map<String ,dynamic> json) {
    id = json['id'];
    libraryName = json['libraryName'];
    currentUsersCount = json['currentUsersCount'];
    currentBooksCount = json['currentBooksCount'];
    currentBooksUniqueTitleCount = json['currentBooksUniqueTitleCount'];
    borrowsAvg = json['borrowsAvg'];
    borrowsCount = json['borrowsCount'];
    currentBorrowsCount = json['currentBorrowsCount'];
    booksToUsersRatio = json['booksToUsersRatio'];
    reservations = json['reservations'];
    statistics = json['statistics'];
    borrowsAvgPerDay = json['borrowsAvgPerDay'];
  }
}