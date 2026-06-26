import 'package:orbit/core/error/failure.dart';

/// Result wrapper so use cases return either a value or a [Failure] without
/// throwing across layer boundaries.
sealed class Result<T> {
  const Result();
}

class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}

class Err<T> extends Result<T> {
  const Err(this.failure);
  final Failure failure;
}

extension ResultX<T> on Result<T> {
  R when<R>({required R Function(T) ok, required R Function(Failure) err}) =>
      switch (this) {
        Ok(:final value) => ok(value),
        Err(:final failure) => err(failure),
      };

  T? get valueOrNull => switch (this) { Ok(:final value) => value, _ => null };
}

/// Returns the value, or throws so an AsyncProvider surfaces the error to the
/// UI. Use inside FutureProvider bodies that wrap repository [Result]s.
T unwrap<T>(Result<T> res) => switch (res) {
      Ok(:final value) => value,
      Err(:final failure) => throw Exception(failure.message),
    };

/// Base use case. Use [NoParams] for parameterless calls.
abstract class UseCase<T, P> {
  Future<Result<T>> call(P params);
}

class NoParams {
  const NoParams();
}
