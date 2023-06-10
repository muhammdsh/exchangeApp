class Pair<T, U> {
  final T first;
  final U second;

  const Pair(this.first, this.second);

  @override
  String toString() => '($first, $second)';

  @override
  bool operator ==(other) {
    if (other is Pair<T, U>) {
      return first == other.first && second == other.second;
    }
    return false;
  }

  @override
  int get hashCode => first.hashCode ^ second.hashCode;
}
