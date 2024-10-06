import 'package:emotional_app/features/support_network/domain/data_source/support_network_external_data_source.dart';
import 'package:emotional_app/features/support_network/domain/repository/support_network_external_repository.dart';

class SupportNetworkExternalRepositoryImpl
    implements SupportNetworkExternalRepository {
  final SupportNetworkExternalDataSource _dataSource;
  SupportNetworkExternalRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<bool> addSupportNetworkByUserName(
    String userName,
  ) {
    return _dataSource.addSupportNetworkByUserName(userName);
  }
}
