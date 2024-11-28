import 'package:flutter/material.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/louis.jpg",
      "name": "Orang Item",
      "price": 3000,
      "stock": 10,
      "qty": 0
    },
    {
      "image": "assets/images/ohiyabang.png",
      "name": "Orang item deluxe",
      "price": 3000,
      "stock": 10,
      "qty": 0
    },
    {
      "image": "assets/images/ProfileManca.png",
      "name": "Orang ganteng limited edition",
      "price": 3000,
      "stock": 10,
      "qty": 0
    },
  ];

  int _totalItem = 0;
  int _totalHarga = 0;

  Future<void> _kurangItemBeli(int index) async {
    setState(() {
      if (products[index]['qty'] > 1) {
        products[index]['qty']--;
        products[index]['stock']++;
        _totalItem--;
        _totalHarga -= products[index]['price'] as int;
      } else if (products[index]['qty'] == 1) {
        products[index]['qty']--;
        products[index]['stock']++;
        _totalItem--;
        _totalHarga -= products[index]['price'] as int;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Jumlah tidak bisa dikurangi lebih dari 0"),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }


  Future<void> _tambahItemBeli(int index) async {
    setState(() {
      if (products[index]['stock'] > 0) {
        products[index]['qty']++;
        products[index]['stock']--;
        _totalItem++;
        _totalHarga += products[index]['price'] as int;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Stock tidak cukup"),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }


  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cashier App",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Text(
                  "Semoga harimu menyenangkan :)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari produk...',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 15);
                      },
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "${products[index]['image']}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                      ),
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${products[index]['name']}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            "Stock x ${products[index]['stock']}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rp. ${products[index]['price']}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (products[index]['stock'] > 0) {
                                          _tambahItemBeli(index);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text("Stock Kosong!"),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                      child: const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Icon(
                                          Icons.add_circle_outline_outlined,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (products[index]['qty'] > 1) {
                                          _kurangItemBeli(index);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Jumlah item tidak bisa dikurangi lebih dari 0"),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                      child: const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Icon(
                                          Icons
                                              .remove_circle_outline_outlined, // Ikon berbeda untuk mengurangi
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 55,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // $_totalHarga atau $_totalItem ubah menjadi 0 aja
                        "Total ($_totalItem item) = Rp. $_totalHarga",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      )
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
