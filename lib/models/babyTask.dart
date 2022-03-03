class BabyTask {
  final int? id;
  final int babyId;
  final String taskName;
  final String timeStamp;
  final String note;
  final String startTime;
  final String endTime;
  final String resumeTime;
  final String qtyFood;
  final String qtyLeft;
  final String qtyRight;
  final String qtyFeeder;
  final int leftBreast;
  final int rightBreast;
  final String groupFood;
  final int pee;
  final int poo;
  final String durationH;
  final String durationM;
  final String durationS;
  final String color;
  final int onTaskCompleted;

  BabyTask(
      {this.id,
      required this.babyId,
      required this.taskName,
      required this.timeStamp,
      required this.note,
      required this.startTime,
      required this.endTime,
      required this.resumeTime,
      required this.qtyFood,
      required this.qtyLeft,
      required this.qtyRight,
      required this.qtyFeeder,
      required this.leftBreast,
      required this.rightBreast,
      required this.groupFood,
      required this.pee,
      required this.poo,
      required this.durationH,
      required this.durationM,
      required this.durationS,
      required this.color,
      required this.onTaskCompleted});
  factory BabyTask.fromMap(Map<String, dynamic> json) => new BabyTask(
      id: json['id'],
      babyId: json['baby_id'],
      taskName: json['task_name'],
      timeStamp: json['time_stamp'],
      note: json['note'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      resumeTime: json['resume_time'],
      qtyFood: json['qty_food'],
      qtyLeft: json['qty_left'],
      qtyRight: json['qty_right'],
      qtyFeeder: json['qty_feeder'],
      leftBreast: json['left_breast'],
      rightBreast: json['right_breast'],
      groupFood: json['food_group'],
      pee: json['pee'],
      poo: json['poo'],
      durationH: json['durationH'],
      durationM: json['durationM'],
      durationS: json['durationS'],
      color: json['color'],
      onTaskCompleted: json['on_task_complete']);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'baby_id': babyId,
      'task_name': taskName,
      'time_stamp': timeStamp,
      'note': note,
      'start_time': startTime,
      'end_time': endTime,
      'resume_time': resumeTime,
      'qty_food': qtyFood,
      'qty_left': qtyLeft,
      'qty_right': qtyRight,
      'qty_feeder': qtyFeeder,
      'left_breast': leftBreast,
      'right_breast': rightBreast,
      'food_group': groupFood,
      'pee': pee,
      'poo': poo,
      'durationH': durationH,
      'durationM': durationM,
      'durationS': durationS,
      'color': color,
      'on_task_complete': onTaskCompleted
    };
  }
}
