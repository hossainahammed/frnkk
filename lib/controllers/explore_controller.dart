import 'package:flutter/material.dart'; // Required for TextEditingController
import 'package:get/get.dart';

class ExploreController extends GetxController {
  final searchQuery = ''.obs;

  
  final List<Map<String, dynamic>> items = [
    {
      "role": "Producer",
      "name": "Selena Gomez",
      "location": "Dhanmondi, Dhaka",
      "price": "300 \$-500\$",
      "genres": "Pop, Rock, Bangla",
      "image": "assets/images/explore_images/explore_image1.png",
    },
    {
      "role": "Singer",
      "name": "Selena Gomez",
      "location": "Dhanmondi, Dhaka",
      "price": "300 \$-500\$",
      "genres": "Pop, Rock, Bangla",
      "image": "assets/images/explore_images/explore_image1.png",
    },
    {
      "role": "Songwriter",
      "name": "Salena Gomez",
      "location": "Dhanmondi, Dhaka",
      "price": "300 \$-500\$",
      "genres": "Pop, Rock, Bangla",
      "image": "assets/images/explore_images/explore_image1.png",
    },
    {
      "role": "Singer",
      "name": "Selena Gomez",
      "location": "Dhanmondi, Dhaka",
      "price": "300 \$-500\$",
      "genres": "Pop, Rock, Bangla",
      "image": "assets/images/explore_images/explore_image1.png",
    },
    {
      "role": "Singer",
      "name": "Selena Gomez",
      "location": "Dhanmondi, Dhaka",
      "price": "300 \$-500\$",
      "genres": "Pop, Rock, Bangla",
      "image": "assets/images/explore_images/explore_image1.png",
    },
   
  ].obs;

  List<Map<String, dynamic>> get filteredItems {
    if (searchQuery.isEmpty) return items;
    return items.where((item) => 
      item['genres'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
      item['role'].toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }
}