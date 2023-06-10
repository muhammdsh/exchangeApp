enum ComparisonResult { equal, smaller, larger }

class ComparingStatus {
  final ComparisonResult result;

  const ComparingStatus._(this.result);

  factory ComparingStatus.fromComparisonResult(int comparisonResult) {
    switch (comparisonResult) {
      case 0:
        return const ComparingStatus._(ComparisonResult.equal);
      case -1:
        return const ComparingStatus._(ComparisonResult.smaller);
      case 1:
        return const ComparingStatus._(ComparisonResult.larger);
      default:
        throw ArgumentError('Invalid comparison result: $comparisonResult');
    }
  }
}
