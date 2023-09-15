class Device {
  int? stationIndex;
  int? deviceID;
  String name;
  String ip;
  String serial;
  String status;
  double value;

  Device(this.deviceID, this.stationIndex, this.name, this.ip, this.serial,
      this.status, this.value);
}
