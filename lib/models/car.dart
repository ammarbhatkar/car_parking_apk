import 'package:isar/isar.dart';

part 'car.g.dart';

@Collection()
class Car {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String carNumber;

  late DateTime checkInTime;

  DateTime? checkOutTime;
}
