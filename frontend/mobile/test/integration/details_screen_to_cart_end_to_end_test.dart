import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mot/models/cart.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:mot/models/product.dart';
import 'package:mot/screens/product_details/details_screen.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

//flutter test lib/test/integration/test_details_screen_to_cart_end_to_end.dart
void main() {
  testWidgets('DetailsScreen should render correctly', (WidgetTester tester) async {

    final cartProvider = CartProvider();

    final mockClient = MockClient((_) => Future.value(http.Response('''{"id": "00017de0-3029-4d83-b534-adc2f977537c",
    "sku": "MA-Expert 4.9 Black",
    "name": "Huzaro Mark Adler Expert 4.9 Black",
    "description": "Mark Adler Expert 4.9 Black to czarny fotel biurowy, którego wyprofilowana konstrukcja dostosowuje się do budowy ciała użytkownika. Fotel pozwoli Ci szybko i wygodnie dostosować oparcie, zagłówek, siedzisko i podłokietniki do Twoich indywidualnych potrzeb. Z tyłu oparcia umieszczony został praktyczny wieszak z możliwością demontażu. Pozwala on wygodnie powiesić marynarkę, czy kurtkę. Zaprojektowany z dbałością o najmniejsze szczegóły oferuje wiele ergonomicznych i funkcjonalnych rozwiązań, które wspierają odpowiednią postawę ciała i chronią kręgosłup. Solidne połączenie najlepszych materiałów i specjalna konstrukcja gwarantują trwałość i nowoczesny wygląd.",
    "specification": {
        "Kolor": "Czarny",
        "Materiał obicia": "AirMesh",
        "Materiał podstawy": "Nylon",
        "Materiał kółek": "Poliuretan",
        "Regulowana wysokość siedziska": "440 - 520 mm",
        "Maksymalne obciążenie": "150 kg",
        "Wysokość oparcia": "900 - 1000 mm",
        "Szerokość siedziska": "500 mm",
        "Głębokość siedziska": "490 mm",
        "Regulowane podłokietniki": "Tak",
        "Regulowane oparcie": "Tak",
        "Funkcja bujania": "Nie",
        "Poduszka lędźwiowa": "Nie",
        "Poduszka zagłówkowa": "Nie",
        "Dodatkowe informacje": "Regulowany zagłówek",
        "Wysokość fotela": "1280 - 1450 mm",
        "Szerokość fotela": "660 mm",
        "Gwarancja": "24 miesiące (gwarancja producenta)",
        "Kod producenta": "MA-Expert 4.9 Black",
        "Kod x-kom": "1078167"
    },
    "quantity": 100,
    "price": 10.0,
    "imageUrl": "assets/images/ps4_console_blue_3.png",
    "createdOn": "2024-01-10T20:51:31.313616",
    "updatedOn": "2024-01-10T20:51:31.313616",
    "categoryId": 3300}'''
    , 200)));

    // Mock the response when _fetchProduct is called

    // Build our app and trigger a frame.
     await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => cartProvider,
          child: DetailsScreen(
            productPreview: Product(
              id: '00017de0-3029-4d83-b534-adc2f977537c',
              name: 'Huzaro Mark Adler Expert 4.9 Black',
              price: 10.0,
              imageUrl: 'assets/images/ps4_console_blue_3.png',
            ),
            httpClient: mockClient.get,
          ),
        ),
      ),
    );
    

    // Verify that the DetailsScreen renders correctly.
    // expect(find.text('Test Product'), findsOneWidget);
    // expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // You can add more expectations based on your UI elements and behavior.


    expect(cartProvider.cartItems.isEmpty, true);
    // Example interaction: Tap the 'Add To Cart' button
    await tester.tap(find.text('Add To Cart'));
    await tester.pump();

    expect(cartProvider.cartItems.length, 1);

    // You can add more assertions based on your cart functionality
    // For example, check if the total amount is updated correctly.

    // Example: Verify total amount after adding to cart
    expect(cartProvider.totalAmount, 10.0);

    // Verify that the cart has been updated
    // You may need to mock or provide a fake implementation for your CartProvider

    // Additional tests can be added based on your application flow.
    
  });
}
