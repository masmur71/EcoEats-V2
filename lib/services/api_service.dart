import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../models/cart_item.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../models/order_item.dart';
import '../models/address.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.18.13:5000/api';

  // Fetch all products
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Product> products =
          body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fetch product by ID
  Future<Product> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200) {
      return Product.fromJson(
          jsonDecode(response.body)); // Parse single product object
    } else {
      throw Exception('Failed to load product');
    }
  }

  // Fetch orders by seller ID
  Future<List<Order>> fetchOrdersBySellerId(int sellerId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/orders/seller/$sellerId'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Order> orders =
          body.map((dynamic item) => Order.fromJson(item)).toList();
      return orders;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  // Fetch orders by buyer ID
  Future<List<Order>> fetchOrdersByBuyerId(int buyerId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/orders/buyer/$buyerId'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Order> orders =
          body.map((dynamic item) => Order.fromJson(item)).toList();
      return orders;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> addAddress(Address address) async {
    final response = await http.post(
      Uri.parse('$baseUrl/addresses'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(address.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add address');
    }
  }

  Future<void> updateAddress(Address address) async {
    final response = await http.put(
      Uri.parse('$baseUrl/addresses/${address.id}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(address.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update address');
    }
  }

  Future<void> deleteAddress(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/addresses/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete address');
    }
  }

  Future<List<Address>> fetchAddresses(int pembeliId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/addresses/$pembeliId'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Address> addresses =
          data.map((item) => Address.fromJson(item)).toList();
      return addresses;
    } else {
      throw Exception('Failed to load addresses');
    }
  }

  Future<List<CartItem>> fetchCartItems() async {
    final response = await http.get(Uri.parse('$baseUrl/cart'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<CartItem> cartItems =
          data.map((item) => CartItem.fromJson(item)).toList();
      return cartItems;
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cart'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'produkId': productId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add product to cart');
    }
  }

  Future<void> updateCartItem(int id, int quantity) async {
    final response = await http.put(
      Uri.parse('$baseUrl/cart/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart item');
    }
  }

  Future<void> removeCartItem(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/cart/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove cart item');
    }
  }

  // Create Order
  Future<void> createOrder(
      int penjualId, int totalPembayaran, List<CartItem> items) async {
    final List<Map<String, dynamic>> itemList = items.map((item) {
      return {
        'produkId': item.produkId,
        'quantity': item.quantity,
        'harga': item.harga,
        'namaProduk': item.nama,
      };
    }).toList();

    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'pembeliId': 1, // Default pembeliId
        'penjualId': penjualId,
        'totalPembayaran': totalPembayaran,
        'items': itemList,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create order');
    }
  }

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/orders'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<List<Order>> fetchOrdersByPembeliId() async {
    final response = await http.get(Uri.parse('$baseUrl/orders/pembeli/'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Order> orders = data.map((item) => Order.fromJson(item)).toList();
      return orders;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<List<OrderItem>> fetchOrderItems(int pesananId) async {
    final response = await http.get(Uri.parse('$baseUrl/orders/$pesananId'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => OrderItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load order items');
    }
  }

//upload image
  Future<String> uploadImage(File imageFile) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/products/uploads'));
    request.files
        .add(await http.MultipartFile.fromPath('gambar', imageFile.path));
    var res = await request.send();

    if (res.statusCode == 200) {
      var responseData = await res.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);
      return jsonResponse['imageUrl'];
    } else {
      throw Exception('Failed to upload image');
    }
  }

//create product
  Future<void> createProduct(Product product, File imageFile) async {
    final imageUrl = await uploadImage(imageFile);
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nama': product.nama,
        'deskripsi': product.deskripsi,
        'harga': product.harga,
        'stok': product.stok,
        'tglKadaluarsa': product.tglKadaluarsa.toIso8601String(),
        'kategori': product.kategori,
        'gambar': imageUrl,
        'penjualId': 1, // Set penjualId to 1
      }),
    );
  }
}
