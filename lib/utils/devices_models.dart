// Keysight Technologies Digital Multimeters with LAN connectivity

List<String> multimeters = ["34470A", "EDU34450A", "34465A", "34461A"];
// Keysight Technologies Digital Power Supplies with LAN connectivity
List<String> powerSupplies = [
  "EDU36311A",
  "E36155AGV",
  "E36312A",
  "E36155A",
  "E36155AGV",
  "E36312A",
  "E36155ABV",
  "E36154ABV",
  "E36154AGV",
  "E36154A",
  "E36233A",
  "E36234A",
  "E36313A",
  "E36232A",
  "E36231A",
  "E36155ABVX",
  "E36155AGVX",
  "E36154ABVX",
  "E36154AGVX"
];
// Keysight Technologies Waveform and Function Generators with LAN connectivity
List<String> generators = [
  "33621A",
  "33622A",
  "33612A",
  "33611A",
  "33522B",
  "33521B",
  "33520B",
  "33519B",
  "33512B",
  "33511B",
  "33510B",
  "33509B",
  "EDU33211A",
  "EDU33212A"
];
// Keysight Technologies InfiniiVision Oscilloscopes with LAN connectivity
List<String> oscilloscopes = [
  "DSOX3012G",
  "DSOX1204A",
  "DSOX1204G",
  "DSOX1202G",
  "EDUX1052A",
  "EDUX1052G",
  "DSOX3104G",
  "DSOX3102G",
  "DSOX3054G",
  "DSOX3052G",
  "DSOX3034G",
  "DSOX3032G",
  "DSOX3024G",
  "DSOX3022G",
  "DSOX3014G",
  "MSOX3104G",
  "MSOX3102G",
  "MSOX3054G",
  "MSOX3052G",
  "MSOX3034G",
  "MSOX3032G",
  "MSOX3024G",
  "MSOX3022G",
  "MSOX3014G",
  "MSOX3012G",
];

String detectDeviceType(String model) {
  if (multimeters.contains(model)) {
    return "Multimetr";
  } else if (oscilloscopes.contains(model)) {
    return "Oscyloskop";
  } else if (powerSupplies.contains(model)) {
    return "Zasilacz";
  } else if (generators.contains(model)) {
    return "Generator";
  } else {
    return "Brak informacji";
  }
}
