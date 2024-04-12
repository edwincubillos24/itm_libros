class User{
  var _uid;
  var _name;
  var _email;

  get uid => _uid;

  set uid(value) {
    _uid = value;
  }

  Map<String, dynamic> toJson() => {
    'uid' : _uid,
    'name' : _name,
    'email' : _email
  };

  User.fromJson(Map<String, dynamic> json)
    : _uid = json['uid'],
      _name = json['name'],
      _email = json['email'];

  get name => _name;

  set name(value) {
    _name = value;
  }

  get email => _email;


  set email(value) {
    _email = value;
  }

  User(this._uid, this._name, this._email);

  User.Empty();
}