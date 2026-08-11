import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db.dart';

extension DbSeedExt on AppDatabase {
  static const userId = '1fe67ad5-1730-476c-8d88-7ff5d5c3e4ae';
  static const tagIdSleeping = 'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0';
  static const tagIdBackpack = 'eee67ad5-1730-476c-8d88-7ff5d5c3e4a1';
  static const gearIdCrown = 'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0';
  static const gearListId1 = 'eee67ad5-1730-476c-8d88-7ff5d5c3e4a0';

  static const uuid = Uuid();

  Future<void> clear() {
    return transaction(() async {
      await delete(gearTags).go();
      await delete(gearListItems).go();
      await delete(gearListCategories).go();
      await delete(gearLists).go();
      await delete(gear).go();
      await delete(tags).go();
      await delete(users).go();
    });
  }

  Future<void> seed() async {
    final now = DateTime.now();

    return transaction(() async {
      await batch((batch) {
        batch
          ..insertAll(users, [
            UsersCompanion.insert(
              id: userId,
              createdAt: now,
              updatedAt: now,
            ),
          ])
          ..insertAll(tags, [
            TagsCompanion.insert(
              id: tagIdSleeping,
              userId: userId,
              name: 'Sleeping',
              createdAt: now,
              updatedAt: now,
            ),
            TagsCompanion.insert(
              id: tagIdBackpack,
              userId: userId,
              name: 'Backpack',
              createdAt: now,
              updatedAt: now,
            ),
          ])
          ..insertAll(gear, [
            GearCompanion.insert(
              id: gearIdCrown,
              userId: userId,
              name: 'Granite Gear Crown 2',
              description: const Value('Capacity: 60l, Size: Long'),
              weightGrams: 1120,
              createdAt: now,
              updatedAt: now,
            ),
          ])
          ..insertAll(gearLists, [
            GearListsCompanion.insert(
              id: gearListId1,
              userId: userId,
              name: 'GearList 1',
              createdAt: now,
              updatedAt: now,
            ),
          ])
          ..insertAll(gearListItems, [
            GearListItemsCompanion.insert(
              id: uuid.v4(),
              gearId: gearIdCrown,
              gearListId: gearListId1,
              quantity: 1,
              packingType: PackingType.PACKED,
              createdAt: now,
              updatedAt: now,
            ),
          ]);
      });
    });
  }

  Future<List<(GearList, GearData, GearListCategory?)>> getGearLists() async {
    final query = select(gearListItems).join([
      leftOuterJoin(gearLists, gearLists.id.equalsExp(gearListItems.gearListId)),
      leftOuterJoin(gear, gear.id.equalsExp(gearListItems.gearId)),
      leftOuterJoin(
        gearListCategories,
        gearListCategories.gearListId.equalsExp(gearListItems.gearListId) &
            gearListCategories.categoryId.equalsExp(gearListItems.categoryId),
      ),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      return (
        row.readTable(gearLists),
        row.readTable(gear),
        row.readTableOrNull(gearListCategories),
      );
    }).toList();
  }
}
