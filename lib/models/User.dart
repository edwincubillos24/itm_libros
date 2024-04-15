class User {
  var _birthCity;
  var _birthDate;
  var _email;
  var _name;
  var _genre;
  var _isActionFavorite;
  var _isAdventureFavorite;
  var _isDramaFavorite;
  var _isFantasyFavorite;
  var _isFictionFavorite;
  var _isRomanceFavorite;
  var _isSuspenseFavorite;
  var _isTerrorFavorite;
  var _uid;
  var _urlPicture;

  Map<String, dynamic> toJson() => {
        'uid': _uid,
        'name': _name,
        'email': _email,
        'birthCity': _birthCity,
        'genre': _genre,
        'birthDate': _birthDate,
        'isActionFavorite': _isActionFavorite,
        'isAdventureFavorite': _isAdventureFavorite,
        'isFictionFavorite': _isFictionFavorite,
        'isDramaFavorite': _isDramaFavorite,
        'isFantasyFavorite': _isFantasyFavorite,
        'isRomanceFavorite': _isRomanceFavorite,
        'isSuspenseFavorite': _isSuspenseFavorite,
        'isTerrorFavorite': _isTerrorFavorite,
        'urlPicture': _urlPicture,
      };

  User.fromJson(Map<String, dynamic> json)
      : _uid = json['uid'],
        _name = json['name'],
        _email = json['email'],
        _birthCity = json['birthCity'],
        _genre = json['genre'],
        _birthDate = json['email'],
        _isActionFavorite = json['isActionFavorite'],
        _isAdventureFavorite = json['isAdventureFavorite'],
        _isFictionFavorite = json['isFictionFavorite'],
        _isDramaFavorite = json['isDramaFavorite'],
        _isFantasyFavorite = json['isFantasyFavorite'],
        _isRomanceFavorite = json['isRomanceFavorite'],
        _isSuspenseFavorite = json['isSuspenseFavorite'],
        _isTerrorFavorite = json['isTerrorFavorite'],
        _urlPicture = json['urlPicture'];

  User(
      this._birthCity,
      this._birthDate,
      this._email,
      this._name,
      this._genre,
      this._isActionFavorite,
      this._isAdventureFavorite,
      this._isDramaFavorite,
      this._isFantasyFavorite,
      this._isFictionFavorite,
      this._isRomanceFavorite,
      this._isSuspenseFavorite,
      this._isTerrorFavorite,
      this._uid,
      this._urlPicture);

  get birthCity => _birthCity;

  set birthCity(value) {
    _birthCity = value;
  }

  get birthDate => _birthDate;

  set birthDate(value) {
    _birthDate = value;
  }

  get email => _email;

  set email(value) {
    _email = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  get genre => _genre;

  set genre(value) {
    _genre = value;
  }

  get isActionFavorite => _isActionFavorite;

  set isActionFavorite(value) {
    _isActionFavorite = value;
  }

  get isAdventureFavorite => _isAdventureFavorite;

  set isAdventureFavorite(value) {
    _isAdventureFavorite = value;
  }

  get isDramaFavorite => _isDramaFavorite;

  set isDramaFavorite(value) {
    _isDramaFavorite = value;
  }

  get isFantasyFavorite => _isFantasyFavorite;

  set isFantasyFavorite(value) {
    _isFantasyFavorite = value;
  }

  get isFictionFavorite => _isFictionFavorite;

  set isFictionFavorite(value) {
    _isFictionFavorite = value;
  }

  get isRomanceFavorite => _isRomanceFavorite;

  set isRomanceFavorite(value) {
    _isRomanceFavorite = value;
  }

  get isSuspenseFavorite => _isSuspenseFavorite;

  set isSuspenseFavorite(value) {
    _isSuspenseFavorite = value;
  }

  get isTerrorFavorite => _isTerrorFavorite;

  set isTerrorFavorite(value) {
    _isTerrorFavorite = value;
  }

  get uid => _uid;

  set uid(value) {
    _uid = value;
  }

  get urlPicture => _urlPicture;

  set urlPicture(value) {
    _urlPicture = value;
  }
}
