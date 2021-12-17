import 'dart:convert' as convert;
import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flustars/flustars.dart';

// ignore: non_constant_identifier_names
var _KEY = Constant.dataKey;

class JhEncryptUtils {
  static String aesMd5Base64(Object? params) {
    final String paramsString = convert.jsonEncode(params).toString();
    final _random = new Random();
    int next(int min, int max) => min + _random.nextInt(max - min);
    final int code = next(10000000, 99999999);
    final String hashKey = encodeMd5('$code$_KEY');
    final String aesString = aesEncrypt(paramsString, hashKey);
    return '$code$aesString';
  }

  static dynamic decMd5Base64(String param) {
    if (param.isEmpty) return '';
    final String hashKey = encodeMd5('${param.substring(0, 8)}$_KEY');
    final dynamic aesString = aesDecrypt(param.substring(8), hashKey);
    return convert.jsonDecode(aesString as String);
  }

  //Base64编码
  static String encodeBase64(String data) {
    return convert.base64Encode(convert.utf8.encode(data));
  }

  //Base64解码
  static String decodeBase64(String data) {
    return String.fromCharCodes(convert.base64Decode(data));
  }

  // md5 加密 32位小写
  static String encodeMd5(String plainText) {
    return EncryptUtil.encodeMd5(plainText);
  }

  //AES加密
  static String aesEncrypt(String plainText, String hashKey) {
    try {
      final Key key = Key.fromBase16('$hashKey');
      final IV iv = IV.fromLength(16);
      final Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (err) {
      return plainText;
    }
  }

  //AES解密
  static dynamic aesDecrypt(String encrypted, String hashKey) {
    try {
      final key = Key.fromBase16('$hashKey');
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
      return decrypted;
    } catch (err) {
      return encrypted;
    }
  }
}
