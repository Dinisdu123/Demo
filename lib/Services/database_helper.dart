import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../Models/cart_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, fileName);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        title TEXT NOT NULL,
        image_path TEXT NOT NULL,
        price TEXT NOT NULL,
        description TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        UNIQUE(user_id, product_id)
      )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS cart (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id TEXT NOT NULL,
          product_id TEXT NOT NULL,
          title TEXT NOT NULL,
          image_path TEXT NOT NULL,
          price TEXT NOT NULL,
          description TEXT NOT NULL,
          quantity INTEGER NOT NULL,
          UNIQUE(user_id, product_id)
        )
      ''');
      print('Upgraded database to version 2: Added cart table');
    }
  }

  Future<void> insertCartItem(CartItem item) async {
    final db = await database;
    try {
      await db.insert(
        'cart',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail, // Fail on conflict
      );
      print(
          'Inserted cart item: user_id=${item.userId}, product_id=${item.productId}');
    } catch (e) {
      print('Error inserting cart item: $e');
      rethrow;
    }
  }

  Future<void> deleteCartItem(String userId, String productId) async {
    final db = await database;
    try {
      await db.delete(
        'cart',
        where: 'user_id = ? AND product_id = ?',
        whereArgs: [userId, productId],
      );
      print('Deleted cart item: user_id=$userId, product_id=$productId');
    } catch (e) {
      print('Error deleting cart item: $e');
      rethrow;
    }
  }

  Future<List<CartItem>> getCartItems(String userId) async {
    final db = await database;
    try {
      final maps = await db.query(
        'cart',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      print('Fetched ${maps.length} cart items for user_id=$userId');
      return maps.map((map) => CartItem.fromMap(map)).toList();
    } catch (e) {
      print('Error fetching cart items: $e');
      return [];
    }
  }

  Future<bool> isInCart(String userId, String productId) async {
    final db = await database;
    try {
      final maps = await db.query(
        'cart',
        where: 'user_id = ? AND product_id = ?',
        whereArgs: [userId, productId],
      );
      return maps.isNotEmpty;
    } catch (e) {
      print('Error checking cart: $e');
      return false;
    }
  }

  Future<void> updateCartItemQuantity(
      String userId, String productId, int quantity) async {
    final db = await database;
    try {
      await db.update(
        'cart',
        {'quantity': quantity},
        where: 'user_id = ? AND product_id = ?',
        whereArgs: [userId, productId],
      );
      print(
          'Updated cart item quantity: user_id=$userId, product_id=$productId, quantity=$quantity');
    } catch (e) {
      print('Error updating cart item quantity: $e');
      rethrow;
    }
  }

  Future<void> clearCart(String userId) async {
    final db = await database;
    try {
      await db.delete(
        'cart',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      print('Cleared cart for user_id=$userId');
    } catch (e) {
      print('Error clearing cart: $e');
      rethrow;
    }
  }

  Future<void> debugCartContents(String userId) async {
    final db = await database;
    try {
      final maps =
          await db.query('cart', where: 'user_id = ?', whereArgs: [userId]);
      print('Cart contents for user_id=$userId:');
      for (var map in maps) {
        print(
            'ID: ${map['id']}, ProductID: ${map['product_id']}, Title: ${map['title']}, Quantity: ${map['quantity']}');
      }
    } catch (e) {
      print('Error debugging cart contents: $e');
    }
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
