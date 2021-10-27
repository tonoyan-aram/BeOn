import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static var _storage = FlutterSecureStorage();

  static const _keyToken = 'token';
  static const _keyRecover = 'recover';
  static const _keyUrl = 'userUrl';
  static const _keyCreatorUrl = 'creatorUrl';
  static const _keyName = 'userName';
  static const _keyFirstName = 'userFirstName';
  static const _keyLastName = 'userLastName';
  static const _keyImage = 'userImage';
  static const _keyId = 'userId';

  static Future setToken(String token) async =>
      await _storage.write(key: _keyToken, value: token);

  static Future setRecover(String recover) async =>
      await _storage.write(key: _keyRecover, value: recover);

  static Future setUrl(String userUrl) async =>
      await _storage.write(key: _keyUrl, value: userUrl);

  static Future setName(String userName) async =>
      await _storage.write(key: _keyName, value: userName);
  static Future setFirstName(String userFirstName) async =>
      await _storage.write(key: _keyFirstName, value: userFirstName);
  static Future setLastName(String userLastName) async =>
      await _storage.write(key: _keyLastName, value: userLastName);

  static Future setImage(String userImage) async =>
      await _storage.write(key: _keyImage, value: userImage);

  static Future setId(String userId) async =>
      await _storage.write(key: _keyId, value: userId);
  static Future setCreatorUrl(String creatorUrl) async =>
      await _storage.write(key: _keyCreatorUrl, value: creatorUrl);

  Future<String> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  Future<String> getRecover() async {
    return await _storage.read(key: _keyRecover);
  }

  Future<String> getUrl() async {
    return await _storage.read(key: _keyUrl);
  }

  Future<String> getUsername() async => await _storage.read(key: _keyName);
  Future<String> getUserLastName() async =>
      await _storage.read(key: _keyLastName);
  Future<String> getUserFirstName() async =>
      await _storage.read(key: _keyFirstName);

  // Future<String> getName() async =>
  //   return await _storage.read(key: _keyName);

  Future<String> getImage() async {
    return await _storage.read(key: _keyImage);
  }

  Future<String> getId() async {
    return await _storage.read(key: _keyId);
  }

  Future<String> getCreaotrUrl() async {
    return await _storage.read(key: _keyCreatorUrl);
  }

  static Future deletetall() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyRecover);
    await _storage.delete(key: _keyUrl);
    await _storage.delete(key: _keyName);
    await _storage.delete(key: _keyImage);
  }
}

//await _storage.deleteAll();
