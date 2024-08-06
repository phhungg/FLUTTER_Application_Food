import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/providers/view_prod_provider.dart';
import 'package:flutter_application_/services/assets_manager.dart';
import 'package:flutter_application_/services/my_app_methods.dart';
import 'package:flutter_application_/widgets/empty_widgets.dart';
import 'package:flutter_application_/widgets/products/products_widget.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:provider/provider.dart';

class ViewRecent extends StatefulWidget {
  static const routeName = "/ViewRecently";
  const ViewRecent({super.key});

  @override
  State<ViewRecent> createState() => _ViewRecentState();
}

class _ViewRecentState extends State<ViewRecent> {
  late TextEditingController txtsearch;
  @override
  void initState() {
    txtsearch = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewrecent = Provider.of<ViewProdProvider>(context);
    return viewrecent.getViewProItems.isEmpty
        ? Scaffold(
            body: EmptyWidgets(
              imagePath: AssetsManager.recent,
              title: "You viewed recently is empty",
              subtitle:
                  "Looks like you didn\'t add anything yet to your cart \n go",
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitleText(
                  label:
                      "Recentlt view (${viewrecent.getViewProItems.length})"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.recent),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorOrWarningDialog(
                        isError: false,
                        context: context,
                        subtitle: "Remove Items",
                        fct: () {
                          viewrecent.clearWishList();
                          Navigator.pop(context);
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: viewrecent.getViewProItems.length,
              builder: ((context, index) {
                return ProductsWidget(
                    productId: viewrecent.getViewProItems.values
                        .toList()[index]
                        .productId);
              }),
              crossAxisCount: 2,
            ),
          );
  }
}
