import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_pembeli_screen.dart';
import 'screens/login_penjual_screen.dart';
import 'screens/buyer/home_screen.dart';
import 'screens/buyer/product_detail_screen.dart';
import 'screens/buyer/cart_screen.dart';
import 'screens/buyer/add_address_screen.dart';
import 'screens/buyer/order_screen.dart';
import 'screens/seller/home_screen.dart';
import 'screens/seller/manage_store_screen.dart';
import 'screens/seller/add_product_screen.dart';

void main() {
  runApp(EcoEatsApp());
}

class EcoEatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Eats',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/homepage-pembeli': (context) => HomeScreenPm(),
        '/homepage-penjual': (context) => HomeScreenPj(),
        '/onboarding': (context) => OnboardingScreen(),
        '/login-pembeli': (context) => LoginPembeliScreen(),
        '/login-penjual': (context) => LoginPenjualScreen(),
        '/kelola-toko': (context) => ManageStoreScreen(),
        '/tambah-produk': (context) => AddProductScreen(),
        '/detail-produk': (context) => ProductDetailScreen(
            productId: ModalRoute.of(context)!.settings.arguments as int),
        '/orders': (context) => OrderScreen(),
        '/Keranjang': (context) => CartScreen(),
        '/alamat': (context) => AddAddressScreen(),
        '/chat': (context) => ChatScreen(),
      },
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: Text('Halaman Chat'),
      ),
    );
  }
}
