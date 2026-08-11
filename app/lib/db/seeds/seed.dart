import 'package:flutter/widgets.dart';
import '../../logging/app_logger.dart';
import '../db.dart';
import 'db_seed_ext.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  try {
    await db.clear();
    await db.seed();
    final res = await db.getGearLists();
    AppLogger().i(res);
  } finally {
    await db.close();
  }
}
