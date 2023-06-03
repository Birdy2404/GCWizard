part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _hash(Object t, Object b, Object km, Object k, Object x) {
  if (_isNotString(t) || _isNotInt(b) || _isNotInt(km) || _isNotString(k)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  switch ((t as String).toUpperCase()) {
    case 'MD2':
      if (km == 0) {
        return HASH_FUNCTIONS['hashes_md2']!(x.toString());
      } else {
        return HASHKEY_FUNCTIONS['hashes_md2hmac']!(x.toString(), k.toString());
      }
    case 'MD4':
      if (km == 0) {
        return HASH_FUNCTIONS['hashes_md4']!(x.toString());
      } else {
        return HASHKEY_FUNCTIONS['hashes_md4hmac']!(x.toString(), k.toString());
      }
    case 'MD5':
      if (km == 0) {
        return HASH_FUNCTIONS['hashes_md5']!(x.toString());
      } else {
        return HASHKEY_FUNCTIONS['hashes_md5hmac']!(x.toString(), k.toString());
      }
    case 'SHA1':
      if (km == 0) {
        return HASH_FUNCTIONS['hashes_sha1']!(x.toString());
      } else {
        return HASHKEY_FUNCTIONS['hashes_sha1hmac']!(x.toString(), k.toString());
      }
    case 'SHA':
      if (km == 0) {
        switch (b) {
          case 224:
            return HASH_FUNCTIONS['hashes_sha224']!(x.toString());
          case 256:
            return HASH_FUNCTIONS['hashes_sha256']!(x.toString());
          case 384:
            return HASH_FUNCTIONS['hashes_sha384']!(x.toString());
          case 512:
            return HASH_FUNCTIONS['hashes_sha512']!(x.toString());
          default:
            _handleError(_INVALIDHASHBITRATE);
        }
      } else {
        switch (b) {
          case 224:
            return HASHKEY_FUNCTIONS['hashes_sha224hmac']!(x.toString(), k.toString());
          case 256:
            return HASHKEY_FUNCTIONS['hashes_sha256hmac']!(x.toString(), k.toString());
          case 384:
            return HASHKEY_FUNCTIONS['hashes_sha384hmac']!(x.toString(), k.toString());
          case 512:
            return HASHKEY_FUNCTIONS['hashes_sha512hmac']!(x.toString(), k.toString());
          default:
            _handleError(_INVALIDHASHBITRATE);
        }
      }
      return '';
    case 'SHA3':
      if (km == 0) {
        switch (b) {
          case 224:
            return HASH_FUNCTIONS['hashes_sha3.224']!(x.toString());
          case 256:
            return HASH_FUNCTIONS['hashes_sha3.256']!(x.toString());
          case 384:
            return HASH_FUNCTIONS['hashes_sha3.384']!(x.toString());
          case 512:
            return HASH_FUNCTIONS['hashes_sha3.512']!(x.toString());
          default:
            _handleError(_INVALIDHASHBITRATE);
        }
      } else {
        switch (b) {
          case 224:
            return HASHKEY_FUNCTIONS['hashes_sha3.224hmac']!(x.toString(), k.toString());
          case 256:
            return HASHKEY_FUNCTIONS['hashes_sha3.256hmac']!(x.toString(), k.toString());
          case 384:
            return HASHKEY_FUNCTIONS['hashes_sha3.384hmac']!(x.toString(), k.toString());
          case 512:
            return HASHKEY_FUNCTIONS['hashes_sha3.512hmac']!(x.toString(), k.toString());
          default:
            _handleError(_INVALIDHASHBITRATE);
        }
      }
      return '';
    case 'BLAKE2B':
      switch (b) {
        case 160:
          return HASH_FUNCTIONS['hashes_blake2b160']!(x.toString());
        case 224:
          return HASH_FUNCTIONS['hashes_blake2b224']!(x.toString());
        case 256:
          return HASH_FUNCTIONS['hashes_blake2b256']!(x.toString());
        case 384:
          return HASH_FUNCTIONS['hashes_blake2b384']!(x.toString());
        case 512:
          return HASH_FUNCTIONS['hashes_blake2b512']!(x.toString());
        default:
          _handleError(_INVALIDHASHBITRATE);
      }

      return '';
    case 'KECCAK':
      switch (b) {
        case 128:
          return HASH_FUNCTIONS['hashes_keccak128']!(x.toString());
        case 224:
          return HASH_FUNCTIONS['hashes_keccak224']!(x.toString());
        case 256:
          return HASH_FUNCTIONS['hashes_keccak256']!(x.toString());
        case 288:
          return HASH_FUNCTIONS['hashes_keccak288']!(x.toString());
        case 384:
          return HASH_FUNCTIONS['hashes_keccak384']!(x.toString());
        case 512:
          return HASH_FUNCTIONS['hashes_keccak512']!(x.toString());
        default:
          _handleError(_INVALIDHASHBITRATE);
      }

      return '';
    case 'RIPEMD':
      if (km == 0) {
        switch (b) {
          case 128:
            return HASH_FUNCTIONS['hashes_ripemd128']!(x.toString());
          case 160:
            return HASH_FUNCTIONS['hashes_ripemd160']!(x.toString());
          case 256:
            return HASH_FUNCTIONS['hashes_ripemd256']!(x.toString());
          case 320:
            return HASH_FUNCTIONS['hashes_ripemd320']!(x.toString());
          default:
            _handleError(_INVALIDHASHBITRATE);
        }
      } else {
        switch (b) {
          case 128:
            return HASHKEY_FUNCTIONS['hashes_ripemd128hmac']!(x.toString(), k.toString());
          case 160:
            return HASHKEY_FUNCTIONS['hashes_ripemd160hmac']!(x.toString(), k.toString());
          case 256:
            return HASHKEY_FUNCTIONS['hashes_ripemd256hmac']!(x.toString(), k.toString());
          case 320:
            return HASHKEY_FUNCTIONS['hashes_ripemd320hmac']!(x.toString(), k.toString());
          default:
            _handleError(_INVALIDHASHBITRATE);
        }
      }
      return '';
    case 'TIGER':
      if (km == 1) {
        return HASHKEY_FUNCTIONS['hashes_tiger192hmac']!(x.toString(), k.toString());
      } else {
        return HASH_FUNCTIONS['hashes_tiger192']!(x.toString());
      }
    case 'WHIRLPOOL':
      if (km == 1) {
        return HASHKEY_FUNCTIONS['hashes_whirlpool512hmac']!(x.toString(), k.toString());
      } else {
        return HASH_FUNCTIONS['hashes_whirlpool512']!(x.toString());
      }
    default:
      _handleError(_INVALIDHASHBITRATE);
  }
  return '';
}
