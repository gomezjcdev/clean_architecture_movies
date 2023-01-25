class Either<L, R> {
  final L? left;
  final R? right;
  final bool isLeft;

  Either._(this.left, this.right, this.isLeft);

  factory Either.left(L value) {
    return Either._(value, null, true);
  }

  factory Either.right(R value) {
    return Either._(null, value, true);
  }

  T when<T>(
    T Function(L) left,
    T Function(R) right,
  ) {
    if (isLeft) {
      return left(left as L);
    } else {
      return right(right as R);
    }
  }
}
