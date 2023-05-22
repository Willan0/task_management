
import 'package:json_annotation/json_annotation.dart';
part 'task_vo.g.dart';

@JsonSerializable()
class TaskVO {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'note')
  String? note;

  @JsonKey(name: 'isCompleted')
  int? isCompleted;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'startTime')
  String? startTime;

  @JsonKey(name: 'endTime')
  String? endTime;

  @JsonKey(name: 'color')
  int? color;

  @JsonKey(name: 'remind')
  int? remind;

  @JsonKey(name: 'repeat')
  String? repeat;
  TaskVO(
      {this.id,
      this.title,
      this.note,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.remind,
      this.repeat});

  factory TaskVO.fromJson(Map<String,dynamic> json) => _$TaskVOFromJson(json);

  Map<String, dynamic> toJson() => _$TaskVOToJson(this);
}
