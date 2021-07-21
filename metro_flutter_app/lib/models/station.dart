import 'package:flutter/foundation.dart';

class Station {
  String stationName;
  bool state;
  int line;

  Station({
    @required this.stationName,
    @required this.state,
    @required this.line,
  });
}

List<Station> stationsLine1 = [
  // Line 1
  Station(
    stationName: "Helwan",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Ain Helwan",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Helwan University",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Wadi Hof",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Hadayek Helwan",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "El-Maasara",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Tora El-Asmant",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Kozzika",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Tora El-Balad",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Sakanat El-Maadi",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Maadi",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Hadayek El-Maadi",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Dar El-Salam",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "El-Zahraa'",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Mar Girgis",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "El-Malek El-Saleh",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Al-Sayeda Zeinab",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Saad Zaghloul",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Sadat",
    state: false,
    line: 12,
  ),
  Station(
    stationName: "Nasser",
    state: false,
    line: 13,
  ),
  Station(
    stationName: "Orabi",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Al-Shohadaa",
    state: false,
    line: 12,
  ),
  Station(
    stationName: "Ghamra",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "El-Demerdash",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Manshiet El-Sadr",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Kobri El-Qobba",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Hammamat El-Qobba",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Saray El-Qobba",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Hadayeq El-Zaitoun",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Helmeyet El-Zaitoun",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "El-Matareyya",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Ain Shams",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "Ezbet El-Nakhl",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "El-Marg",
    state: false,
    line: 1,
  ),
  Station(
    stationName: "New El-Marg",
    state: false,
    line: 1,
  ),
];
List<Station> stationsLine2 = [
  // Line 2
  Station(
    stationName: "moneb",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Sakiat Mekky",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Omm El-Masryeen",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Giza",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Faisal",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Cairo University",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "El Bohoth",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Dokki",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "opera",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Sadat",
    state: false,
    line: 12,
  ),
  Station(
    stationName: "Mohamed Naguib",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Attaba",
    state: false,
    line: 23,
  ),
  Station(
    stationName: "Al Shohadaa",
    state: false,
    line: 12,
  ),
  Station(
    stationName: "Masarra",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Rod El-Farag",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "St. Teresa",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Khalafawy",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Mezallat",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Kolleyyet El-Zeraa",
    state: false,
    line: 2,
  ),
  Station(
    stationName: "Shubra El-Kheima",
    state: false,
    line: 2,
  ),
];
List<Station> stationsLine3 = [
  // Line 3
  Station(
    stationName: "Airport",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Ahmed Galal",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Adly Mansour",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "El Haykestep",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Omar Ibn El-Khattab",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Qobaa",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Hesham Barakat",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "El-Nozha",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Nadi El-Shams",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Alf Maskan",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Heliopolis Square",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Haroun",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Al-Ahram",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Koleyet El-Banat",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Stadium",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Fair Zone",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Abbassiya",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Abdou Pasha",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "El-Geish",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Bab El-Shaaria",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Attaba",
    state: false,
    line: 23,
  ),
  Station(
    stationName: "Nasser",
    state: false,
    line: 13,
  ),
  Station(
    stationName: "Maspero",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Zamalek",
    state: false,
    line: 3,
  ),
  Station(
    stationName: "Kit Kat",
    state: false,
    line: 3,
  ),
];
