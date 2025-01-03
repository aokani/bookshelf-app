import 'package:flutter/material.dart';
import '../services/api_service.dart'; // api_service.dartをインポート

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = []; // 型をdynamicに変更

  Future<void> _searchBooks() async {
    final title = _searchController.text;
    if (title.isNotEmpty) {
      final results = await ApiService.searchBooksByTitle(title);
      setState(() {
        _searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('書籍検索'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'タイトルを入力',
              ),
            ),
            ElevatedButton(
              onPressed: _searchBooks,
              child: const Text('検索'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final item = _searchResults[index];
                  return Card(
                    child: ListTile(
                      title: Text(item['title'] ?? 'タイトル不明'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('著者: ${item['author'] ?? '著者不明'}'), // creatorからauthorに変更
                          Text('出版社: ${item['publisher'] ?? '出版社不明'}'),
                          // filteringDataを表示しない
                          //Text('発行日: ${item['filteringData']['issued'] ?? '発行日不明'}'),
                          //Text('ジャンル: ${item['filteringData']['genre'] ?? 'ジャンル不明'}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
