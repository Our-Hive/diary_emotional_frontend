import 'package:emotional_app/features/my_space/domain/entities/my_space.dart';
import 'package:emotional_app/features/my_space/domain/external/data_source/my_space_external_data_source.dart';
import 'package:emotional_app/features/my_space/domain/external/repository/my_space_external_repository.dart';

class MySpaceExternalRepositoryImpl implements MySpaceExternalRepository {
  final MySpaceExternalDataSource _dataSource;
  MySpaceExternalRepositoryImpl(this._dataSource);

  @override
  Future<List<MySpace>> getMySpace() {
    return _dataSource.getMySpace();
  }
}
