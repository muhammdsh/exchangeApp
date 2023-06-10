import 'dart:convert';

class ModelFactory {
  Map<String, dynamic Function(dynamic)> _modelMap = {};

  static ModelFactory _instance;

  static ModelFactory getInstance() {
    if (_instance != null)
      return _instance;
    else {
      _instance = ModelFactory();
    }
    return _instance;
  }

  void registerModel(
    String modelName,
    dynamic Function(dynamic) modelMapper,
  ) {
     _modelMap.putIfAbsent(modelName, () => modelMapper);
  }

  T createModel<T>(json) {
    assert(_modelMap.containsKey(T.toString()));
    return _modelMap[T.toString()](json) as T;
  }

  List<T> createModelList<T>(json) {

    return (json as List)
        .map((item) => item == null ? null : createModel(item))
        .toList();
  }
}

