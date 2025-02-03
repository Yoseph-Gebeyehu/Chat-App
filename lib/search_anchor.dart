import 'package:flutter/material.dart';

class Goods {
  final int id;
  final String title;
  final String imageUrl;

  Goods({required this.id, required this.title, required this.imageUrl});
}

class GoodsSearch extends StatefulWidget {
  @override
  _GoodsSearchState createState() => _GoodsSearchState();
}

class _GoodsSearchState extends State<GoodsSearch> {
  List<Goods> goodsList = [
    Goods(id: 1, title: 'Good 1', imageUrl: 'https://via.placeholder.com/150'),
    Goods(id: 2, title: 'Good 2', imageUrl: 'https://via.placeholder.com/150'),
    Goods(id: 3, title: 'Good 3', imageUrl: 'https://via.placeholder.com/150'),
    Goods(id: 4, title: 'Good 4', imageUrl: 'https://via.placeholder.com/150'),
    Goods(id: 5, title: 'Good 5', imageUrl: 'https://via.placeholder.com/150'),
    Goods(id: 6, title: 'Good 6', imageUrl: 'https://via.placeholder.com/150'),
    Goods(id: 7, title: 'Good 7', imageUrl: 'https://via.placeholder.com/150'),
    Goods(id: 8, title: 'Good 8', imageUrl: 'https://via.placeholder.com/150'),
    Goods(id: 9, title: 'Good 9', imageUrl: 'https://via.placeholder.com/150'),
  ];

  String query = '';
  final SearchController _controller = SearchController();
  final List searchHistory = [];
  @override
  Widget build(BuildContext context) {
    List<Goods> filteredGoods = goodsList
        .where(
            (goods) => goods.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Goods Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchAnchor(
              viewHintText: 'Search goods',
              viewTrailing: [
                IconButton(
                  onPressed: () {
                    searchHistory.add(_controller.text);
                    _controller.closeView(_controller.text);
                  },
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {
                    _controller.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
              searchController: _controller,
              builder: (context, controller) {
                return SearchBar(
                  controller: controller,
                  hintText: 'Search goods',
                  onTap: () => controller.openView(),
                );
              },
              viewOnSubmitted: (String value) {
                setState(() {
                  query = value;
                });
              },
              suggestionsBuilder: (context, controller) {
                return goodsList
                    .where((goods) => goods.title
                        .toLowerCase()
                        .contains(controller.text.toLowerCase()))
                    .map((goods) {
                  String highlightedText = controller.text;
                  String remainingText =
                      goods.title.substring(highlightedText.length);
                  return ListTile(
                    title: RichText(
                      text: TextSpan(
                        text: highlightedText,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: remainingText,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        query = goods.title;
                        _controller.text = goods.title;
                      });
                    },
                  );
                }).toList();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredGoods.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(filteredGoods[index].imageUrl),
                  title: Text(filteredGoods[index].title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
