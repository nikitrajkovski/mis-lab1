import 'package:flutter/material.dart';
import './models/shopping_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '211060',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Онлајн продавница на 211060'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ShoppingItem> clothes = [
    ShoppingItem(
      name: 'Маица',
      image: 'https://uk.bape.com/cdn/shop/files/001TEJ801010_BKG_A.jpg?v=1697797518&width=1200',
      description: 'Црна маица со црвена шара',
      price: 250.00,
    ),
    ShoppingItem(
      name: 'Панталони',
      image: 'https://content.woolovers.com/img/747x856/63967_j279l_black_w_62.jpg',
      description: 'Црни панталони на врчка',
      price: 100.00,
    ),
    ShoppingItem(
      name: 'Јакна',
      image: 'https://thursdayboots.com/cdn/shop/products/1024x1024-Mens-Jackets-Denim-Trucker-WashedIndigo-010423-1_1024x1024.jpg?v=1673282143',
      description: 'Тексас палто',
      price: 300.00,
    ),
    ShoppingItem(
      name: 'Патики',
      image: 'https://www.sportvision.mk/files/thumbs/files/images/slike_proizvoda/media/WS3/WS327GA/images/thumbs_1200/WS327GA_1200_1200px.jpg',
      description: 'New Balance 327 (бели со зелено лого)',
      price: 100.00,
    ),
    ShoppingItem(
      name: 'Часовник',
      image: 'https://www.mytime.mk/files/watermark/files/images/product/thumbs_w/27639_w_1200_1200px.jpg',
      description: 'Seiko 5 Sport часовник',
      price: 1000.00,
    ),
  ];

  void _addNewClothingItem() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    double? getPrice() {
      final numericString =
      priceController.text.replaceAll(RegExp(r'[^0-9\.]'), '');
      if (numericString.isEmpty) return 0;
      return double.tryParse(numericString);
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Додади нов продукт"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Име'),
                ),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'УРЛ до сликата'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Опис'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Цена'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Откажи"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  clothes.add(ShoppingItem(
                    name: nameController.text,
                    image: imageController.text.isEmpty
                        ? 'https://via.placeholder.com/150'
                        : imageController.text,
                    description: descriptionController.text,
                    price: getPrice() ?? 0,
                  ));
                });
                Navigator.pop(context);
              },
              child: const Text("Додај"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: clothes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(item: clothes[index]),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      clothes[index].image,
                      height: 115,
                      width: 115,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      clothes[index].name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewClothingItem,
        tooltip: 'Add New Clothing Item',
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.item});

  final ShoppingItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(item.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                item.image,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Опис на продуктот: ${item.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Цена: \$${item.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
