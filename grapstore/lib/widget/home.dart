import 'package:flutter/material.dart';
import '/env/config.dart';

class HomeWidget extends StatelessWidget {
  var _data = [];
  bool isLoaded = false;

  HomeWidget(this._data, this.isLoaded);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
        child: feedColumn(),
      ),
    );
  }

  Widget feedColumn() {
    if (isLoaded) {
      return ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => viewProduct(context, _data[index]['id'].toString()),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Theme.of(context).colorScheme.surface,
                  child: Image.network(
                    '${Config.CDNAddr}/product/${_data[index]["id"]}/0.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_data[index]["p_name"]}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${_data[index]["currency_symbol"] + _data[index]["p_price"]}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.green[300],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '${_data[index]["p_description"]}',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 8,
            indent: 115,
          );
        },
        itemCount: _data.length,
      );
    } else {
      return const Center(
        child: Text('Loading...'),
      );
    }
  }

  void viewProduct(context, String id) {
    Navigator.pushNamed(context, '/product', arguments: id);
  }
}
