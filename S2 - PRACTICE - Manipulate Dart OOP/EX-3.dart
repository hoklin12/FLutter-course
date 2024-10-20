class CustomDuration {
  // Private attribute to store duration in milliseconds
  final int _milliseconds;

  // Internal constructor, ensuring duration is always >= 0
  CustomDuration._(this._milliseconds) {
    if (_milliseconds < 0) {
      throw Exception("Duration cannot be negative");
    }
  }

  // Constructor to create duration from hours
  CustomDuration.fromHours(int hours) : _milliseconds = hours * 3600000;

  // Constructor to create duration from minutes
  CustomDuration.fromMinutes(int minutes) : _milliseconds = minutes * 60000;

  // Constructor to create duration from seconds
  CustomDuration.fromSeconds(int seconds) : _milliseconds = seconds * 1000;

  // Overloaded operator '>' to compare two durations
  bool operator >(CustomDuration other) {
    return _milliseconds > other._milliseconds;
  }

  // Overloaded operator '+' to add two durations
  CustomDuration operator +(CustomDuration other) {
    return CustomDuration._(_milliseconds + other._milliseconds);
  }

  // Overloaded operator '-' to subtract two durations
  CustomDuration operator -(CustomDuration other) {
    int result = _milliseconds - other._milliseconds;
    if (result < 0) {
      throw Exception("Resulting duration cannot be negative");
    }
    return CustomDuration._(result);
  }

  // Convert the duration to a readable format (hours, minutes, seconds)
  @override
  String toString() {
    int seconds = (_milliseconds / 1000).round();
    int minutes = (seconds / 60).floor();
    seconds = seconds % 60;
    int hours = (minutes / 60).floor();
    minutes = minutes % 60;
    return '$hours hours, $minutes minutes, $seconds seconds';
  }
}

void main() {
  // Create durations
  CustomDuration duration1 = CustomDuration.fromHours(3); // 3 hours
  CustomDuration duration2 = CustomDuration.fromMinutes(45); // 45 minutes

  // Add durations
  print(duration1 + duration2); // 3 hours, 45 minutes, 0 seconds

  // Compare durations
  print(duration1 > duration2); // true

  // Subtract durations (this will throw an exception if the result is negative)
  try {
    print(duration2 - duration1); // This will throw an exception
  } catch (e) {
    print(e); // Output: Resulting duration cannot be negative
  }
}
