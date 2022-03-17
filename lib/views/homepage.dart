import 'package:espspl/services/api/get_coinlist_home.dart';
import 'package:flutter/material.dart';
import '../globals/widgets/loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<CoinListResponse>? getCoinListApi;

  @override
  void initState() {
    getCoinListApi = getCoinlistHome(type: "All").then((value) {
      list = value.data;
      return value;
    });
    super.initState();
  }

  tapped({required String type}) {
    setState(() {
      getCoinListApi = getCoinlistHome(type: type).then((value) {
        list = value.data;
        return value;
      });
    });
  }

  bool isSearching = false;
  TextEditingController search = TextEditingController();
  List<Detail> filteredList = [];
  List<Detail> list = [];

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                onChanged: (text) {
                  setState(() {
                    filteredList = list
                        .where((element) => element.name.contains(search.text))
                        .toList();
                  });
                },
                controller: search,
                decoration: const InputDecoration(hintText: "Search here"),
              )
            : const Text("Swappful"),
        actions: [
          IconButton(
              onPressed: () {
                if (isSearching) {
                  tapped(type: "All");
                }
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: isSearching
                  ? const Icon(Icons.cancel)
                  : const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black26,
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      tapped(type: "All");
                    },
                    child: const Text("All")),
                ElevatedButton(
                    onPressed: () {
                      tapped(type: "Tradable");
                    },
                    child: const Text("Tradable")),
                ElevatedButton(
                    onPressed: () {
                      tapped(type: "Gainers");
                    },
                    child: const Text("Gainers")),
                ElevatedButton(
                    onPressed: () {
                      tapped(type: "Loosers");
                    },
                    child: const Text("Loosers")),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getCoinListApi,
              builder: (context, AsyncSnapshot<CoinListResponse> snapshot) {
                if (snapshot.hasData) {
                  if (!isSearching) {
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) =>
                            listItem(detail: list[index]));
                  } else {
                    return ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) =>
                            listItem(detail: filteredList[index]));
                  }
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                return loader();
              },
            ),
          ),
        ],
      ),
    );
  }

  listItem({required Detail detail}) => Card(
        elevation: 5,
        child: ListTile(
          leading: Image.network(detail.logo),
          title: Text(detail.symbol),
          subtitle: Text("${detail.name} ${detail.coinType}"),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("${detail.symbol} ${detail.tradingVolume}"),
              Text("${detail.feePercent}%"),
            ],
          ),
        ),
      );
}
