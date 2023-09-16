// https://de.wikipedia.org/wiki/Frequenzen_der_gleichstufigen_Stimmung
// https://en.wikipedia.org/wiki/Piano_key_frequencies
// https://fr.wikipedia.org/wiki/Fr%C3%A9quences_des_touches_du_piano

enum fields { color, frequency, helmholtz, scientific, german, midi, latin }

class PianoKey {
  final String number;
  final String color;
  final String frequency;
  final String helmholtz;
  final String scientific;
  final String german;
  final String midi;
  final String latin;

  const PianoKey(
      {required this.number,
      required this.color,
      required this.frequency,
      required this.helmholtz,
      required this.scientific,
      required this.german,
      required this.midi,
      required this.latin});

  String getField(fields field) {
    switch (field) {
      case fields.color:
        return color;
      case fields.frequency:
        return color;
      case fields.helmholtz:
        return color;
      case fields.scientific:
        return color;
      case fields.german:
        return color;
      case fields.midi:
        return color;
      case fields.latin:
        return color;
      default:
        return '';
    }
  }
}

const Map<int, PianoKey> PIANO_KEYS = {
  89: PianoKey(
      number: "89 (-8)",
      color: "common_color_white",
      frequency: "16.35160",
      helmholtz: "C͵͵ sub-contra-octave",
      scientific: "C0 Double Pedal C",
      german: "C2",
      midi: "C-1",
      latin: "Do-1"),
  90: PianoKey(
      number: "90 (-7)",
      color: "common_color_black",
      frequency: "17.32391",
      helmholtz: "C♯͵͵/D♭͵͵",
      scientific: "C♯0/D♭0",
      german: "Cis2/Des2",
      midi: "C#-1/D♭-1",
      latin: "Do-1#"),
  91: PianoKey(
      number: "91 (-6)",
      color: "common_color_white",
      frequency: "18.35405",
      helmholtz: "D͵͵",
      scientific: "D0",
      german: "D2",
      midi: "D-1",
      latin: "Re-1"),
  92: PianoKey(
      number: "92 (-5)",
      color: "common_color_black",
      frequency: "19.44544",
      helmholtz: "D♯͵͵/E♭͵͵",
      scientific: "D♯0/E♭0",
      german: "Dis2/Es2",
      midi: "D#-1/E♭-1",
      latin: "Re-1#"),
  93: PianoKey(
      number: "93 (-4)",
      color: "common_color_white",
      frequency: "20.60172",
      helmholtz: "E͵͵",
      scientific: "E0",
      german: "E2",
      midi: "E-1",
      latin: "Mi-1"),
  94: PianoKey(
      number: "94 (-3)",
      color: "common_color_white",
      frequency: "21.82676",
      helmholtz: "F͵͵",
      scientific: "F0",
      german: "F2",
      midi: "F-1",
      latin: "Fa-1"),
  95: PianoKey(
      number: "95 (-2)",
      color: "common_color_black",
      frequency: "23.12465",
      helmholtz: "F♯͵͵/G♭͵͵",
      scientific: "F♯0/G♭0",
      german: "Fis2/Ges2",
      midi: "F#-1/G♭-1",
      latin: "Fa-1#"),
  96: PianoKey(
      number: "96 (-1)",
      color: "common_color_white",
      frequency: "24.49971",
      helmholtz: "G͵͵",
      scientific: "G0",
      german: "G2",
      midi: "G-1",
      latin: "SOl-1"),
  97: PianoKey(
      number: "97 (0)",
      color: "common_color_black",
      frequency: "25.95654",
      helmholtz: "G♯͵͵/A♭͵͵",
      scientific: "G♯0/A♭0",
      german: "Gis2/As2",
      midi: "G#-1/A♭-1",
      latin: "Sol-1#"),
  1: PianoKey(
      number: "1",
      color: "common_color_white",
      frequency: "27.50000",
      helmholtz: "A͵͵",
      scientific: "A0",
      german: "A2",
      midi: "A-1",
      latin: "La-1"),
  2: PianoKey(
      number: "2",
      color: "common_color_black",
      frequency: "29.13524",
      helmholtz: "A♯͵͵/B♭͵͵",
      scientific: "A♯0/B♭0",
      german: "Ais2/B2",
      midi: "A#-1/B♭-1",
      latin: "La-1#"),
  3: PianoKey(
      number: "3",
      color: "common_color_white",
      frequency: "30.86771",
      helmholtz: "B͵͵",
      scientific: "B0",
      german: "H2",
      midi: "B-1",
      latin: "Si-1"),
  4: PianoKey(
      number: "4",
      color: "common_color_white",
      frequency: "32.70320",
      helmholtz: "C͵ contra-octave",
      scientific: "C1 Pedal C",
      german: "C1",
      midi: "C0",
      latin: "Do0"),
  5: PianoKey(
      number: "5",
      color: "common_color_black",
      frequency: "34.64783",
      helmholtz: "C♯͵/D♭͵",
      scientific: "C♯1/D♭1",
      german: "Cis1/Des1",
      midi: "C#0/D♭0",
      latin: "Do0#"),
  6: PianoKey(
      number: "6",
      color: "common_color_white",
      frequency: "36.70810",
      helmholtz: "D͵",
      scientific: "D1",
      german: "D1",
      midi: "D0",
      latin: "Re0"),
  7: PianoKey(
      number: "7",
      color: "common_color_black",
      frequency: "38.89087",
      helmholtz: "D♯͵/E♭͵",
      scientific: "D♯1/E♭1",
      german: "Dis1/Es1",
      midi: "D#0/E♭0",
      latin: "Re0#"),
  8: PianoKey(
      number: "8",
      color: "common_color_white",
      frequency: "41.20344",
      helmholtz: "E͵",
      scientific: "E1",
      german: "E1",
      midi: "E0",
      latin: "Mi0"),
  9: PianoKey(
      number: "9",
      color: "common_color_white",
      frequency: "43.65353",
      helmholtz: "F͵",
      scientific: "F1",
      german: "F1",
      midi: "F0",
      latin: "Fa0"),
  10: PianoKey(
      number: "10",
      color: "common_color_black",
      frequency: "46.24930",
      helmholtz: "F♯͵/G♭͵",
      scientific: "F♯1/G♭1",
      german: "Fis1/Ges1",
      midi: "F#0/G♭0",
      latin: "Fa0#"),
  11: PianoKey(
      number: "11",
      color: "common_color_white",
      frequency: "48.99943",
      helmholtz: "G͵",
      scientific: "G1",
      german: "G1",
      midi: "G0",
      latin: "Sol0"),
  12: PianoKey(
      number: "12",
      color: "common_color_black",
      frequency: "51.91309",
      helmholtz: "G♯͵/A♭͵",
      scientific: "G♯1/A♭1",
      german: "Gis1/As1",
      midi: "G#0/A♭0",
      latin: "Sol0#"),
  13: PianoKey(
      number: "13",
      color: "common_color_white",
      frequency: "55.00000",
      helmholtz: "A͵",
      scientific: "A1",
      german: "A1",
      midi: "A0",
      latin: "La0"),
  14: PianoKey(
      number: "14",
      color: "common_color_black",
      frequency: "58.27047",
      helmholtz: "A♯͵/B♭͵",
      scientific: "A♯1/B♭1",
      german: "Ais1/B1",
      midi: "A#0/B♭0",
      latin: "La0#"),
  15: PianoKey(
      number: "15",
      color: "common_color_white",
      frequency: "61.73541",
      helmholtz: "B͵",
      scientific: "B1",
      german: "H1",
      midi: "B0",
      latin: "Si0"),
  16: PianoKey(
      number: "16",
      color: "common_color_white",
      frequency: "65.40639",
      helmholtz: "C great octave",
      scientific: "C2 Deep C",
      german: "C",
      midi: "C1",
      latin: "Do1"),
  17: PianoKey(
      number: "17",
      color: "common_color_black",
      frequency: "69.29566",
      helmholtz: "C♯/D♭",
      scientific: "C♯2/D♭2",
      german: "Cis/Des",
      midi: "C#1/D♭1",
      latin: "Do1#"),
  18: PianoKey(
      number: "18",
      color: "common_color_white",
      frequency: "73.41619",
      helmholtz: "D",
      scientific: "D2",
      german: "D",
      midi: "D1",
      latin: "Re1"),
  19: PianoKey(
      number: "19",
      color: "common_color_black",
      frequency: "77.78175",
      helmholtz: "D♯/E♭",
      scientific: "D♯2/E♭2",
      german: "Dis/Es",
      midi: "D#1/E♭1",
      latin: "Re1#"),
  20: PianoKey(
      number: "20",
      color: "common_color_white",
      frequency: "82.40689",
      helmholtz: "E",
      scientific: "E2",
      german: "E",
      midi: "E1",
      latin: "Mi1"),
  21: PianoKey(
      number: "21",
      color: "common_color_white",
      frequency: "87.30706",
      helmholtz: "F",
      scientific: "F2",
      german: "F",
      midi: "F1",
      latin: "Fa1"),
  22: PianoKey(
      number: "22",
      color: "common_color_black",
      frequency: "92.49861",
      helmholtz: "F♯/G♭",
      scientific: "F♯2/G♭2",
      german: "Fis/Ges",
      midi: "F#1/G♭1",
      latin: "Fa1#"),
  23: PianoKey(
      number: "23",
      color: "common_color_white",
      frequency: "97.99886",
      helmholtz: "G",
      scientific: "G2",
      german: "G",
      midi: "G1",
      latin: "Sol1"),
  24: PianoKey(
      number: "24",
      color: "common_color_black",
      frequency: "103.8262",
      helmholtz: "G♯/A♭",
      scientific: "G♯2/A♭2",
      german: "Gis/As",
      midi: "G#1/A♭1",
      latin: "Sol1#"),
  25: PianoKey(
      number: "25",
      color: "common_color_white",
      frequency: "110.0000",
      helmholtz: "A",
      scientific: "A2",
      german: "A",
      midi: "A1",
      latin: "La1"),
  26: PianoKey(
      number: "26",
      color: "common_color_black",
      frequency: "116.5409",
      helmholtz: "A♯/B♭",
      scientific: "A♯2/B♭2",
      german: "Ais/B",
      midi: "A#1/B♭1",
      latin: "La1#"),
  27: PianoKey(
      number: "27",
      color: "common_color_white",
      frequency: "123.4708",
      helmholtz: "B",
      scientific: "B2",
      german: "H",
      midi: "B1",
      latin: "Si1"),
  28: PianoKey(
      number: "28",
      color: "common_color_white",
      frequency: "130.8128",
      helmholtz: "c small octave",
      scientific: "C3",
      german: "c",
      midi: "C2",
      latin: "Do2"),
  29: PianoKey(
      number: "29",
      color: "common_color_black",
      frequency: "138.5913",
      helmholtz: "c♯/d♭",
      scientific: "C♯3/D♭3",
      german: "cis/des",
      midi: "C#2/D♭2",
      latin: "Do2#"),
  30: PianoKey(
      number: "30",
      color: "common_color_white",
      frequency: "146.8324",
      helmholtz: "d",
      scientific: "D3",
      german: "d",
      midi: "D2",
      latin: "Re2"),
  31: PianoKey(
      number: "31",
      color: "common_color_black",
      frequency: "155.5635",
      helmholtz: "d♯/e♭",
      scientific: "D♯3/E♭3",
      german: "dis/es",
      midi: "D#2/E♭2",
      latin: "Re2#"),
  32: PianoKey(
      number: "32",
      color: "common_color_white",
      frequency: "164.8138",
      helmholtz: "e",
      scientific: "E3",
      german: "e",
      midi: "E2",
      latin: "Mi2"),
  33: PianoKey(
      number: "33",
      color: "common_color_white",
      frequency: "174.6141",
      helmholtz: "f",
      scientific: "F3",
      german: "f",
      midi: "F2",
      latin: "Fa2"),
  34: PianoKey(
      number: "34",
      color: "common_color_black",
      frequency: "184.9972",
      helmholtz: "f♯/g♭",
      scientific: "F♯3/G♭3",
      german: "fis/ges",
      midi: "F#2/G♭2",
      latin: "Fa2#"),
  35: PianoKey(
      number: "35",
      color: "common_color_white",
      frequency: "195.9977",
      helmholtz: "g",
      scientific: "G3",
      german: "g",
      midi: "G2",
      latin: "Sol2"),
  36: PianoKey(
      number: "36",
      color: "common_color_black",
      frequency: "207.6523",
      helmholtz: "g♯/a♭",
      scientific: "G♯3/A♭3",
      german: "gis/as",
      midi: "G#2/A♭2",
      latin: "Sol2#"),
  37: PianoKey(
      number: "37",
      color: "common_color_white",
      frequency: "220.0000",
      helmholtz: "a",
      scientific: "A3",
      german: "a",
      midi: "A2",
      latin: "La2"),
  38: PianoKey(
      number: "38",
      color: "common_color_black",
      frequency: "233.0819",
      helmholtz: "a♯/b♭",
      scientific: "A♯3/B♭3",
      german: "ais/b",
      midi: "A#2/B♭2",
      latin: "La2#"),
  39: PianoKey(
      number: "39",
      color: "common_color_white",
      frequency: "246.9417",
      helmholtz: "b",
      scientific: "B3",
      german: "h",
      midi: "B2",
      latin: "Si2"),
  40: PianoKey(
      number: "40",
      color: "common_color_white",
      frequency: "261.6256",
      helmholtz: "c′ 1-line octave",
      scientific: "C4 Middle C",
      german: "c1",
      midi: "C3",
      latin: "Do3"),
  41: PianoKey(
      number: "41",
      color: "common_color_black",
      frequency: "277.1826",
      helmholtz: "c♯′/d♭′",
      scientific: "C♯4/D♭4",
      german: "cis1/des1",
      midi: "C#3/D♭3",
      latin: "Do3#"),
  42: PianoKey(
      number: "42",
      color: "common_color_white",
      frequency: "293.6648",
      helmholtz: "d′",
      scientific: "D4",
      german: "d1",
      midi: "D3",
      latin: "Re3"),
  43: PianoKey(
      number: "43",
      color: "common_color_black",
      frequency: "311.1270",
      helmholtz: "d♯′/e♭′",
      scientific: "D♯4/E♭4",
      german: "dis1/es1",
      midi: "D#3/E♭3",
      latin: "Re3#"),
  44: PianoKey(
      number: "44",
      color: "common_color_white",
      frequency: "329.6276",
      helmholtz: "e′",
      scientific: "E4",
      german: "e1",
      midi: "E3",
      latin: "Mi3"),
  45: PianoKey(
      number: "45",
      color: "common_color_white",
      frequency: "349.2282",
      helmholtz: "f′",
      scientific: "F4",
      german: "f1",
      midi: "F3",
      latin: "Fa3"),
  46: PianoKey(
      number: "46",
      color: "common_color_black",
      frequency: "369.9944",
      helmholtz: "f♯′/g♭′",
      scientific: "F♯4/G♭4",
      german: "fis1/ges1",
      midi: "F#3/G♭3",
      latin: "Fa3#"),
  47: PianoKey(
      number: "47",
      color: "common_color_white",
      frequency: "391.9954",
      helmholtz: "g′",
      scientific: "G4",
      german: "g1",
      midi: "G3",
      latin: "Sol3"),
  48: PianoKey(
      number: "48",
      color: "common_color_black",
      frequency: "415.3047",
      helmholtz: "g♯′/a♭′",
      scientific: "G♯4/A♭4",
      german: "gis1/as1",
      midi: "G#3/A♭3",
      latin: "Sol3#"),
  49: PianoKey(
      number: "49",
      color: "common_color_white",
      frequency: "440.0000",
      helmholtz: "a′",
      scientific: "A4 A440",
      german: "a1",
      midi: "A3",
      latin: "La3"),
  50: PianoKey(
      number: "50",
      color: "common_color_black",
      frequency: "466.1638",
      helmholtz: "a♯′/b♭′",
      scientific: "A♯4/B♭4",
      german: "ais1/b1",
      midi: "A#3/B♭3",
      latin: "La3#"),
  51: PianoKey(
      number: "51",
      color: "common_color_white",
      frequency: "493.8833",
      helmholtz: "b′",
      scientific: "B4",
      german: "h1",
      midi: "B3",
      latin: "Si3"),
  52: PianoKey(
      number: "52",
      color: "common_color_white",
      frequency: "523.2511",
      helmholtz: "c′′ 2-line octave",
      scientific: "C5 Tenor C",
      german: "c2",
      midi: "C4",
      latin: "Do4"),
  53: PianoKey(
      number: "53",
      color: "common_color_black",
      frequency: "554.3653",
      helmholtz: "c♯′′/d♭′′",
      scientific: "C♯5/D♭5",
      german: "cis2/des2",
      midi: "C#4/D♭4",
      latin: "Do4#"),
  54: PianoKey(
      number: "54",
      color: "common_color_white",
      frequency: "587.3295",
      helmholtz: "d′′",
      scientific: "D5",
      german: "d2",
      midi: "D4",
      latin: "Re4"),
  55: PianoKey(
      number: "55",
      color: "common_color_black",
      frequency: "622.2540",
      helmholtz: "d♯′′/e♭′′",
      scientific: "D♯5/E♭5",
      german: "dis2/es2",
      midi: "D#4/E♭4",
      latin: "Re4#"),
  56: PianoKey(
      number: "56",
      color: "common_color_white",
      frequency: "659.2551",
      helmholtz: "e′′",
      scientific: "E5",
      german: "e2",
      midi: "E4",
      latin: "Mi4"),
  57: PianoKey(
      number: "57",
      color: "common_color_white",
      frequency: "698.4565",
      helmholtz: "f′′",
      scientific: "F5",
      german: "f2",
      midi: "F4",
      latin: "Fa4"),
  58: PianoKey(
      number: "58",
      color: "common_color_black",
      frequency: "739.9888",
      helmholtz: "f♯′′/g♭′′",
      scientific: "F♯5/G♭5",
      german: "fis2/ges2",
      midi: "F#4/G♭4",
      latin: "Fa4#"),
  59: PianoKey(
      number: "59",
      color: "common_color_white",
      frequency: "783.9909",
      helmholtz: "g′′",
      scientific: "G5",
      german: "g2",
      midi: "G4",
      latin: "Sol4"),
  60: PianoKey(
      number: "60",
      color: "common_color_black",
      frequency: "830.6094",
      helmholtz: "g♯′′/a♭′′",
      scientific: "G♯5/A♭5",
      german: "gis2/as2",
      midi: "G#4/A♭4",
      latin: "Sol4#"),
  61: PianoKey(
      number: "61",
      color: "common_color_white",
      frequency: "880.0000",
      helmholtz: "a′′",
      scientific: "A5",
      german: "a2",
      midi: "A4",
      latin: "La4"),
  62: PianoKey(
      number: "62",
      color: "common_color_black",
      frequency: "932.3275",
      helmholtz: "a♯′′/b♭′′",
      scientific: "A♯5/B♭5",
      german: "ais2/b2",
      midi: "A#4/B♭4",
      latin: "La4#"),
  63: PianoKey(
      number: "63",
      color: "common_color_white",
      frequency: "987.7666",
      helmholtz: "b′′",
      scientific: "B5",
      german: "h2",
      midi: "B4",
      latin: "Si4"),
  64: PianoKey(
      number: "64",
      color: "common_color_white",
      frequency: "1046.502",
      helmholtz: "c′′′ 3-line octave",
      scientific: "C6 Soprano C (High C)",
      german: "c3",
      midi: "C5",
      latin: "Do5"),
  65: PianoKey(
      number: "65",
      color: "common_color_black",
      frequency: "1108.731",
      helmholtz: "c♯′′′/d♭′′′",
      scientific: "C♯6/D♭6",
      german: "cis3/des3",
      midi: "C#5/D♭5",
      latin: "Do5#"),
  66: PianoKey(
      number: "66",
      color: "common_color_white",
      frequency: "1174.659",
      helmholtz: "d′′′",
      scientific: "D6",
      german: "d3",
      midi: "D5",
      latin: "Re5"),
  67: PianoKey(
      number: "67",
      color: "common_color_black",
      frequency: "1244.508",
      helmholtz: "d♯′′′/e♭′′′",
      scientific: "D♯6/E♭6",
      german: "dis3/es3",
      midi: "D#5/E♭5",
      latin: "Re5#"),
  68: PianoKey(
      number: "68",
      color: "common_color_white",
      frequency: "1318.510",
      helmholtz: "e′′′",
      scientific: "E6",
      german: "e3",
      midi: "E5",
      latin: "Mi5"),
  69: PianoKey(
      number: "69",
      color: "common_color_white",
      frequency: "1396.913",
      helmholtz: "f′′′",
      scientific: "F6",
      german: "f3",
      midi: "F5",
      latin: "Fa5"),
  70: PianoKey(
      number: "70",
      color: "common_color_black",
      frequency: "1479.978",
      helmholtz: "f♯′′′/g♭′′′",
      scientific: "F♯6/G♭6",
      german: "fis3/ges3",
      midi: "F#5/G♭5",
      latin: "Fa5#"),
  71: PianoKey(
      number: "71",
      color: "common_color_white",
      frequency: "1567.982",
      helmholtz: "g′′′",
      scientific: "G6",
      german: "g3",
      midi: "G5",
      latin: "Sol5"),
  72: PianoKey(
      number: "72",
      color: "common_color_black",
      frequency: "1661.219",
      helmholtz: "g♯′′′/a♭′′′",
      scientific: "G♯6/A♭6",
      german: "gis3/as3",
      midi: "G#5/A♭5",
      latin: "Sol5#"),
  73: PianoKey(
      number: "73",
      color: "common_color_white",
      frequency: "1760.000",
      helmholtz: "a′′′",
      scientific: "A6",
      german: "a3",
      midi: "A5",
      latin: "La5"),
  74: PianoKey(
      number: "74",
      color: "common_color_black",
      frequency: "1864.655",
      helmholtz: "a♯′′′/b♭′′′",
      scientific: "A♯6/B♭6",
      german: "ais3/b3",
      midi: "A#5/B♭5",
      latin: "La5#"),
  75: PianoKey(
      number: "75",
      color: "common_color_white",
      frequency: "1975.533",
      helmholtz: "b′′′",
      scientific: "B6",
      german: "h3",
      midi: "B5",
      latin: "Si5"),
  76: PianoKey(
      number: "76",
      color: "common_color_white",
      frequency: "2093.005",
      helmholtz: "c′′′′ 4-line octave",
      scientific: "C7 Double high C",
      german: "c4",
      midi: "C6",
      latin: "Do6"),
  77: PianoKey(
      number: "77",
      color: "common_color_black",
      frequency: "2217.461",
      helmholtz: "c♯′′′′/d♭′′′′",
      scientific: "C♯7/D♭7",
      german: "cis4/des4",
      midi: "C#6/D♭6",
      latin: "Do6#"),
  78: PianoKey(
      number: "78",
      color: "common_color_white",
      frequency: "2349.318",
      helmholtz: "d′′′′",
      scientific: "D7",
      german: "d4",
      midi: "D6",
      latin: "Re6"),
  79: PianoKey(
      number: "79",
      color: "common_color_black",
      frequency: "2489.016",
      helmholtz: "d♯′′′′/e♭′′′′",
      scientific: "D♯7/E♭7",
      german: "dis4/es4",
      midi: "D#6/E♭6",
      latin: "Re6#"),
  80: PianoKey(
      number: "80",
      color: "common_color_white",
      frequency: "2637.020",
      helmholtz: "e′′′′",
      scientific: "E7",
      german: "e4",
      midi: "E6",
      latin: "Mi6"),
  81: PianoKey(
      number: "81",
      color: "common_color_white",
      frequency: "2793.826",
      helmholtz: "f′′′′",
      scientific: "F7",
      german: "f4",
      midi: "F6",
      latin: "Fa6"),
  82: PianoKey(
      number: "82",
      color: "common_color_black",
      frequency: "2959.955",
      helmholtz: "f♯′′′′/g♭′′′′",
      scientific: "F♯7/G♭7",
      german: "fis4/ges4",
      midi: "F#6/G♭6",
      latin: "Fa6#"),
  83: PianoKey(
      number: "83",
      color: "common_color_white",
      frequency: "3135.963",
      helmholtz: "g′′′′",
      scientific: "G7",
      german: "g4",
      midi: "G6",
      latin: "Sol6"),
  84: PianoKey(
      number: "84",
      color: "common_color_black",
      frequency: "3322.438",
      helmholtz: "g♯′′′′/a♭′′′′",
      scientific: "G♯7/A♭7",
      german: "gis4/as4",
      midi: "G#6/A♭6",
      latin: "Sol6#"),
  85: PianoKey(
      number: "85",
      color: "common_color_white",
      frequency: "3520.000",
      helmholtz: "a′′′′",
      scientific: "A7",
      german: "a4",
      midi: "A6",
      latin: "La6"),
  86: PianoKey(
      number: "86",
      color: "common_color_black",
      frequency: "3729.310",
      helmholtz: "a♯′′′′/b♭′′′′",
      scientific: "A♯7/B♭7",
      german: "ais4/b4",
      midi: "A#6/B♭6",
      latin: "La6#"),
  87: PianoKey(
      number: "87",
      color: "common_color_white",
      frequency: "3951.066",
      helmholtz: "b′′′′",
      scientific: "B7",
      german: "h4",
      midi: "B6",
      latin: "Si6"),
  88: PianoKey(
      number: "88",
      color: "common_color_white",
      frequency: "4186.009",
      helmholtz: "c′′′′′ 5-line octave",
      scientific: "C8 Eighth octave",
      german: "c5",
      midi: "D7",
      latin: "Do7"),
  98: PianoKey(
      number: "98 (89)",
      color: "common_color_black",
      frequency: "4434.922",
      helmholtz: "c♯′′′′′/d♭′′′′′",
      scientific: "C♯8/D♭8",
      german: "cis5/des5",
      midi: "C#7/D♭7",
      latin: "Do7#"),
  99: PianoKey(
      number: "99 (90)",
      color: "common_color_white",
      frequency: "4698.636",
      helmholtz: "d′′′′′",
      scientific: "D8",
      german: "d5",
      midi: "D7",
      latin: "Re7"),
  100: PianoKey(
      number: "100 (91)",
      color: "common_color_black",
      frequency: "4978.032",
      helmholtz: "d♯′′′′′/e♭′′′′′",
      scientific: "D♯8/E♭8",
      german: "dis5/es5",
      midi: "D#7/E♭7",
      latin: "Re7#"),
  101: PianoKey(
      number: "101 (92)",
      color: "common_color_white",
      frequency: "5274.041",
      helmholtz: "e′′′′′",
      scientific: "E8",
      german: "e5",
      midi: "E7",
      latin: "Mi7"),
  102: PianoKey(
      number: "102 (93)",
      color: "common_color_white",
      frequency: "5587.652",
      helmholtz: "f′′′′′",
      scientific: "F8",
      german: "f5",
      midi: "F7",
      latin: "Fa7"),
  103: PianoKey(
      number: "103 (94)",
      color: "common_color_black",
      frequency: "5919.911",
      helmholtz: "f♯′′′′′/g♭′′′′′",
      scientific: "F♯8/G♭8",
      german: "fis5/ges5",
      midi: "F#7/G♭7",
      latin: "Fa7#"),
  104: PianoKey(
      number: "104 (95)",
      color: "common_color_white",
      frequency: "6271.927",
      helmholtz: "g′′′′′",
      scientific: "G8",
      german: "g5",
      midi: "G7",
      latin: "Sol7"),
  105: PianoKey(
      number: "105 (96)",
      color: "common_color_black",
      frequency: "6644.875",
      helmholtz: "g♯′′′′′/a♭′′′′′",
      scientific: "G♯8/A♭8",
      german: "gis5/as5",
      midi: "G#7/A♭7",
      latin: "Sol7#"),
  106: PianoKey(
      number: "106 (97)",
      color: "common_color_white",
      frequency: "7040.000",
      helmholtz: "a′′′′′",
      scientific: "A8",
      german: "a5",
      midi: "A7",
      latin: "La7"),
  107: PianoKey(
      number: "107 (98)",
      color: "common_color_black",
      frequency: "7458.620",
      helmholtz: "a♯′′′′′/b♭′′′′′",
      scientific: "A♯8/B♭8",
      german: "ais5/b5",
      midi: "A#7/B♭7",
      latin: "La6#"),
  108: PianoKey(
      number: "108 (99)",
      color: "common_color_white",
      frequency: "7902.133",
      helmholtz: "b′′′′′",
      scientific: "B8",
      german: "h5",
      midi: "B7",
      latin: "Si7"),
};
