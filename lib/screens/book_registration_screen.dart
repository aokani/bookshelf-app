import 'package:flutter/material.dart';
import '../models/book_list_model.dart';
import '../services/api_service.dart';
import '../book.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String searchText = '';
  List<Book> searchResults = [];
  List<Book> registeredBooks = [];
  bool _isLoading = false; // ローディング状態の管理

  Future<void> _searchBooks() async {
    if (searchText.isEmpty) return;

    setState(() {
      _isLoading = true; // ローディング開始
    });

    final results = await ApiService.searchBooksByTitle(searchText);
    setState(() {
      searchResults = results.map((data) => Book.fromApiData(data)).toList();
      _isLoading = false; // ローディング終了
    });
  }

  void _registerBooks() {
    setState(() {
      for (final book in searchResults) {
        if (book.isSelected && !registeredBooks.any((b) => b.title == book.title)) {
          registeredBooks.add(book);
        }
      }

      //登録後に選択状態をリセット
      for (final book in searchResults) {
        book.isSelected = false;
      }

      print(registeredBooks);

      Navigator.pop(context, registeredBooks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (text) => setState(() => searchText = text),
          decoration: const InputDecoration(hintText: '検索キーワードを入力'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _searchBooks,
          ),
        ],
      ),
      body: _isLoading // ローディング中はプログレスインジケーターを表示
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final book = searchResults[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            book.isSelected = !book.isSelected;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          color: book.isSelected ? Colors.blue[100] : null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 自動スクロール部分
                              LayoutBuilder(
                                // 幅を取得するためにLayoutBuilderでラップ
                                builder: (context, constraints) {
                                  if (book.title.length * 16 > constraints.maxWidth) {
                                    // 文字列の幅がmaxWidthを超えている場合のみスクロール
                                    return SizedBox(
                                      height: 20, // 行の高さ
                                      child: Marquee(
                                        text: book.title,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        scrollAxis: Axis.horizontal,
                                        blankSpace: 20.0,
                                        velocity: 50.0, // スクロール速度
                                        pauseAfterRound: const Duration(seconds: 1), // 停止時間
                                        startPadding: 10.0,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      // 短い場合はそのまま表示
                                      book.title,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 8), // タイトルと情報部分の間にスペース
                              Row(
                                // 出版社と著者を横に配置
                                children: [
                                  Expanded(
                                    // 出版社を左寄せ
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        book.publisher,
                                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    // 著者を右寄せ
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        book.author,
                                        textAlign: TextAlign.end,
                                        maxLines: 2, // 必要に応じて変更
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: searchResults.isEmpty
                      ? null
                      : () {
                          for (final book in searchResults) {
                            if (book.isSelected) {
                              Provider.of<BookListModel>(context, listen: false).addBook(book);
                            }
                          }
                          Navigator.pop(context); // 画面を閉じる
                        },
                  child: const Text('登録'),
                ),
              ],
            ),
    );
  }
}
