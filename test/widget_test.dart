// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.
//
// import 'package:exchange/app+injection/app.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:exchange/core/datasources/local_datasourse/cart/cart_dao.dart';
// import 'package:exchange/core/datasources/local_datasourse/database.dart';
// import 'package:exchange/core/helper/util/pair.dart';
//
//
//
// import 'package:exchange/main.dart';
//
// void main1() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const App());
//
//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);
//
//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//
//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
//
//
// void main() {
//   //WidgetsFlutterBinding.ensureInitialized();
//   TestWidgetsFlutterBinding.ensureInitialized();
//   LocalDatabase db;
//   CartItemsDao dao;
//
//   setUp(() {
//     // We'll use an in-memory database for testing
//     db = LocalDatabase();
//     dao = db.cartItemsDao;
//   });
//
//   tearDown(() async {
//     await db.close();
//   });
//
//   test('checkIfPairsExist should return the correct results', () async {
//     // Insert some test data into the database
//     await dao.insertCartItem(CartItem(
//       id: 1,
//       productId: 1,
//       specificationId: 1, quantity: 2, image: 'qwe', productName: 'name1',
//     ));
//     await dao.insertCartItem(CartItem(
//       id: 2,
//       productId: 1,
//       specificationId: 2, quantity: 3, productName: 'muhammed', image: 'muhammed',
//     ));
//     await dao.insertCartItem(CartItem(
//       id: 3,
//       productId: 2,
//       specificationId: 3, productName: 'csdcsd', quantity: 5, image: 'sdfsdf',
//     ));
//
//     // Check if pairs (1, 1), (1, 2), and (2, 3) exist in the database
//     final pairs = [
//       const Pair<int, int>(1, 1),
//       const Pair<int, int>(1, 2),
//       const Pair<int, int>(2, 3),
//     ];
//     final results = await dao.checkIfPairsExist(pairs);
//
//     expect(results, [true, true, true]);
//
//     // Check if pairs (1, 3) and (2, 2) exist in the database
//     final pairs2 = [
//       const Pair<int, int>(1, 3),
//       const Pair<int, int>(2, 2),
//     ];
//     final results2 = await dao.checkIfPairsExist(pairs2);
//
//     expect(results2, [false, false]);
//   });
// }
