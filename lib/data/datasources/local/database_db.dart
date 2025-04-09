import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    try {
      print('Bắt đầu khởi tạo database...');
      _database = await _initDatabase();
      print('Khởi tạo database thành công!');
      return _database!;
    } catch (e) {
      print('LỖI khi khởi tạo database: $e');
      rethrow;
    }
  }

  Future<Database> _initDatabase() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, "pokemon.db");
      print('Đường dẫn database: $path');

      bool fileExists = await File(path).exists();
      if (fileExists) {
        print('Database đã tồn tại. Sử dụng database hiện có.');
      }

      var database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          print('Đang tạo database mới với version $version...');
          await _createDatabase(db);
        },
        onOpen: (db) {
          print('Database đã mở thành công.');
        },
      );

      return database;
    } catch (e) {
      print('LỖI trong _initDatabase: $e');
      rethrow;
    }
  }

  Future<void> _createDatabase(Database db) async {
    try {
      print('Đang đọc file SQL từ assets...');
      String sqlScript = await rootBundle.loadString('assets/pokemondb.sql');

      // Loại bỏ comments (dòng bắt đầu bằng --)
      List<String> lines = sqlScript.split('\n');
      lines = lines.where((line) => !line.trim().startsWith('--')).toList();
      sqlScript = lines.join('\n');

      // Split theo dấu chấm phẩy và loại bỏ câu lệnh rỗng
      List<String> sqlStatements = sqlScript
          .split(';')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      print('Số lượng câu lệnh SQL cần thực thi: ${sqlStatements.length}');

      for (int i = 0; i < sqlStatements.length; i++) {
        String statement = sqlStatements[i];
        try {
          print('Đang thực thi câu lệnh ${i + 1}/${sqlStatements.length}');
          await db.execute(statement);
        } catch (e) {
          print('LỖI khi thực thi câu lệnh SQL ${i + 1}: $e');
          print('Nội dung câu lệnh lỗi: $statement');
        }
      }

      print('Hoàn thành việc tạo database.');
    } catch (e) {
      print('LỖI trong _createDatabase: $e');
      rethrow;
    }
  }

  Future<void> insertOrUpdate(
      String tableName, Map<String, dynamic> data, String primaryKey) async {
    final db = await database;

    // Kiểm tra xem ID đã tồn tại chưa
    final List<Map<String, dynamic>> result = await db.query(tableName,
        where: '$primaryKey = ?', whereArgs: [data[primaryKey]], limit: 1);

    if (result.isEmpty) {
      // Insert nếu chưa tồn tại
      print('Inserting into $tableName with $primaryKey: ${data[primaryKey]}');
      await db.insert(tableName, data);
    } else {
      // Update nếu đã tồn tại
      print('Updating $tableName with $primaryKey: ${data[primaryKey]}');
      await db.update(tableName, data,
          where: '$primaryKey = ?', whereArgs: [data[primaryKey]]);
    }
  }

  Future<int> insertData(String table, Map<String, dynamic> data) async {
    try {
      final db = await database;
      return await db.insert(table, data);
    } catch (e) {
      print('LỖI trong insertData: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> selectData(String table) async {
    try {
      final db = await database;
      return await db.query(table);
    } catch (e) {
      print('LỖI trong selectData: $e');
      rethrow;
    }
  }

  Future<void> updateDownloaded(int id, bool downloaded) async {
    final db = await database;
    await db.update(
      'generation',
      {
        'Downloaded': downloaded,
      },
      where: 'Id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateData(String table, Map<String, dynamic> data,
      String whereClause, List<dynamic> whereArgs) async {
    try {
      final db = await database;
      return await db.update(table, data,
          where: whereClause, whereArgs: whereArgs);
    } catch (e) {
      print('LỖI trong updateData: $e');
      rethrow;
    }
  }

  Future<int> deleteData(
      String table, String whereClause, List<dynamic> whereArgs) async {
    try {
      final db = await database;
      return await db.delete(table, where: whereClause, whereArgs: whereArgs);
    } catch (e) {
      print('LỖI trong deleteData: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getMoveWithNameOrId(
      String? name, int? id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('SELECT * FROM moves WHERE Name = ? OR Id = ?', [name, id]);

    return maps;
  }

  Future<List<Map<String, dynamic>>> getPokemonWithNameOrId(
      String? name, int? id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('SELECT * FROM pokemon WHERE Name = ? OR Id = ?', [name, id]);

    return maps;
  }

  Future<int> getCountPokemon({
    String? search,
    List<String>? type, // Đổi từ String? thành List<String>?
    String sortBy = 'id',
    String sortOrder = 'asc',
  }) async {
    final db = await database;

    List<String> whereClauses = [];
    List<dynamic> whereArgs = [];

    if (search != null && search.isNotEmpty) {
      whereClauses.add('(Name LIKE ? OR CAST(Id AS TEXT) LIKE ?)');
      whereArgs.add('%$search%');
      whereArgs.add('%$search%');
    }

    if (type != null && type.isNotEmpty) {
      // Tạo một điều kiện cho từng loại trong List<String> `type`
      List<String> typeConditions = [];
      for (var t in type) {
        typeConditions.add('(Type1 = ? OR Type2 = ?)');
        whereArgs.add(t.toLowerCase());
        whereArgs.add(t.toLowerCase());
      }
      whereClauses.add('(${typeConditions.join(' OR ')})');
    }

    String? whereString =
        whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    // Validate sortBy & sortOrder
    final allowedSortBy = ['id', 'name'];
    final allowedSortOrder = ['asc', 'desc'];

    String orderByColumn = allowedSortBy.contains(sortBy.toLowerCase())
        ? sortBy.toLowerCase()
        : 'id';
    String orderDirection = allowedSortOrder.contains(sortOrder.toLowerCase())
        ? sortOrder.toUpperCase()
        : 'ASC';
    String orderBy = '${orderByColumn == "id" ? "Id" : "Name"} $orderDirection';

    // ✅ PRINT câu truy vấn giả lập như SQL thật
    String debugQuery = 'SELECT COUNT(*) as total FROM pokemon';
    if (whereString != null) {
      String simulatedWhere = whereString;
      for (final arg in whereArgs) {
        String replacement =
            arg is String ? "'${arg.replaceAll("'", "''")}'" : arg.toString();
        simulatedWhere = simulatedWhere.replaceFirst('?', replacement);
      }
      debugQuery += ' WHERE $simulatedWhere';
    }

    print('--- SQL DEBUG QUERY ---');
    print(debugQuery);
    print('------------------------');

    final countQuery = await db.rawQuery(
      debugQuery,
    );

    final total = Sqflite.firstIntValue(countQuery) ?? 0;
    return total;
  }

  Future<List<Map<String, dynamic>>> getPokemon({
    String? search,
    List<String>? type, // đổi từ String? thành List<String>?
    int? startIndex, // offset
    int? limit,
    String sortBy = 'id',
    String sortOrder = 'asc',
    bool prioritizeTypeOrder =
        true, // Thêm tham số mới để quyết định ưu tiên sắp xếp
  }) async {
    final db = await database;

    List<String> whereClauses = [];
    List<dynamic> whereArgs = [];

    if (search != null && search.isNotEmpty) {
      whereClauses.add('(Name LIKE ? OR CAST(Id AS TEXT) LIKE ?)');
      whereArgs.add('%$search%');
      whereArgs.add('%$search%');
    }

    bool hasTypeFilter = false;
    if (type != null && type.isNotEmpty) {
      // Tạo một điều kiện cho từng loại trong List<String> `type`
      List<String> typeConditions = [];
      for (var t in type) {
        typeConditions.add('(Type1 = ? OR Type2 = ?)');
        whereArgs.add(t.toLowerCase());
        whereArgs.add(t.toLowerCase());
      }
      whereClauses.add('(${typeConditions.join(' OR ')})');
      hasTypeFilter = true;
    }

    String? whereString =
        whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

    // Validate sortBy & sortOrder
    final allowedSortBy = ['id', 'name'];
    final allowedSortOrder = ['asc', 'desc'];

    String orderByColumn = allowedSortBy.contains(sortBy.toLowerCase())
        ? sortBy.toLowerCase()
        : 'id';
    String orderDirection = allowedSortOrder.contains(sortOrder.toLowerCase())
        ? sortOrder.toUpperCase()
        : 'ASC';

    // Chuyển đổi tên cột thực tế trong DB
    String actualOrderByColumn = orderByColumn == "id" ? "Id" : "Name";

    // Xây dựng mệnh đề ORDER BY dựa trên các loại được chỉ định
    String orderBy;
    if (prioritizeTypeOrder && hasTypeFilter && type!.length >= 2) {
      // Tạo danh sách các trường hợp để sắp xếp theo thứ tự ưu tiên
      List<String> orderCases = [];

      // Trường hợp 1: Type1 = type[0] AND Type2 = type[1]
      orderCases.add(
          "CASE WHEN Type1 = '${type[0].toLowerCase()}' AND Type2 = '${type[1].toLowerCase()}' THEN 1");

      // Trường hợp 2: Type1 = type[1] AND Type2 = type[0]
      orderCases.add(
          "WHEN Type1 = '${type[1].toLowerCase()}' AND Type2 = '${type[0].toLowerCase()}' THEN 2");

      // Trường hợp 3: Type1 = type[0]
      orderCases.add("WHEN Type1 = '${type[0].toLowerCase()}' THEN 3");

      // Trường hợp 4: Type2 = type[0]
      orderCases.add("WHEN Type2 = '${type[0].toLowerCase()}' THEN 4");

      // Trường hợp 5: Type1 = type[1]
      orderCases.add("WHEN Type1 = '${type[1].toLowerCase()}' THEN 5");

      // Trường hợp 6: Type2 = type[1]
      orderCases.add("WHEN Type2 = '${type[1].toLowerCase()}' THEN 6");

      // Trường hợp mặc định
      orderCases.add("ELSE 7 END");

      // Kết hợp tất cả các trường hợp thành một mệnh đề ORDER BY
      // Trường hợp này sẽ sắp xếp theo ưu tiên loại trước, sau đó mới đến sortBy/sortOrder
      orderBy =
          "(${orderCases.join(' ')}) ASC, $actualOrderByColumn $orderDirection";
    } else {
      // Sử dụng sắp xếp trực tiếp theo sortBy/sortOrder
      orderBy = '$actualOrderByColumn $orderDirection';
    }

    // ✅ PRINT câu truy vấn giả lập như SQL thật
    String debugQuery = 'SELECT * FROM pokemon';
    if (whereString != null) {
      String simulatedWhere = whereString;
      for (final arg in whereArgs) {
        String replacement =
            arg is String ? "'${arg.replaceAll("'", "''")}'" : arg.toString();
        simulatedWhere = simulatedWhere.replaceFirst('?', replacement);
      }
      debugQuery += ' WHERE $simulatedWhere';
    }
    debugQuery += ' ORDER BY $orderBy';
    if (limit != null) debugQuery += ' LIMIT $limit';
    if (startIndex != null) debugQuery += ' OFFSET $startIndex';

    print('--- SQL DEBUG QUERY ---');
    print(debugQuery);
    print('------------------------');

    final result = await db.query(
      'pokemon',
      where: whereString,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: startIndex,
    );

    return result;
  }

  Future<List<Map<String, dynamic>>> searchMoveByName(String name) async {
    final db = await database;
    return await db.query(
      'moves',
      where: 'Name LIKE ?',
      whereArgs: [
        '%$name%'
      ], // tìm chuỗi gần giống (ví dụ "flame" sẽ ra "Flamethrower")
    );
  }
}
