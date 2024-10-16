class Distance {
  final double _inMeters;

  Distance._internal(this._inMeters);

  factory Distance.inCentimeters(double cms) => Distance._internal(cms / 100.0);

  factory Distance.inMeters(double meters) => Distance._internal(meters);

  factory Distance.inKilometers(double kms) => Distance._internal(kms * 1000.0);

  double get inCentimeters => _inMeters * 100.0;

  double get inMeters => _inMeters;

  double get inKilometers => _inMeters / 1000.0;

  Distance operator +(Distance other) {
    return Distance._internal(this._inMeters + other._inMeters);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Distance &&
          runtimeType == other.runtimeType &&
          _inMeters == other._inMeters;

  @override
  int get hashCode => _inMeters.hashCode;
}

void main() {
  Distance d1 = Distance.inKilometers(3.4);
  Distance d2 = Distance.inMeters(1000);

  Distance sumDistance = d1 + d2;

  print('Distance 1 in km: ${d1.inKilometers} km');
  print('Distance 2 in m: ${d2.inMeters} m');
  print('Sum of Distance 1 and Distance 2 in km: ${sumDistance.inKilometers.toStringAsFixed(2)} km');
}