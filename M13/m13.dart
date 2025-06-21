import 'package:flutter/material.dart';

class M13 extends StatefulWidget {
  const M13({super.key});

  @override
  State<M13> createState() => _M13State();
}

class _M13State extends State<M13> {
  double sliderVal = 0;
  List<String> link = [
    "https://raw.githubusercontent.com/kurniawansHeru/planet/refs/heads/main/1.jpg",
    "https://raw.githubusercontent.com/kurniawansHeru/planet/refs/heads/main/2.jpg",
    "https://raw.githubusercontent.com/kurniawansHeru/planet/refs/heads/main/3.jpg",
    "https://raw.githubusercontent.com/kurniawansHeru/planet/refs/heads/main/4.jpg",
    "https://raw.githubusercontent.com/kurniawansHeru/planet/refs/heads/main/5.jpg",
    "https://raw.githubusercontent.com/kurniawansHeru/planet/refs/heads/main/6.jpg",
    "https://raw.githubusercontent.com/kurniawansHeru/planet/refs/heads/main/7.jpg",
    "https://raw.githubusercontent.com/kurniawansHeru/planet/refs/heads/main/8.jpg",
  ];
  List<String> planet = [
    "Merkurius",
    "Venus",
    "Bumi",
    "Mars",
    "Jupiter",
    "Saturnus",
    "Uranus",
    "Neptunus",
  ];
  int indeks = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Praktek M13', style: TextStyle(color: Colors.black)),
            const SizedBox(width: 8),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                value: sliderVal / 80,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Slider(
            value: sliderVal,
            min: 0,
            max: 80,
            divisions: link.length - 1,
            onChanged: (v) {
              setState(() {
                sliderVal = v;
                int calculatedValue =
                    (((sliderVal / 80) * (link.length - 1)).round() + 1);
                if (calculatedValue < 1) {
                  indeks = 1;
                } else if (calculatedValue > link.length) {
                  indeks = link.length;
                } else {
                  indeks = calculatedValue;
                }
              });
            },
          ),
          const Divider(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                maxCrossAxisExtent: 200,
              ),
              itemCount: indeks,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(
                      child: Tooltip(
                        message: planet[index],
                        child: Stack(
                          children: [
                            Image.network(
                              link[index], 
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(child: CircularProgressIndicator());
                              },
                              // errorBuilder: (context, error, stackTrace) {
                              //   return const Center(child: Icon(Icons.error));
                              // },
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 5,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text(
                                  planet[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
