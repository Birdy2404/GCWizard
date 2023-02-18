part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

const WHERIGO_EXPERT_MODE = true;
const WHERIGO_USER_MODE = false;

const WHERIGO_MEDIATYPE_UNK = 0;
const WHERIGO_MEDIATYPE_BMP = 1;
const WHERIGO_MEDIATYPE_PNG = 2;
const WHERIGO_MEDIATYPE_JPG = 3;
const WHERIGO_MEDIATYPE_GIF = 4;
const WHERIGO_MEDIATYPE_WAV = 17;
const WHERIGO_MEDIATYPE_MP3 = 18;
const WHERIGO_MEDIATYPE_FDL = 19;
const WHERIGO_MEDIATYPE_SND = 20;
const WHERIGO_MEDIATYPE_OGG = 21;
const WHERIGO_MEDIATYPE_SWF = 33;
const WHERIGO_MEDIATYPE_TXT = 49;

const Map WHERIGO_MEDIATYPE = {
  WHERIGO_MEDIATYPE_UNK: '<?>',
  WHERIGO_MEDIATYPE_BMP: 'bmp',
  WHERIGO_MEDIATYPE_PNG: 'png',
  WHERIGO_MEDIATYPE_JPG: 'jpg',
  WHERIGO_MEDIATYPE_GIF: 'gif',
  WHERIGO_MEDIATYPE_WAV: 'wav',
  WHERIGO_MEDIATYPE_MP3: 'mp3',
  WHERIGO_MEDIATYPE_FDL: 'fdl',
  WHERIGO_MEDIATYPE_SND: 'snd',
  WHERIGO_MEDIATYPE_OGG: 'ogg',
  WHERIGO_MEDIATYPE_SWF: 'swf',
  WHERIGO_MEDIATYPE_TXT: 'txt'
};

Map WHERIGO_MEDIACLASS = {
  WHERIGO_MEDIATYPE_UNK: 'n/a',
  WHERIGO_MEDIATYPE_BMP: 'Image',
  WHERIGO_MEDIATYPE_PNG: 'Image',
  WHERIGO_MEDIATYPE_JPG: 'Image',
  WHERIGO_MEDIATYPE_GIF: 'Image',
  WHERIGO_MEDIATYPE_WAV: 'Sound',
  WHERIGO_MEDIATYPE_MP3: 'Sound',
  WHERIGO_MEDIATYPE_FDL: 'Sound',
  WHERIGO_MEDIATYPE_SND: 'Sound',
  WHERIGO_MEDIATYPE_OGG: 'Sound',
  WHERIGO_MEDIATYPE_SWF: 'Video',
  WHERIGO_MEDIATYPE_TXT: 'Text'
};

Map<WHERIGO_ACTIONMESSAGETYPE, String> WHERIGO_ACTIONMESSAGETYPE_TEXT = {
  WHERIGO_ACTIONMESSAGETYPE.TEXT: 'txt',
  WHERIGO_ACTIONMESSAGETYPE.IMAGE: 'img',
  WHERIGO_ACTIONMESSAGETYPE.BUTTON: 'btn',
  WHERIGO_ACTIONMESSAGETYPE.COMMAND: 'cmd',
  WHERIGO_ACTIONMESSAGETYPE.CASE: 'cse',
};

Map WHERIGO_TEXT_ACTIONMESSAGETYPE = switchMapKeyValue(WHERIGO_ACTIONMESSAGETYPE_TEXT);

const WHERIGO_EMPTYCARTRIDGE_GWC= WherigoCartridgeGWC(
  Signature: '',
  NumberOfObjects: 0,
  MediaFilesHeaders: [],
  MediaFilesContents: [],
  HeaderLength: 0,
  Splashscreen: 0,
  SplashscreenIcon: 0,
  Latitude: 0.0,
  Longitude: 0.0,
  Altitude: 0.0,
  DateOfCreation: 0,
  TypeOfCartridge: '',
  Player: '',
  PlayerID: 0,
  CartridgeLUAName: '',
  CartridgeGUID: '',
  CartridgeDescription: '',
  StartingLocationDescription: '',
  Version: '',
  Author: '',
  Company: '',
  RecommendedDevice: '',
  LengthOfCompletionCode: 0,
  CompletionCode: '',
  ResultStatus: WHERIGO_ANALYSE_RESULT_STATUS.NONE,
  ResultsGWC: [],
);

const String WHERIGO_NULLDATE = '0-01-01 00:00:00.000';

const WHERIGO_EMPTYCARTRIDGE_LUA = WherigoCartridgeLUA(
    LUAFile: '',
    CartridgeLUAName: '',
    CartridgeGUID: '',
    ObfuscatorTable: '',
    ObfuscatorFunction: '',
    Characters: [],
    Items: [],
    Tasks: [],
    Inputs: [],
    Zones: [],
    Timers: [],
    Media: [],
    Messages: [],
    Answers: [],
    Variables: [],
    NameToObject: {},
    ResultStatus: WHERIGO_ANALYSE_RESULT_STATUS.NONE,
    ResultsLUA: [],
    Builder: WHERIGO_BUILDER.UNKNOWN,
    BuilderVersion: '',
    TargetDeviceVersion: '',
    CountryID: '',
    StateID: '',
    UseLogging: '',
    CreateDate: WHERIGO_NULLDATE,
    PublishDate: WHERIGO_NULLDATE,
    UpdateDate: WHERIGO_NULLDATE,
    LastPlayedDate: WHERIGO_NULLDATE,
    httpCode: '',
    httpMessage: '');

const Map<bool, Map<WHERIGO_FILE_LOAD_STATE, Map<WHERIGO_OBJECT, String>>> WHERIGO_DATA = {
  WHERIGO_EXPERT_MODE: {
    WHERIGO_FILE_LOAD_STATE.NULL: {},
    WHERIGO_FILE_LOAD_STATE.GWC: WHERIGO_DATA_GWC_EXPERT,
    WHERIGO_FILE_LOAD_STATE.LUA: WHERIGO_DATA_LUA_EXPERT,
    WHERIGO_FILE_LOAD_STATE.FULL: WHERIGO_DATA_FULL_EXPERT,
  },
  WHERIGO_USER_MODE: {
    WHERIGO_FILE_LOAD_STATE.NULL: {},
    WHERIGO_FILE_LOAD_STATE.GWC: WHERIGO_DATA_GWC_USER,
    WHERIGO_FILE_LOAD_STATE.LUA: WHERIGO_DATA_LUA_USER,
    WHERIGO_FILE_LOAD_STATE.FULL: WHERIGO_DATA_FULL_USER,
  }
};

const Map<WHERIGO_OBJECT, String> WHERIGO_DATA_FULL_EXPERT = {
  WHERIGO_OBJECT.HEADER: 'wherigo_data_header',
  WHERIGO_OBJECT.LUABYTECODE: 'wherigo_data_luabytecode',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.GWCFILE: 'wherigo_data_gwc',
  WHERIGO_OBJECT.OBFUSCATORTABLE: 'wherigo_data_obfuscatortable',
  WHERIGO_OBJECT.LUAFILE: 'wherigo_data_lua',
  WHERIGO_OBJECT.ITEMS: 'wherigo_data_item_list',
  WHERIGO_OBJECT.CHARACTER: 'wherigo_data_character_list',
  WHERIGO_OBJECT.ZONES: 'wherigo_data_zone_list',
  WHERIGO_OBJECT.INPUTS: 'wherigo_data_input_list',
  WHERIGO_OBJECT.TASKS: 'wherigo_data_task_list',
  WHERIGO_OBJECT.TIMERS: 'wherigo_data_timer_list',
  WHERIGO_OBJECT.MESSAGES: 'wherigo_data_message_list',
  WHERIGO_OBJECT.IDENTIFIER: 'wherigo_data_identifier_list',
  WHERIGO_OBJECT.RESULTS_GWC: 'wherigo_data_results_gwc',
  WHERIGO_OBJECT.RESULTS_LUA: 'wherigo_data_results_lua',
};

const Map<WHERIGO_OBJECT, String> WHERIGO_DATA_GWC_EXPERT = {
  WHERIGO_OBJECT.HEADER: 'wherigo_data_header',
  WHERIGO_OBJECT.LUABYTECODE: 'wherigo_data_luabytecode',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.GWCFILE: 'wherigo_data_gwc',
  WHERIGO_OBJECT.RESULTS_GWC: 'wherigo_data_results_gwc',
};

const Map<WHERIGO_OBJECT, String> WHERIGO_DATA_LUA_EXPERT = {
  WHERIGO_OBJECT.OBFUSCATORTABLE: 'wherigo_data_obfuscatortable',
  WHERIGO_OBJECT.LUAFILE: 'wherigo_data_lua',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.ITEMS: 'wherigo_data_item_list',
  WHERIGO_OBJECT.CHARACTER: 'wherigo_data_character_list',
  WHERIGO_OBJECT.ZONES: 'wherigo_data_zone_list',
  WHERIGO_OBJECT.INPUTS: 'wherigo_data_input_list',
  WHERIGO_OBJECT.TASKS: 'wherigo_data_task_list',
  WHERIGO_OBJECT.TIMERS: 'wherigo_data_timer_list',
  WHERIGO_OBJECT.MESSAGES: 'wherigo_data_message_list',
  WHERIGO_OBJECT.IDENTIFIER: 'wherigo_data_identifier_list',
  WHERIGO_OBJECT.RESULTS_LUA: 'wherigo_data_results_lua',
};

const Map<WHERIGO_OBJECT, String> WHERIGO_DATA_FULL_USER = {
  WHERIGO_OBJECT.HEADER: 'wherigo_data_header',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.RESULTS_GWC: 'wherigo_data_results_gwc',
  WHERIGO_OBJECT.ITEMS: 'wherigo_data_item_list',
  WHERIGO_OBJECT.CHARACTER: 'wherigo_data_character_list',
  WHERIGO_OBJECT.ZONES: 'wherigo_data_zone_list',
  WHERIGO_OBJECT.INPUTS: 'wherigo_data_input_list',
  WHERIGO_OBJECT.MESSAGES: 'wherigo_data_message_list',
};

const Map<WHERIGO_OBJECT, String> WHERIGO_DATA_GWC_USER = {
  WHERIGO_OBJECT.HEADER: 'wherigo_data_header',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
};

const Map<WHERIGO_OBJECT, String> WHERIGO_DATA_LUA_USER = {
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.ITEMS: 'wherigo_data_item_list',
  WHERIGO_OBJECT.CHARACTER: 'wherigo_data_character_list',
  WHERIGO_OBJECT.ZONES: 'wherigo_data_zone_list',
  WHERIGO_OBJECT.INPUTS: 'wherigo_data_input_list',
  WHERIGO_OBJECT.MESSAGES: 'wherigo_data_message_list',
};

// TODO Thomas Use HttpStatus from dart:io instead of Strings
const Map<String, String> WHERIGO_HTTP_STATUS = {
  '200': 'wherigo_http_code_200',
  '400': 'wherigo_http_code_400',
  '404': 'wherigo_http_code_404',
  '413': 'wherigo_http_code_413',
  '500': 'wherigo_http_code_500',
  '503': 'wherigo_http_code_503',
};

const Map<String, TextStyle> WHERIGO_SYNTAX_HIGHLIGHT_STRINGMAP = {
  // fontWeight: FontWeight.bold
  // fontStyle: FontStyle.italic
  "function": TextStyle(color: Colors.purple),
  "if": TextStyle(color: Colors.purple),
  "then": TextStyle(color: Colors.purple),
  "else": TextStyle(color: Colors.purple),
  "end": TextStyle(color: Colors.purple),
  "return": TextStyle(color: Colors.purple),
  "Dialog": TextStyle(color: Colors.red),
  "MessageBox": TextStyle(color: Colors.red),
  "Wherigo.ZMedia": TextStyle(color: Colors.red),
  "Wherigo.ZCharacter": TextStyle(color: Colors.red),
  "Wherigo.Zone": TextStyle(color: Colors.red),
  "Wherigo.ZItem": TextStyle(color: Colors.red),
  "Wherigo.ZTask": TextStyle(color: Colors.red),
  "Wherigo.ZTimer": TextStyle(color: Colors.red),
  ".ZVariables": TextStyle(color: Colors.red),
  "Wherigo.ZCartridge": TextStyle(color: Colors.red),
  "OnEnter": TextStyle(color: Colors.blue),
  "OnExit": TextStyle(color: Colors.blue),
  "OnGetInput": TextStyle(color: Colors.blue),
  "MoveTo": TextStyle(color: Colors.blue),
  "Id": TextStyle(color: Colors.orange),
  "Type": TextStyle(color: Colors.orange),
  "ZonePoint": TextStyle(color: Colors.orange),
  "Filename": TextStyle(color: Colors.orange),
  "Text": TextStyle(color: Colors.orange),
  "Media": TextStyle(color: Colors.orange),
  "Name": TextStyle(color: Colors.orange),
  "Description": TextStyle(color: Colors.orange),
  "Choices": TextStyle(color: Colors.orange),
};
