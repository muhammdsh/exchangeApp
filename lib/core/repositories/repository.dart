import 'package:dartz/dartz.dart';
import 'package:exchange/core/request/request.dart';
import 'package:exchange/core/services/memoization_store.dart';
import 'package:flutter/cupertino.dart';
import '../entities/base_entity.dart';
import '../error/base_error.dart';
import '../models/base_model.dart';
import '../result/result.dart';

abstract class Repository {
  Result<BaseError, Entity>
      execute<Model extends BaseModel<Entity>, Entity extends BaseEntity>({
    @required Either<BaseError, Model> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<BaseError, Model>).value.toEntity(),
      );
    } else {
      return Result(
        error: (remoteResult as Left<BaseError, Model>).value,
      );
    }
  }

  void memoizeResult({@required dynamic result, Request request}) {
    if (result.isRight()) {
      MemoizationStore().set(request, runtimeType.toString(), result);
    }
  }

  Either<BaseError, dynamic> getMemoizedResult({
    @required Request request,
  }) {
    return MemoizationStore().get(request, runtimeType.toString());
  }

  Result<BaseError, List<T>>
      executeWithList<Model extends BaseModel<T>, T extends BaseEntity>({
    @required Either<BaseError, List<Model>> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<BaseError, List<Model>>)
            .value
            .map((e) => e.toEntity())
            .toList(),
      );
    } else {
      return Result(
        error: (remoteResult as Left<BaseError, List<Model>>).value,
      );
    }
  }

  Result<BaseError, Model> executeWithoutConvert<Model, Entity>({
    @required Either<BaseError, Model> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<BaseError, Model>).value,
      );
    } else {
      return Result(error: (remoteResult as Left<BaseError, Model>).value);
    }
  }
}
