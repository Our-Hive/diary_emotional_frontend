abstract class DailyRecordExternalRepository {
  Future<bool> addDailyRecord({
    required String primaryEmotion,
    required String secondaryEmotion,
    required String description,
  });
}
