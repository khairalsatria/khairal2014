import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key? key});

  @override
  State<Category> createState() => _Category();
}

class _Category extends State<Category> {
  final List<String> cardTitles = [
    'Cyber Security',
    'Ethica Hacking',
    'Introduction to Cyber Security',
    'Introduction to Cyber Crime',
    'Introduction to Cryptography',
    'CISSP',
    'Introduction to CISSP',
    'Cyber Crime',
  ];

  final List<double> cardRatings = [4.5, 4.2, 4.8, 4.0, 4.6, 4.5, 4.6, 4.7];
  final List<int> cardViewers = [10, 10, 12, 9, 11, 13, 21, 12 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Cyber Security'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: CardListItem(
                title: cardTitles[index],
                rating: cardRatings[index],
                viewers: cardViewers[index],
                image: AssetImage('gambar/category${index + 1}.png'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CardListItem extends StatelessWidget {
  final String title;
  final double rating;
  final int viewers;
  final ImageProvider image;

  const CardListItem({
    required this.title,
    required this.rating,
    required this.viewers,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Colors.transparent,
        surfaceTintColor: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.blueGrey, size: 16),
                          SizedBox(width: 5),
                          Text(
                            rating.toString(),
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        '$viewers k learners',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image(
                        image: image,
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ),
        );
    }
}
