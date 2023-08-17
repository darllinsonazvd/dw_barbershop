sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return switch (json['profile']) {
      'ADM' => UserModelAdmin.fromMap(json),
      'EMPLOYEE' => UserModelEmployee.fromMap(json),
      _ => throw ArgumentError('User profile not found'),
    };
  }
}

class UserModelAdmin extends UserModel {
  final List<String>? workDays;
  final List<int>? workHors;

  UserModelAdmin({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHors,
  });

  factory UserModelAdmin.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
      } =>
        UserModelAdmin(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'],
          workDays: json['work_days']?.cast<String>(),
          workHors: json['work_hours']?.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid JSON'),
    };
  }
}

class UserModelEmployee extends UserModel {
  final int barbershopId;
  final List<String> workDays;
  final List<int> workHors;

  UserModelEmployee({
    required super.id,
    required super.name,
    required super.email,
    required this.barbershopId,
    required this.workDays,
    required this.workHors,
    super.avatar,
  });

  factory UserModelEmployee.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'barbershop_id': final int barbershopId,
        'work_days': final List workDays,
        'work_hours': final List workHors,
      } =>
        UserModelEmployee(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'],
          barbershopId: barbershopId,
          workDays: workDays.cast<String>(),
          workHors: workHors.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid JSON'),
    };
  }
}
