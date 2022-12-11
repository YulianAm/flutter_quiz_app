final String tableUsers = 'users';

class UserFields {
  static final String id = '_id';
  static final String userName = 'userName';
  static final String createTime = 'createTime';
}

class User {
  final int id;
  final String userName;
  final String createTime;

  User(this.id, this.userName, this.createTime);

  Map<String, Object> toJson() => {
        UserFields.id: id,
        UserFields.userName: userName,
        UserFields.createTime: createTime
      };
}
