class Instruction {
  late String
      instruction_branch,
      instruction_title,
      instruction_sender,
      instruction_description;
  late int instruction_id,instruction_sem, instruction_type, instruction_delete , instruction_isFeatured;
  late DateTime instruction_datetime;

  Instruction({
    required this.instruction_id,
    required this.instruction_type,
    required this.instruction_sem,
    required this.instruction_branch,
    required this.instruction_datetime,
    required this.instruction_title,
    required this.instruction_sender,
    required this.instruction_description,
    required this.instruction_delete,
    required this.instruction_isFeatured,
  });
}