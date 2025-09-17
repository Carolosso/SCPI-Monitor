/// Increments IP and returs incremented.
/// * @input
String incrementIP(String input) {
  List<String> inputIPString = input.split(".");
  List<int> inputIP = inputIPString.map((e) => int.parse(e)).toList();
  var ip = (inputIP[0] << 24) |
      (inputIP[1] << 16) |
      (inputIP[2] << 8) |
      (inputIP[3] << 0);
  ip++;
  return "${ip >> 24 & 0xff}.${ip >> 16 & 0xff}.${ip >> 8 & 0xff}.${ip >> 0 & 0xff}"; //0xff = 255
}
