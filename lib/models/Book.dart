class Book{
  var _id;
  var _name;
  var _autor;

  get id => _id;

  set id(value) {
    _id = value;
  }

  get name => _name;

  get autor => _autor;

  set autor(value) {
    _autor = value;
  }

  set name(value) {
    _name = value;
  }

  Book(this._id, this._name, this._autor);

  Map<String, dynamic> toJson() => {
    'id' : _id,
    'name' : _name,
    'autor' : _autor
  };

  Book.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _autor = json['autor'];
}