import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_/consts/app_containts.dart';
import 'package:flutter_application_/providers/items_categorys.dart';
import 'package:flutter_application_/services/assets_manager.dart';
import 'package:flutter_application_/widgets/app_name.dart';
import 'package:flutter_application_/widgets/products/cart_rounded.dart';
import 'package:flutter_application_/widgets/products/last_arrival.dart';
import 'package:flutter_application_/widgets/title_text.dart';
import 'package:provider/provider.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ItemsCategory>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppName(),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.hello),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.31,
                child: Swiper(
                  itemBuilder: (context, index) {
                    return Image.asset(AppContaints.bannerIamges[index]);
                  },
                  itemCount: AppContaints.bannerIamges.length,
                  autoplay: true,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const TitleText(
                label: "Last Vouchers",
                fS: 20,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                        value: cartProvider.getProducts[index],
                        child: const LastArrival());
                  },
                ),
              ),
              TitleText(
                label: "Foods",
                fS: 18,
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children:
                    List.generate(AppContaints.categoryList.length, (index) {
                  return CartRounded(
                    image: AppContaints.categoryList[index].images,
                    name: AppContaints.categoryList[index].name,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
