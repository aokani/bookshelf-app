class Book {
  final String title;
  final String author;
  final String publisher;
  final Map<String, dynamic> filteringData;
  bool isSelected;

  Book({
    required this.title,
    required this.author,
    required this.publisher,
    required this.filteringData,
    this.isSelected = false,
  });

  // APIのレスポンスデータからBookオブジェクトを生成するファクトリコンストラクタ
  factory Book.fromApiData(Map<String, dynamic> data) {
    return Book(
      title: data['title'],
      author: data['author'],
      publisher: data['publisher'],
      filteringData: data['filteringData'],
    );
  }

  // デバッグ用toString
  @override
  String toString() {
    return 'Book{title: $title, author: $author, publisher: $publisher, filteringData: $filteringData, isSelected: $isSelected}';
  }
}
