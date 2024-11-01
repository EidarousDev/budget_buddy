class Settings {
  final int id, salaryAmount, savingAmount;

  const Settings(
      {this.id = 1, required this.salaryAmount, required this.savingAmount});

  Map<String, dynamic> toMap(Settings t) {
    return {
      'id': 1,
      'salary_amount': t.salaryAmount,
      'savings_goal_amount': t.savingAmount,
    };
  }
}
