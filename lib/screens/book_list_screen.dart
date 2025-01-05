import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book_list_model.dart';
import '../screens/book_detail_screen.dart';
import '../screens/book_registration_screen.dart';
import '../book.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('所持書籍リスト'),
      ),
      body: Consumer<BookListModel>(
        // ConsumerでBookListModelを監視
        builder: (context, bookList, _) {
          if (bookList.ownedBooks.isEmpty) {
            return const Center(child: Text('書籍が登録されていません'));
          }
          return ListView.builder(
            itemCount: bookList.ownedBooks.length,
            itemBuilder: (context, index) {
              final book = bookList.ownedBooks[index];
              return Dismissible(
                key: Key(book.title + book.author + book.publisher),
                onDismissed: (direction) {
                  Provider.of<BookListModel>(context, listen: false).removeBook(book);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${book.title}を削除しました")));
                },
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text(book.title),
                  subtitle: Text('${book.author} - ${book.publisher}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book), // bookオブジェクトを直接渡す
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final registeredBooks = await Navigator.push<List<Book>>(
            context,
            MaterialPageRoute(
              builder: (context) => const RegistrationScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
