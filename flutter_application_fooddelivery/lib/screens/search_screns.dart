import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/models/items_category.dart';
import 'package:flutter_application_/providers/items_categorys.dart';
import 'package:flutter_application_/services/assets_manager.dart';
import 'package:flutter_application_/widgets/products/products_widget.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class SearchScreens extends StatefulWidget {
  static const routeName = "/SearchScreens";
  const SearchScreens({super.key});

  @override
  State<SearchScreens> createState() => _SearchScreensState();
}

class _SearchScreensState extends State<SearchScreens> {
  late TextEditingController txtsearch;
  List<ItemsCategoryModel> itemsListSearch = [];
  @override
  void initState() {
    txtsearch = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemCarts = Provider.of<ItemsCategory>(context);
    String? passesItems = ModalRoute.of(context)!.settings.arguments as String?;
    final List<ItemsCategoryModel> itemsList = passesItems == null
        ? itemCarts.getProducts
        : itemCarts.findByCategory(ctgName: passesItems);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TitleText(
            label: passesItems ?? "Search Food",
            fS: 20,
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.food),
          ),
        ),
        body: itemsList.isEmpty
            ? const Center(
                child: TitleText(
                  label: "No founds food",
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtsearch,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          IconlyLight.search,
                          color: Colors.blue,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              txtsearch.clear();
                              FocusScope.of(context).unfocus();
                            });
                          },
                          icon: Icon(
                            IconlyLight.closeSquare,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          itemsListSearch = itemCarts.searchQuery(
                              searchText: txtsearch.text,
                              passedList: itemsList);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          itemsListSearch = itemCarts.searchQuery(
                              searchText: txtsearch.text,
                              passedList: itemsList);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (txtsearch.text.isNotEmpty &&
                        itemsListSearch.isEmpty) ...[
                      const Center(
                        child: TitleText(
                          label: "No result found",
                          fS: 20,
                        ),
                      ),
                    ],
                    Expanded(
                      child: DynamicHeightGridView(
                          builder: (context, index) {
                            return ProductsWidget(
                                productId: txtsearch.text.isNotEmpty
                                    ? itemsListSearch[index].foodId
                                    : itemsList[index].foodId);
                          },
                          itemCount: txtsearch.text.isNotEmpty
                              ? itemsListSearch.length
                              : itemsList.length,
                          crossAxisCount: 2),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
