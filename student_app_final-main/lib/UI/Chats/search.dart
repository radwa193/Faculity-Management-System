import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    Widget searchResultWidget;
    if (provider.recentSearchUsers.isEmpty) {
      searchResultWidget = Center(
        child: Image.asset('assets/images/icons/empty.png'),
      );
    } else {
      searchResultWidget = Center(
        child: Container(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back , color: Colors.orange,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Row(
          children: [
            Text(
              'Search',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: const Color(0xffCCCCCC),
                      strokeAlign: BorderSide.strokeAlignInside,
                      width: 1.5
                  ),
                ),
                child:  const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.orange),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: Color(0x9906004f),
                                fontWeight: FontWeight.w400
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height : 10),
              const Row(
                children: [
                  Text(
                    'Recent Search',
                    style: TextStyle(
                      color: Color(0xff2B3139),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Clear All',
                    style: TextStyle(
                      color: Color(0xffEF4444),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.recentSearchUsers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image(
                        image : AssetImage('assets/images/icons/Clock.png'),
                      ),
                      title: Text(provider.recentSearchUsers[index].name!),
                      trailing:  InkWell(
                        onTap: () {
                          // provider.removeRecentSearchUser(index);
                        },
                        child: Image(
                          image : AssetImage('assets/images/icons/Cross.png'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: searchResultWidget,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
