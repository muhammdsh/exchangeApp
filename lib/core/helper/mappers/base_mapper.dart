abstract class Mapper<From, To> {

  To map(From object);

  From unmap(To object) {
    return null;
  }

  List<To> mapList(List<From> objects) {
    if(objects == null) {
      return [];
    }
    List<To> temp = [];
    for (From item in objects) {
      temp.add(map(item));
    }
    return temp;
  }

  List<From> unmapList(List<To> objects) {
    if(objects == null) {
      return null;
    }
    List<From> temp = [];
    for (To item in objects) {
      temp.add(unmap(item));
    }
    return temp;
  }
}