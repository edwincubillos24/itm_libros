class Book{
  var _id;
  var _name;
  var _author;
  var _pages;
  var _rating;
  var _isActionFavorite;
  var _isAdventureFavorite;
  var _isDramaFavorite;
  var _isFantasyFavorite;
  var _isFictionFavorite;
  var _isRomanceFavorite;
  var _isSuspenseFavorite;
  var _isTerrorFavorite;
  var _urlPicture;

  Map<String, dynamic> toJson() => {
    'id' : _id,
    'name' : _name,
    'author': _author,
    'pages': _pages,
    'rating': _rating,
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

  Book.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _author = json['author'],
        _pages = json['pages'],
        _rating = json['rating'],
        _isActionFavorite = json['isActionFavorite'],
        _isAdventureFavorite = json['isAdventureFavorite'],
        _isFictionFavorite = json['isFictionFavorite'],
        _isDramaFavorite = json['isDramaFavorite'],
        _isFantasyFavorite = json['isFantasyFavorite'],
        _isRomanceFavorite = json['isRomanceFavorite'],
        _isSuspenseFavorite = json['isSuspenseFavorite'],
        _isTerrorFavorite = json['isTerrorFavorite'],
        _urlPicture = json['urlPicture'];

  get id => _id;

  set id(value) {
    _id = value;
  }

  Book(
      this._id,
      this._name,
      this._author,
      this._pages,
      this._rating,
      this._isActionFavorite,
      this._isAdventureFavorite,
      this._isDramaFavorite,
      this._isFantasyFavorite,
      this._isFictionFavorite,
      this._isRomanceFavorite,
      this._isSuspenseFavorite,
      this._isTerrorFavorite,
      this._urlPicture);

  get name => _name;

  set name(value) {
    _name = value;
  }

  get author => _author;

  set author(value) {
    _author = value;
  }

  get pages => _pages;

  set pages(value) {
    _pages = value;
  }

  get rating => _rating;

  set rating(value) {
    _rating = value;
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

  get urlPicture => _urlPicture;

  set urlPicture(value) {
    _urlPicture = value;
  }
}