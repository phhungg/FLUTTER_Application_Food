import 'package:flutter/material.dart';
import 'package:flutter_application_/models/items_category.dart';
import 'package:uuid/uuid.dart';

class ItemsCategory with ChangeNotifier {
  List<ItemsCategoryModel> get getProducts {
    return _items;
  }

  ItemsCategoryModel? findByFoodid(String foodId) {
    if (_items.where((element) => element.foodId == foodId).isEmpty) {
      return null;
    }
    ;
    return _items.firstWhere((element) => element.foodId == foodId);
  }

  List<ItemsCategoryModel> findByCategory({required String ctgName}) {
    List<ItemsCategoryModel> ctgList = _items
        .where(
          (element) => element.foodCategory.toLowerCase().contains(
                ctgName.toLowerCase(),
              ),
        )
        .toList();
    return ctgList;
  }

  List<ItemsCategoryModel> searchQuery(
      {required String searchText,
      required List<ItemsCategoryModel> passedList}) {
    List<ItemsCategoryModel> searchList = passedList
        .where((element) =>
            element.foodTitle.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  final List<ItemsCategoryModel> _items = [
    //Hamburger
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Lamb burger with Indian spices and mint yogurt sauce',
      foodPrice: '9.00',
      foodCategory: 'Hamburgers',
      foodDescription:
          'The filling is made from field-raised lamb, the lean shoulder meat contains 2/3 less fat than super-raised lamb. To make the meat tastier, you should grind it into smaller pieces before processing.',
      foodImage:
          'https://i1-giadinh.vnecdn.net/2013/06/13/burger-1-1371112114.jpg?w=680&h=0&q=100&dpr=1&fit=crop&s=dqWhgkWQl_5E7vGDE-lXgw',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'American burger',
      foodPrice: '9.00',
      foodCategory: 'Hamburgers',
      foodDescription:
          'Americas great burgers have become as heavy as wrestlers in recent times. Among fast food and expensive restaurant chains, it is almost absolutely huge.',
      foodImage:
          'https://www.thespruceeats.com/thmb/vf61j0CDD-RYdis4LVqmBV5NDzU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/all-american-burgers-480989-hero-05-6d4542f5661c4fd6889c16a445478e0c.jpg',
      foodQuanlity: '10',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Turkey burger with cranberry and peach chili sauce',
      foodPrice: '9.00',
      foodCategory: 'Hamburgers',
      foodDescription:
          'Enjoy the flavors of Thanksgiving all year long with a turkey burger. For meat, you should choose free-range turkey breast, this is white meat with very little fat and calories. Served with dried vegetables and red grapes',
      foodImage:
          'https://img-global.cpcdn.com/recipes/c2058741ebedddfc/680x482cq70/burger-nguyen-cam-k%E1%BA%B9p-ga-tay-gia-v%E1%BB%8B-y-recipe-main-photo.jpg',
      foodQuanlity: '5',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'German Style Burger with Feta Aioli',
      foodPrice: '9.00',
      foodCategory: 'Hamburgers',
      foodDescription:
          'This burger is stuffed with bell peppers and grilled lettuce for a German flavor. German food is famous for its healthy ingredients such as vegetables and olive oil. Therefore these burgers are a healthier alternative to traditional burgers.',
      foodImage:
          'https://vcdn1-giadinh.vnecdn.net/2013/06/13/burger-15-1371112119.jpg?w=460&h=0&q=100&dpr=2&fit=crop&s=1bzjtjzXrkuZIenuoSFe-Q',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Turkey burger with grilled eggplant',
      foodPrice: '5.00',
      foodCategory: 'Hamburgers',
      foodDescription:
          'Beef and other red meat contain a mixture called glutamate. Soy sauce and marmite, a powerful leavening agent sold in supermarkets (Australians love Vegemite), contain this substance, and adding a little to the turkey will give the burger an umami meaty taste.',
      foodImage:
          'https://skinnyms.com/wp-content/uploads/2018/02/How-to-Make-Mediterranean-Grilled-Eggplant-Burgers-with-Cheese-Recipe-3-1200x797.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Blue cheese burger',
      foodPrice: '9.00',
      foodCategory: 'Hamburgers',
      foodDescription:
          'A traditional hamburger will become more delicious when you add onions, some bread and egg whites to the meat. Using muffins, which are usually smaller than ravioli, blue cheese and meat become the main flavors of the dish. You can use shredded Swiss Cheddar cheese if you do not like blue cheese.',
      foodImage:
          'https://hips.hearstapps.com/del.h-cdn.co/assets/17/16/1600x1200/sd-aspect-1492695774-blue-cheese-burger.jpg?resize=1200:*',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Salmon burger',
      foodPrice: '9.00',
      foodCategory: 'Hamburgers',
      foodDescription:
          'This delicious and diet burger proves that salmon can be just as delicious as beef provided you use the correct mixture. Beef can be mixed together to form a patty, but salmon is too soft to form a patty like beef. In addition, if mixed with breadcrumbs or eggs, it can remove the smell of salmon. Solution: For the best taste, mix ¼ salmon with 1 layer of pate to create 1 delicious piece of salmon..',
      foodImage:
          'https://www.acouplecooks.com/wp-content/uploads/2021/03/Salmon-Burger-003.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Korean grilled burger',
      foodPrice: '2.50',
      foodCategory: 'Hamburgers',
      foodDescription:
          'The ingredients of the traditional burger can be varied by changing the toppings such as spicy kimchi, sirracha, crispy napa cabbage or water chestnut. Can be used with kimchi, pickles and noodles to enjoy the authentic Korean flavor.',
      foodImage:
          'https://thecozyapron.com/wp-content/uploads/2015/06/korean-bbq-burger_thecozyapron_06-26-15_1.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle:
          'Spicy Poblano Burger with pickled red onions and chipotle cream',
      foodPrice: '15.0',
      foodCategory: 'Hamburgers',
      foodDescription:
          'The burger with lean beef is a combination of panade, bread and meatballs soaked in milk to make them soft and moist. Sometimes in the mix are savory flavors commonly found in Mexican chorizo, like coriander, paprika and cumin.There is also a creamy smoked poblano sauce, and finally a piece of pickled red onion for a wonderful flavor. This vinegared onion recipe is not just for one batch but can be kept for several weeks in the refrigerator. You can use it for sandwiches or salads or for your next batch of poblano burgers.',
      foodImage:
          'https://cdn.pixabay.com/photo/2016/08/31/21/47/burger-1634705_960_720.jpg',
      foodQuanlity: '20',
    ),

    //Desserts
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Lemon tart',
      foodPrice: '20.0',
      foodCategory: 'Desserts',
      foodDescription:
          'Yellow lemon tart is a classic French cake with main ingredients being flour, eggs, grated lemon peel, unsalted butter, heavy cream... with 3 parts of crust, filling and cream layer.',
      foodImage:
          'https://www.recipetineats.com/uploads/2021/06/French-Lemon-Tart_5-main.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Apple crumble',
      foodPrice: '15.0',
      foodCategory: 'Dwsserts',
      foodDescription:
          'This is a type of cake originating from England. Today Apple crumble is transformed into many different versions but all have the common characteristics of a crispy crust, radiating the aroma of butter and the sweet taste of fresh apples.',
      foodImage:
          'https://hips.hearstapps.com/hmg-prod/images/delish-091621-apple-crumb-pie-02-jg-1632846997.jpg?crop=1xw:0.843956043956044xh;center,top&resize=1200:*',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Crêpe',
      foodPrice: '9.00',
      foodCategory: 'Desserts',
      foodDescription:
          'When serving Crêpe as a dessert, it will be sprinkled on top with a layer of Nutella (liquid chocolate + butter + sugar) and fresh fruits.',
      foodImage:
          'https://www.allrecipes.com/thmb/qLWCKWuNr0v1NdjM-OzFIiOXAfk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/16383-basic-crepes-mfs_002-a07ca6b699e443ee9643034c225a4cfb.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Chocolate mousse',
      foodPrice: '40.0',
      foodCategory: 'Desserts',
      foodDescription:
          'This is a typical dessert of French cuisine, made from two main ingredients: chocolate and egg whites.',
      foodImage:
          'https://www.sugarsaltmagic.com/wp-content/uploads/2020/10/Eggless-Easy-Chocolate-Mousse-8FEATURED-500x500.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Pudding',
      foodPrice: '9.00',
      foodCategory: 'Desserts',
      foodDescription:
          'Pudding is a sweet dessert but in Latin it means “small sausage”. Some popular types of pudding are: milk pudding, egg pudding, mango pudding, green tea pudding, strawberry milk pudding...',
      foodImage:
          'https://www.huongnghiepaau.com/wp-content/uploads/2019/01/pudding-la-gi.jpg',
      foodQuanlity: '20',
    ),
    //Coffee
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Espresso',
      foodPrice: '18.0',
      foodCategory: 'Coffees',
      foodDescription:
          'A very popular type of coffee in Italy and Spain; is brewed by forcing water under high pressure to flow through a quantity of extremely finely ground coffee. The result will be 25 - 30ml of drink with a layer of coffee oil cream with a dark yellow brown color (people call it crema) 5mm thick on the surface. A genuine cup of Espresso will have a very strong taste and will have a layer of fragrant crema on top without being bitter.',
      foodImage: 'https://mediamart.vn/images/uploads/data-2022/ghj-2Y33P1.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Cappuccino',
      foodPrice: '18.0',
      foodCategory: 'Coffees',
      foodDescription:
          'Also originating from Italy, a standard Cappuccino will consist of 3 equal parts, which are: Espresso coffee mixed with double the amount of water (Espresso Lungo), hot milk and foamed milk. Next, sprinkle some cocoa powder or cinnamon powder on top, then use a mold, spoon or toothpick to stir/draw to create a shape for your product, it can be a heart shape, leaf shape, cloud shape, etc. eye-catching.',
      foodImage: 'https://mediamart.vn/images/uploads/data-2022/ghj-c1x3LL.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Cafe Latte',
      foodPrice: '14.0',
      foodCategory: 'Coffees',
      foodDescription:
          'Cafe Latte simply means coffee and milk. For non-connoisseur drinkers, it is easy to confuse Cafe Latte with Cappuccino because these two types share the same 3 main ingredients. However, the difference is that when making Coffee Latte, people only add half the amount of hot milk; instead of making it equal like making Cappuccino. An Espresso is prepared with milk and milk powder in a 200ml glass or cup at a temperature of 600 and then add 0.5 - 1cm of milk powder on the surface.',
      foodImage: 'https://mediamart.vn/images/uploads/data-2022/ghj-t07H8J.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Traditional cafe',
      foodPrice: '12.0',
      foodCategory: 'Coffees',
      foodDescription:
          'Coffee is the most popular and chosen drink today. Black coffee, milk coffee are prepared from pure coffee beans from the land of Robusta, Arabica or weasel coffee,... are considered strong traditional coffee. Depending on the needs and preferences, diners can choose a cup of coffee brewed directly or pre-brewed and then drink hot or with ice. Those who love pure coffee often choose a cup of black coffee without sugar, or can add 1-2 teaspoons of sugar. Those who like sweet, fragrant aroma will ask for a rich, sweet cup of milk coffee.',
      foodImage: 'https://mediamart.vn/images/uploads/data-2022/ghj-BOsK1B.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Latte Macchiato',
      foodPrice: '25.0',
      foodCategory: 'Coffees',
      foodDescription:
          'Latte Macchiato (Latte) is a type of hot coffee consisting of Espresso coffee and milk. Basically, Latte is like milk coffee but sweeter. A properly mixed Latte Macchiato must consist of 3 distinct layers, poured in the prescribed order and not mixed together; includes: milk is poured into the first cup, at the bottom of the cup, creating the lowest white layer; then milk powder on the top layer; Finally, pour Espresso through the milk foam layer to the second layer. Sprinkle on the milk foam layer with a little cocoa powder, chocolate or cinnamon powder to decorate and you are done.',
      foodImage: 'https://mediamart.vn/images/uploads/data-2022/ghj-x1KMG4.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Cafe Mocha',
      foodPrice: '27.0',
      foodCategory: 'Coffees',
      foodDescription:
          'Coffee Mocha is a mixture of Espresso coffee mixed with steam and hot chocolate. The characteristics of this drink are the rich aroma of fresh cream and the rich taste of hot chocolate. Pour Espresso mixed with hot milk chocolate powder directly into the center of the cup gently and carefully so as not to break the delicious layer of coffee. Finally, decorate the surface with cocoa powder or chocolate.',
      foodImage: 'https://mediamart.vn/images/uploads/data-2022/ghj-BCe85n.jpg',
      foodQuanlity: '20',
    ),
//Drinks
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Wine',
      foodPrice: '58.0',
      foodCategory: 'Drinks',
      foodDescription:
          'There are many types of wine, of which wine made from grapes is always loved by Americans. This wine attracts tourists because of its eye-catching purple color and luxurious bottle. Enjoying this wonderful drink with your family during a trip to the US is an ideal choice.',
      foodImage:
          'https://dulichmy.com.vn/wp-content/uploads/2021/11/nhung-thuc-uong-1.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Whisky wine',
      foodPrice: '18.0',
      foodCategory: 'Drinks',
      foodDescription:
          'In American cuisine, wine plays an important role. Americans often tend to try pairing similar or contrasting wines and dishes to get new taste experiences. Among the wines of the "Land of Flowers", Whiskey is quite popular. Whiskey in the US also has many types such as: Jim Beam, Labrot & Graham, Wild Turkey, Bernheim Original, Four Roses, Buffalo Trace, Jack Daniel is, George Dickel.',
      foodImage:
          'https://dulichmy.com.vn/wp-content/uploads/2021/11/nhung-thuc-uong-17.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Cocktail',
      foodPrice: '48.0',
      foodCategory: 'Drinks',
      foodDescription:
          'Cocktail is a drink consisting of wine mixed with wine, or with fruit juice or carbonated water. Initially, people used some crushed aromatic leaves or lemon juice to drink with wine to add a pleasant flavor. Gradually, due to the need for diversification, this drink was mixed with many different drinks to into cocktails.',
      foodImage:
          'https://dulichmy.com.vn/wp-content/uploads/2021/11/nhung-thuc-uong-2-1.jpg',
      foodQuanlity: '20',
    ),
    //Salads
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Squid salad',
      foodPrice: '11.0',
      foodCategory: 'Salads',
      foodDescription:
          'Squid salad with simple preparation but brings great flavor and is extremely refreshing, eye-catching color, added with a faint aroma from roasted sesame, sweet and crispy vegetables mixed with the crunchiness from fried squid. attractive. When eating salad, you sprinkle a little sauce on it to create a harmonious sour taste, helping to add flavor to our salad.',
      foodImage: 'https://cdn.tgdd.vn/2021/04/content/r2-800x500-1.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Scallop salad',
      foodPrice: '38.0',
      foodCategory: 'Salads',
      foodDescription:
          'Add to the menu an extremely attractive, delicious and nutritious scallop salad to make the meal no longer boring. A unique dish with a unique combination of extremely fresh seafood and vegetables. When you eat it, you will feel the fresh taste of the scallops, slowly the mild spiciness of the chili and the sour taste of the tomatoes will melt on the tip of your tongue. This salad not only satisfies the taste buds but is also very beautiful with red and green colors mixed together.',
      foodImage: 'https://cdn.tgdd.vn/2021/04/content/r3-800x500-1.jpg',
      foodQuanlity: '20',
    ),
    //Spaghetti
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Linguine',
      foodPrice: '108.0',
      foodCategory: 'Spaghettis',
      foodDescription:
          'If Spaghetti noodles are thick and round, Linguine noodles are long but thin, rolled flat so they are wider. Because they are rolled thinly, in Italian they also mean "little tongues". Linguine has a slightly lighter taste than Spaghetti, suitable for preparing with seafood dishes, mixed with white wine sauce and clams or mussels. In addition, you can try combining Linguine with traditional cream-based sauces or pesto sauces,',
      foodImage:
          'https://images.themodernproper.com/billowy-turkey/production/posts/2022/Linguine-witih-Lemon-Garlic-Sauce-6.jpeg?w=960&h=720&q=82&fm=jpg&fit=crop&dm=1648430386&s=2abdd268813508159ade06a518d98d75',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Cannelloni',
      foodPrice: '208.0',
      foodCategory: 'Spaghettis',
      foodDescription:
          'Cannelloni are sheets of pasta. To make it easier to imagine, you can compare them to crepes, which are then rolled into tubes. The inside of the tube is hollow so that when processing, you can stuff it with filling. Common fillings used include beef, ricotta cheese, spinach... The cannelloni is then covered with light sauces such as tomato or cream before being grilled deliciously.',
      foodImage:
          'https://www.southernliving.com/thmb/cKu-8mquQ6QIyO1zqEuV9kKIlHw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/chicken-cannelloni-with-roasted-red-bell-pepper-sauce_batch7335_3x2-136-abe48c9f40e04ea8a2abe4b98b4038b1.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Penne',
      foodPrice: '408.0',
      foodCategory: 'Spaghetti',
      foodDescription:
          'Penne is also a type of spaghetti with a round, hollow cylindrical structure, cut diagonally at both ends in many different sizes. The Penne surface can be smooth or ribbed to easily hold thick or creamy sauces on top.',
      foodImage:
          'https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/c1082b98-ce28-44db-902f-d634925c7b88/Derivates/ae1c2fdf-d344-4897-831c-a96046065320.jpg',
      foodQuanlity: '20',
    ),
    //Ice Cream
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Gelato ice cream, Italy',
      foodPrice: '50.0',
      foodCategory: 'Ice Creams',
      foodDescription:
          'Considered one of the most delicious ice creams in the world, Gelato has a smooth, creamy texture but is not greasy. Gelato is diverse flavors will surely satisfy every diner.',
      foodImage:
          'https://gcs.tripi.vn/public-tripi/tripi-feed/img/473637BvK/kem-gelato-y-62623.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'Helado Ice Cream, Argentina',
      foodPrice: '188.0',
      foodCategory: 'Ice Creams',
      foodDescription:
          'The special thing about Helado is that it does not use preservatives, maintaining its attractive freshness. If you are a lover of fresh ice cream, enjoy the unique and delicious flavors of Helado Ice Cream. From traditional ice cream like milk, coconut, chocolate, green tea to unique flavors like coffee, red bean, lemon butter, mango, jackfruit,...',
      foodImage:
          'https://gcs.tripi.vn/public-tripi/tripi-feed/img/473637WZF/kem-helado-argentina-62653.jpg',
      foodQuanlity: '20',
    ),
    //SandWiches
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'egg sandwich',
      foodPrice: '39.0',
      foodCategory: 'Sandwiches',
      foodDescription:
          'The egg sandwich is fragrantly fried with a beautiful golden color. The slice of cake is crispy on the outside, soft and chewy on the inside with the rich, fatty taste of eggs. Served with a little lettuce and tomato, it is enough energy for the new day.',
      foodImage:
          'https://www.simplyrecipes.com/thmb/5KEzbHplXxqFntM-jqrI0QdExR4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Easy-Egg-Salad-Sandwich-LEAD-22-8ecbb89abda34a84b649ff4c44bab525.JPG',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'tuna sandwich',
      foodPrice: '39.0',
      foodCategory: 'Sandwiches',
      foodDescription:
          'The sandwich is decorated with an eye-catching appearance. When you eat it, you will feel the chewy and soft taste of the bread mixed with delicious fatty tuna, sweet meat, soaked in extremely delicious spices.',
      foodImage:
          'https://whisperofyum.com/wp-content/uploads/2023/03/easy-tuna-sandwich-recipe.jpg',
      foodQuanlity: '20',
    ),
    ItemsCategoryModel(
      foodId: const Uuid().v4(),
      foodTitle: 'chicken sandwich',
      foodPrice: '90.0',
      foodCategory: 'Sandwiches',
      foodDescription:
          'The outside slice of bread is evenly coated with a rich, fragrant mayonnaise sauce. Inside is a soft, chewy chicken filling, sweet and juicy without being dry, rich in spices, and served with a little chili sauce or tomato sauce, there is nothing more appealing than that.',
      foodImage:
          'https://static01.nyt.com/images/2021/07/06/dining/yk-muhammara-chicken-sandwiches/merlin_189026502_58171dd4-b0bc-47c3-aa6a-d910a3f1de4c-superJumbo.jpg',
      foodQuanlity: '20',
    ),
  ];
}
