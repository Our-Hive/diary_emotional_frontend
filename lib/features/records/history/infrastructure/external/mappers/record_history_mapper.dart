import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/features/records/history/infrastructure/external/dto/get_record_history_response_dto.dart';
import 'package:emotional_app/features/records/record/domain/entities/record.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';

class RecordHistoryMapper {
  static List<Record> fromGetRecordHistoryResponseDto(
    List<GetRecordHistoryResponseDto> dto,
  ) {
    return dto.map((e) {
      if (e.description != null) {
        return DailyRecord(
          id: e.id.toString(),
          primaryEmotion: Emotion(
            name: e.primaryEmotion.name,
            color: e.primaryEmotion.color,
            description: e.primaryEmotion.description,
            colorBrightness: e.primaryEmotion.theme,
          ),
          secondaryEmotion: Emotion(
            name: e.secondaryEmotion.name,
            color: e.secondaryEmotion.color,
            description: e.secondaryEmotion.description,
            colorBrightness: e.primaryEmotion.theme,
          ),
          description: e.description ?? '',
          date: e.createdAt,
        );
      }
      return TrascendentalRecord(
        id: e.id.toString(),
        primaryEmotion: Emotion(
          name: e.primaryEmotion.name,
          color: e.primaryEmotion.color,
          description: e.primaryEmotion.description,
          colorBrightness: e.primaryEmotion.theme,
        ),
        secondaryEmotion: Emotion(
          name: e.secondaryEmotion.name,
          color: e.secondaryEmotion.color,
          description: e.secondaryEmotion.description,
          colorBrightness: e.primaryEmotion.theme,
        ),
        location: e.location ?? '',
        activity: e.activity ?? '',
        companions: e.companion ?? '',
        date: e.createdAt,
      );
    }).toList();
  }

  static List<DailyRecord> fromGetDailyRecordHistoryResponseDto(
    List<GetRecordHistoryResponseDto> dto,
  ) {
    return dto.map(
      (e) {
        return DailyRecord(
          id: e.id.toString(),
          primaryEmotion: Emotion(
            name: e.primaryEmotion.name,
            color: e.primaryEmotion.color,
            description: e.primaryEmotion.description,
            colorBrightness: e.primaryEmotion.theme,
          ),
          secondaryEmotion: Emotion(
            name: e.secondaryEmotion.name,
            color: e.secondaryEmotion.color,
            description: e.secondaryEmotion.description,
            colorBrightness: e.primaryEmotion.theme,
          ),
          description: e.description ?? '',
          date: e.createdAt,
        );
      },
    ).toList();
  }

  static List<TrascendentalRecord> fromGetTrascendentalRecordHistoryResponseDto(
    List<GetRecordHistoryResponseDto> dto,
  ) {
    return dto.map((e) {
      return TrascendentalRecord(
        id: e.id.toString(),
        primaryEmotion: Emotion(
          name: e.primaryEmotion.name,
          color: e.primaryEmotion.color,
          description: e.primaryEmotion.description,
          colorBrightness: e.primaryEmotion.theme,
        ),
        secondaryEmotion: Emotion(
          name: e.secondaryEmotion.name,
          color: e.secondaryEmotion.color,
          description: e.secondaryEmotion.description,
          colorBrightness: e.primaryEmotion.theme,
        ),
        location: e.location ?? '',
        activity: e.activity ?? '',
        companions: e.companion ?? '',
        date: e.createdAt,
      );
    }).toList();
  }
}
