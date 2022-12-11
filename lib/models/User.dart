final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [id, userName, createTime];

  static final String id = '_id';
  static final String userName = 'userName';
  static final String createTime = 'createTime';
}

class User {
  final int id;
  final String userName;
  final DateTime createTime;

  User(this.id, this.userName, this.createTime);

  User copy({int id, String userName, DateTime createTime}) {
    var user = new User(this.id, this.userName, this.createTime);

    return user;
  }

  static User fromJson(Map<String, Object> json) {
    var id = json[UserFields.id];
    var userName = json[UserFields.userName];
    var createTime = DateTime.parse(json[UserFields.createTime] as String);

    return new User(id as int, userName as String, createTime);
  }

  Map<String, Object> toJson() => {
        UserFields.id: id,
        UserFields.userName: userName,
        UserFields.createTime: createTime.toIso8601String()
      };
}
