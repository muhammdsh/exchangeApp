import 'package:exchange/core/request/request.dart';

class MemoizationStore {
  static MemoizationStore _instance;

  Map<String, Map<Request, dynamic>> _cache;

  factory MemoizationStore() {
    _instance ??= MemoizationStore._internal();
    return _instance;
  }

  MemoizationStore._internal() {
    _cache = {};
  }

  dynamic get(Request request, String index) {
    final innerMap = _cache[index];
    if (innerMap == null) {
      return null;
    }
    Request cachedRequest =
        innerMap.keys.firstWhere((r) => r == request, orElse: () => null);
    if (cachedRequest != null) {
      return innerMap[cachedRequest];
    } else {
      return null;
    }
  }

  void set(Request request, String index, dynamic value) {
    final innerMap =
        _cache.putIfAbsent(index, () => <Request, dynamic>{});
    innerMap[request] = value;
  }

  void reset() {
    _cache = <String, Map<Request, dynamic>>{};
  }
}
