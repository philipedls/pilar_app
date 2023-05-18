enum FaituleType { none, http }

class BaseFailure {
  final FaituleType faituleType;

  BaseFailure({required this.faituleType});

  BaseFailure.none() : faituleType = FaituleType.none;
}
