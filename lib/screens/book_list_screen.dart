import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'book_detail_screen.dart';
import 'book_registration_screen.dart';
import 'package:provider/provider.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Map<String, dynamic>> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      final books = await ApiService.searchBooksByTitle(''); // 全書籍を取得するようなメソッドに変更するか、適切な引数を渡す
      setState(() {
        _books = books;
        _isLoading = false;
      });
    } catch (e) {
      // エラー処理
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('書籍情報の取得に失敗しました: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('書籍リスト'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return Card(
                  child: ListTile(
                    title: Text(book['title']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book), // 書籍データを渡す
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        // FABを追加
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegistrationScreen(), // RegistrationScreenへ遷移
            ),
          );
        },
        child: const Icon(Icons.add), // FABのアイコン
      ),
    );
  }
}
