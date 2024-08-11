abstract class DailyRecordExternalDataSource {
  Future<bool> addDailyRecord({
    required String primaryEmotion,
    required String secondaryEmotion,
    required String description,
  });
}
