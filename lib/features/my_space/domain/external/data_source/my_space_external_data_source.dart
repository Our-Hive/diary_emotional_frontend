import 'package:emotional_app/features/my_space/domain/entities/my_space.dart';

abstract class MySpaceExternalDataSource {
  Future<List<MySpace>> getMySpace();
}
