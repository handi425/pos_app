sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(Object error, StackTrace stackTrace) failure,
  }) {
    final self = this;
    if (self is Success<T>) {
      return success(self.data);
    }
    if (self is Failure<T>) {
      return failure(self.error, self.stackTrace);
    }
    throw StateError('Unhandled result state');
  }
}

class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

class Failure<T> extends Result<T> {
  const Failure(this.error, this.stackTrace);

  final Object error;
  final StackTrace stackTrace;
}
