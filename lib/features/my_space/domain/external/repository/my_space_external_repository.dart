import 'package:emotional_app/features/my_space/domain/entities/my_space.dart';

abstract class MySpaceExternalRepository {
  Future<List<MySpace>> getMySpace();
}
