import 'package:flutter/material.dart';
import '../book.dart';

class BookListModel extends ChangeNotifier {
  final List<Book> _ownedBooks = [];

  List<Book> get ownedBooks => _ownedBooks;

  void addBook(Book book) {
    if (!_ownedBooks.any((ownedBook) => ownedBook.title == book.title && ownedBook.author == book.author && ownedBook.publisher == book.publisher)) {
      _ownedBooks.add(book);
      notifyListeners();
    }
  }

  void removeBook(Book book) {
    _ownedBooks.removeWhere((ownedBook) => ownedBook.title == book.title && ownedBook.author == book.author && ownedBook.publisher == book.publisher);
    notifyListeners();
  }
}
