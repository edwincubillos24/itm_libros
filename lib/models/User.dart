class User{
  var _name;
  var _email;
  var _password;

  Map<String, dynamic> toJson() => {
    'name' : _name,
    'email' : _email,
    'password' : _password
  };

  User.fromJson(Map<String, dynamic> json)
    : _name = json['name'],
      _email = json['email'],
      _password = json['password'];

  get name => _name;

  set name(value) {
    _name = value;
  }

  get email => _email;

  get password => _password;

  set password(value) {
    _password = value;
  }

  set email(value) {
    _email = value;
  }

  User(this._name, this._email, this._password);

  User.Empty();
}