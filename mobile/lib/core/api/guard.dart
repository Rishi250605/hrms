import '../errors/api_failure.dart';

/// Runs an API call and normalises any error into [ApiFailure]. Repositories wrap every call in this.
Future<T> guardApi<T>(Future<T> Function() body) async {
  try {
    return await body();
  } catch (e) {
    throw ApiFailure.fromObject(e);
  }
}
