import 'package:cubos_desafio_2/internal_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLAdapter extends InternalStorage {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'favorites_database.db');

    return await openDatabase(path, onCreate: (db, version) {
      return db.execute("CREATE TABLE Favorites(id TEXT PRIMARY KEY)");
    }, version: 1);
  }

  @override
  favoriteMovie(int movieId) async {
    final Database db = await database;
    var movieFavorite = { 'id': movieId.toString() };
    await db.insert('Favorites', movieFavorite);
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final Database db = await database;
    var response =
        await db.query(
            'Favorites',
            columns: ['id'],
            where: 'id = ?', whereArgs: [movieId.toString()]
        );

    return response.isNotEmpty;
  }

  @override
  unfavoriteMovie(int movieId) async {
    final Database db = await database;
    await db.delete('Favorites', where: 'id = ?', whereArgs: [movieId.toString()]);
  }
}
