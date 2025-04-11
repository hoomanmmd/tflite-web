/// TFLite Data Type
enum TFLiteDataType {
  /// Float32 Data Type
  float32,

  /// Int32 Data Type
  int32,

  /// Boolean Data Type
  bool,

  /// Complex64 Data Type
  complex64,

  /// String Data Type
  string;

  const TFLiteDataType();

  factory TFLiteDataType.fromName(String name) {
    for (final value in TFLiteDataType.values) {
      if (value.name == name) {
        return value;
      }
    }

    throw ArgumentError();
  }
}
