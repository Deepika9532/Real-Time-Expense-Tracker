/// Interface for checking network connectivity
///
/// This abstraction allows for easy testing and swapping of network
/// connectivity implementations
abstract class NetworkInfo {
  /// Check if the device is currently connected to the internet
  ///
  /// Returns true if connected, false otherwise
  Future<bool> get isConnected;
}
