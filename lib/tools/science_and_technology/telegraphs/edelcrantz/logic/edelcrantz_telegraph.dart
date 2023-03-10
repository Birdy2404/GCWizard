// https://archive.org/details/earlyhistoryofda0000holz/page/180/mode/2up
// https://trepo.tuni.fi/bitstream/handle/10024/102557/1513599679.pdf?sequence=1&isAllowed=y
// https://en.wikipedia.org/wiki/Telegraph_code#Edelcrantz_code

// ignore_for_file: equal_keys_in_map

import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/logic/segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/_common/logic/teletypewriter.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

enum EdelcrantzCodebook { YEAR_1795, YEAR_1808, MUSEUM }

Map<EdelcrantzCodebook, CodebookConfig> MURRAY_CODEBOOK = {
  EdelcrantzCodebook.YEAR_1795: CodebookConfig(
    title: 'telegraph_edelcrantz_1795_title',
    subtitle: 'telegraph_edelcrantz_1795_description'
  ),
  EdelcrantzCodebook.YEAR_1808: CodebookConfig(
    title: 'telegraph_edelcrantz_1808_title',
    subtitle: 'telegraph_edelcrantz_1808_description'
  ),
  EdelcrantzCodebook.MUSEUM: CodebookConfig(
    title: 'telegraph_edelcrantz_museum_title',
    subtitle: 'telegraph_edelcrantz_museum_description'
  ),
};

final _CODEBOOK_EDELCRANTZ_1795 = {
  '000': ' ',
  '001': '1',
  '002': '2',
  '003': 'a',
  '004': '3',
  '005': 'ab',
  '006': 'ad',
  '007': 'ordflut',
  '010': '4',
  '011': 'af',
  '012': 'ak',
  '013': 'al',
  '014': 'alt',
  '015': 'am',
  '016': 'an',
  '017': 'and',
  '020': '5',
  '021': 'ap',
  '022': 'ar',
  '023': 'arm',
  '024': 'as',
  '025': 'at',
  '026': 'b',
  '027': 'ba',
  '030': 'bak',
  '031': 'bar',
  '032': 'be',
  '033': 'beg',
  '034': 'berg',
  '035': 'bi',
  '036': 'bl',
  '037': 'bland',
  '040': '6',
  '041': 'bo',
  '042': 'bon',
  '043': 'bor',
  '044': 'br',
  '045': 'bref',
  '046': 'bu',
  '047': 'by',
  '050': 'bå',
  '051': 'bart',
  '052': 'bä',
  '053': 'bö',
  '054': 'bör',
  '055': 'd',
  '056': 'da',
  '057': 'dag',
  '060': 'dan',
  '061': 'danfk',
  '062': 'de',
  '063': 'del',
  '064': 'dem',
  '065': 'den',
  '066': 'der',
  '067': 'det',
  '070': '.',
  '071': 'di',
  '072': 'dig',
  '073': 'din',
  '074': 'dit',
  '075': 'do',
  '076': 'dom',
  '077': 'fort',
  '100': '7',
  '101': 'dr',
  '102': 'dt',
  '103': 'du',
  '104': 'dy',
  '105': 'då',
  '106': 'dä',
  '107': 'där',
  '110': 'dö',
  '111': 'död',
  '112': 'e',
  '113': 'ed',
  '114': 'efter',
  '115': 'el',
  '116': 'eller',
  '117': 'eld',
  '120': 'em',
  '121': 'en',
  '122': 'er',
  '123': 'es',
  '124': 'et',
  '125': 'f',
  '126': 'fn',
  '127': 'fal',
  '130': 'faller',
  '131': 'fan',
  '132': 'far',
  '133': 'fat',
  '134': 'fe',
  '135': 'fel',
  '136': 'fi',
  '137': 'fienden',
  '140': 'fin',
  '141': 'fi',
  '142': 'flagg',
  '143': 'fo',
  '144': 'folk',
  '145': 'for',
  '146': 'fr',
  '147': 'fram',
  '150': 'frå',
  '151': 'ft',
  '152': 'full',
  '153': 'fy',
  '154': 'få',
  '155': 'får',
  '156': 'fä',
  '157': 'fält',
  '160': 'fö',
  '161': 'för',
  '162': 'g',
  '163': 'ga',
  '164': 'gar',
  '165': 'ge',
  '166': 'gen',
  '167': 'ger',
  '170': 'gi',
  '171': 'gl',
  '172': 'gn',
  '173': 'go',
  '174': 'god',
  '175': 'gr',
  '176': 'gra',
  '177': 'gt',
  '200': '8',
  '201': 'gu',
  '202': 'gul',
  '203': 'gå',
  '204': 'går',
  '205': 'gä',
  '206': 'gö',
  '207': 'gör',
  '210': 'h',
  '211': 'ha',
  '212': 'haf',
  '213': 'hal',
  '214': 'hamm',
  '215': 'han',
  '216': 'hand',
  '217': 'har',
  '220': 'he',
  '221': 'hel',
  '222': 'hjelp',
  '223': 'hem',
  '224': 'her',
  '225': 'het',
  '226': 'hi',
  '227': 'tal up',
  '230': 'hin',
  '231': 'hit',
  '232': 'ho',
  '233': 'hop',
  '234': 'hos',
  '235': 'hu',
  '236': 'hundra',
  '237': 'hur',
  '240': 'hus',
  '241': 'hy',
  '242': 'hå',
  '243': 'hål',
  '244': 'hår',
  '245': 'hä',
  '246': 'hän',
  '247': 'här',
  '250': 'hö',
  '251': 'hög',
  '252': 'höger',
  '253': 'hör',
  '254': 'i',
  '255': 'ja',
  '256': 'jag',
  '257': 'if',
  '260': 'ig',
  '261': 'ik',
  '262': 'il',
  '263': 'illa',
  '264': 'in',
  '265': 'ing',
  '266': 'intet',
  '267': 'is',
  '270': 'ju',
  '271': 'jå',
  '272': 'galit',
  '273': 'jåm',
  '274': 'k',
  '275': 'kk',
  '276': 'ka',
  '277': 'kal',
  '300': 'kan',
  '301': 'kar',
  '302': 'ke',
  '303': 'ki',
  '304': 'kl',
  '305': 'kla',
  '306': 'kn',
  '307': 'kna',
  '310': 'ko',
  '311': 'kom',
  '312': 'kon',
  '313': 'kor',
  '314': 'kr',
  '315': 'kra',
  '316': 'ku',
  '317': 'kv',
  '320': 'kva',
  '321': 'ky',
  '322': 'kå',
  '323': 'kä',
  '324': 'kö',
  '325': 'l',
  '326': 'la',
  '327': 'log',
  '330': 'land',
  '331': 'le',
  '332': 'lek',
  '333': 'lem',
  '334': 'ler',
  '335': 'let',
  '336': 'li',
  '337': 'lif',
  '340': 'lig',
  '341': 'lik',
  '342': 'ljus',
  '343': 'lo',
  '344': 'lt',
  '345': 'lu',
  '346': 'ly',
  '347': 'lå',
  '350': 'låg',
  '351': 'lång',
  '352': 'lä',
  '353': 'läg',
  '354': 'läng',
  '355': 'lär',
  '356': 'lät',
  '357': 'lö',
  '360': 'lön',
  '361': 'lös',
  '362': 'm',
  '363': 'ma',
  '364': 'man',
  '365': 'mat',
  '366': 'me',
  '367': 'med',
  '370': 'mellan',
  '371': 'mem',
  '372': 'mer',
  '373': 'mi',
  '374': 'mig',
  '375': 'mil',
  '376': 'min',
  '377': 'miss',
  '400': '9',
  '401': 'mit',
  '402': 'mo',
  '403': 'mor',
  '404': 'mot',
  '405': 'mt',
  '406': 'mu',
  '407': 'mur',
  '410': 'my',
  '411': 'mycke',
  '412': 'må',
  '413': 'mål',
  '414': 'mån',
  '415': 'måt',
  '416': 'mä',
  '417': 'mär',
  '420': 'mö',
  '421': 'mör',
  '422': 'n',
  '423': 'na',
  '424': 'namn',
  '425': 'natt',
  '426': 'nd',
  '427': 'ne',
  '430': 'nej',
  '431': 'ner',
  '432': 'ng',
  '433': 'ni',
  '434': 'nog',
  '435': 'nor',
  '436': 'na',
  '437': 'nu',
  '440': 'ny',
  '441': 'nyfe',
  '442': 'nå',
  '443': 'nä',
  '444': 'när',
  '445': 'näft',
  '446': 'nö',
  '447': 'nöd',
  '450': 'o',
  '451': 'och',
  '452': 'od',
  '453': 'om',
  '454': 'on',
  '455': 'opp',
  '456': 'or',
  '457': 'ord',
  '460': 'oss',
  '461': 'ott',
  '462': 'p',
  '463': 'pa',
  '464': 'par',
  '465': 'pe',
  '466': 'pen',
  '467': 'per',
  '470': 'pi',
  '471': 'pl',
  '472': 'po',
  '473': 'por',
  '474': 'post',
  '475': 'pr',
  '476': 'pu',
  '477': 'på',
  '500': 'r',
  '501': 'ra',
  '502': 'ran',
  '503': 'rd',
  '504': 're',
  '505': 'regn',
  '506': 'ren',
  '507': 'ri',
  '510': 'rikad',
  '511': 'rin',
  '512': 'ro',
  '513': 'rt',
  '514': 'ru',
  '515': 'rum',
  '516': 'ry',
  '517': 'rym',
  '520': 'rå',
  '521': 'råd',
  '522': 'rä',
  '523': 'räk',
  '524': 'rät',
  '525': 'vänla',
  '526': 'rö',
  '527': 'rök',
  '530': 's',
  '531': 'sa',
  '532': 'sak',
  '533': 'sal',
  '534': 'sam',
  '535': 'san',
  '536': 'se',
  '537': 'seg',
  '540': 'sen',
  '541': 'ser',
  '542': 'sh',
  '543': 'shiffer',
  '544': 'sk',
  '545': 'skall',
  '546': 'skepp',
  '547': 'skicka',
  '550': 'skog',
  '551': 'skrif',
  '552': 'si',
  '553': 'sig',
  '554': 'sin',
  '555': 'sit',
  '556': 'sjä',
  '557': 'upm up',
  '560': 'sjön',
  '561': 'sl',
  '562': 'slut',
  '563': 'sm',
  '564': 'sn',
  '565': 'so',
  '566': 'sol',
  '567': 'som',
  '570': 'sor',
  '571': 'sp',
  '572': 'spr',
  '573': 'st',
  '574': 'stad',
  '575': '',
  '576': 'stor',
  '577': 'str',
  '600': 'sv',
  '601': 'svar',
  '602': 'svenik',
  '603': 'sy',
  '604': 'så',
  '605': 'sä',
  '606': 'sät',
  '607': 'sö',
  '610': 't',
  '611': 'ta',
  '612': 'tan',
  '613': 'te',
  '614': 'telegr.',
  '615': 'ten',
  '616': 'ter',
  '617': 'ti',
  '620': 'tid',
  '621': 'til',
  '622': 'tim',
  '623': 'tin',
  '624': 'to',
  '625': 'tor',
  '626': 'tr',
  '627': 'tu',
  '630': 'tull',
  '631': 'tusend',
  '632': 'tv',
  '633': 'ty',
  '634': 'tyfk',
  '635': 'tå',
  '636': 'tä',
  '637': 'tö',
  '640': 'u',
  '641': 'uk',
  '642': 'ull',
  '643': 'un',
  '644': 'up',
  '645': 'ur',
  '646': 'un',
  '647': 'ut',
  '650': 'v',
  '651': 'va',
  '652': 'vad',
  '653': 'vakt',
  '654': 'vai',
  '655': 'van',
  '656': 'var',
  '657': 'vat',
  '660': 've',
  '661': 'vem',
  '662': 'ven',
  '663': 'venster',
  '664': 'ver',
  '665': 'vi',
  '666': 'vid',
  '667': 'vig',
  '670': 'vil',
  '671': 'vin',
  '672': 'vind',
  '673': 'vit',
  '674': 'vr',
  '675': 'vu',
  '676': 'vå',
  '677': 'våld',
  '700': 'talflut',
  '701': 'vår',
  '702': 'vä',
  '703': 'väg',
  '704': 'väl',
  '705': 'väm',
  '706': 'vär',
  '707': 'repeter',
  '710': 'x',
  '711': 'y',
  '712': 'z',
  '713': 'å',
  '714': 'ål',
  '715': 'ån',
  '716': 'ång',
  '717': 'år',
  '720': 'åt',
  '721': 'åter',
  '722': 'tal.ned',
  '723': 'ä',
  '724': 'äkt',
  '725': 'äg',
  '726': 'äll',
  '727': 'ändra',
  '730': 'äm',
  '731': 'än',
  '732': 'äng',
  '733': 'änk',
  '734': 'är',
  '735': 'ät',
  '736': 'ätt',
  '737': 'ö',
  '740': 'öd',
  '741': 'öf',
  '742': 'öfver',
  '743': 'ög',
  '744': 'ögd',
  '745': 'ök',
  '746': 'öm',
  '747': 'ör',
  '750': 'öt',
  '751': 'ött',
  '752': '',
  '753': '',
  '754': '',
  '755': 'upm ned',
  '756': '',
  '757': 'ser ej',
  '760': '',
  '761': '',
  '762': '',
  '763': '',
  '764': '',
  '765': '',
  '766': '',
  '767': '',
  '770': 'långs',
  '771': '',
  '772': '',
  '773': '',
  '774': '',
  '775': '',
  '776': '',
  '777': ' ',
};

final _CODEBOOK_EDELCRANTZ_1808 = {
  '000': ' ',
  '001': '1',
  '002': '2',
  '003': '3',
  '004': '3',
  '005': '4',
  '006': '5',
  '007': '7',
  '010': 'år ni i ordning?',
  '011': '8',
  '012': '9',
  '013': 'a',
  '014': 'ad',
  '015': 'af',
  '016': 'akt',
  '017': 'al',
  '017': 'all',
  '020': 'telegrafen år i olag.',
  '021': 'alt',
  '022': 'an',
  '023': 'ar',
  '024': 'are',
  '025': 'as',
  '026': 'ast',
  '027': 'at',
  '030': 'luckorna stå ej vål.',
  '031': 'b',
  '031': 'bb',
  '032': 'ba',
  '033': 'bak',
  '034': 'bar',
  '035': 'be',
  '036': 'bi',
  '037': 'bl',
  '040': 'luckorne spela och behofva lastas med mera tyngd.',
  '041': 'blif',
  '041': 'blef',
  '042': 'bland',
  '043': 'bo',
  '044': 'bo',
  '045': 'bordt',
  '046': 'br',
  '047': 'bref',
  '050': 'knyt om trådarne.',
  '051': 'brod',
  '052': 'bu',
  '053': 'by',
  '054': 'bå',
  '055': 'bårt',
  '056': 'båt',
  '057': 'bä',
  '060': 'hvilken Station gor uppehållet?',
  '061': 'båst',
  '062': 'bó',
  '063': 'bór',
  '064': 'd',
  '065': 'da',
  '066': 'dag',
  '067': 'dde',
  '070': 'telegrafisterne måste vara borta.',
  '071': 'del',
  '072': 'dem',
  '073': 'dden',
  '074': 'der',
  '075': 'des',
  '076': 'det',
  '077': 'di',
  '100': 'dig',
  '101': 'station vifar ingen rorelfe.',
  '102': 'din',
  '103': 'dit',
  '104': 'do',
  '105': 'dr',
  '106': 'dt',
  '107': 'du',
  '110': 'dy',
  '111': 'pasfa upp båttre vid ansvar..',
  '112': 'dyr',
  '113': 'dá',
  '114': 'då',
  '115': 'dä',
  '116': 'dod',
  '117': 'e',
  '120': 'ed',
  '121': 'pasfa upp innan dagningen..',
  '122': 'ej',
  '123': 'el',
  '124': 'en',
  '125': 'er',
  '126': 'ert',
  '127': 'et',
  '130': 'f',
  '130': 'ff',
  '131': 'kommer at straffas for sin forsummelfe med arrest eller ...',
  '132': 'fa',
  '133': 'fal',
  '134': 'fan',
  '135': 'far',
  '136': 'fast',
  '137': 'fat',
  '140': 'fe',
  '141': 'kommer att flyttas till tjenstgoring på canonslupar eller fåstning.',
  '142': 'fel',
  '143': 'fi',
  '144': 'fick',
  '145': 'fin',
  '146': 'finsk',
  '147': 'fl',
  '150': 'fo',
  '151': 'fort, eller: låt gå fortare',
  '152': 'folk',
  '153': 'for',
  '154': 'fr',
  '155': 'fram',
  '156': 'fri',
  '157': 'från',
  '160': 'ft',
  '160': 'vt',
  '161': 'långsamt, eller: låt gå långsammare.',
  '162': 'fy',
  '163': 'få',
  '163': 'fått',
  '164': 'får',
  '165': 'få',
  '166': 'fo',
  '167': 'for',
  '170': 'forst',
  '171': 'gor intet oriktiga Tal- och upmårksamhets tecken.',
  '172': '',
  '173': 'g',
  '173': 'gg',
  '174': 'ga',
  '175': 'gat',
  '176': 'gar',
  '177': 'gd',
  '200': 'ga',
  '200': 'ge',
  '201': 'gen',
  '202': 'se vål på tangenterne och tenarne att ingen oreda sker.',
  '203': 'ger',
  '204': 'gi',
  '205': 'gick',
  '206': 'gjord',
  '206': 'gjort',
  '207': 'gl',
  '210': 'gn',
  '211': 'god',
  '212': 'lås båttre Tabellerne och gor ej tio signaler for en.',
  '213': 'gr',
  '214': 'gt',
  '214': 'kt',
  '215': 'gu',
  '216': 'gå',
  '216': 'gått',
  '217': 'gång',
  '220': 'går',
  '221': 'go',
  '222': 'continuera dår ni sist flutade.',
  '223': 'gor',
  '224': 'h',
  '225': 'ha',
  '226': 'hat',
  '227': 'tal n. ut',
  '230': 'haft',
  '231': 'hal',
  '232': 'repetra sista rapporten.',
  '233': 'hal',
  '234': 'hamn',
  '235': 'han',
  '236': 'hans',
  '237': 'har',
  '240': 'hem',
  '241': 'hen',
  '242': 'hjelp, eller: laga om machindelen N:o',
  '243': 'het',
  '243': 'hett',
  '244': 'hi',
  '245': 'hin',
  '246': 'hit',
  '247': 'ho',
  '250': 'hon',
  '251': 'hop',
  '251': 'hopp',
  '252': 'tala, fastån vi intet repetar, vi se ganska vål hår.',
  '253': 'hos',
  '254': 'hu',
  '255': 'hur',
  '256': 'hus',
  '257': 'hy',
  '260': 'hå',
  '261': 'hål',
  '261': 'håll',
  '262': 'vi tala, men repetera intet, vi se illa hår.',
  '263': 'har',
  '264': 'hå',
  '265': 'hån',
  '266': 'hår',
  '267': 'ho',
  '270': 'hog',
  '271': 'hor',
  '272': 'galit, eller: stryk ut sista tecknet.',
  '273': 'i',
  '274': 'ja',
  '275': 'jag',
  '276': 'il',
  '277': 'in',
  '300': 'is',
  '301': 'it',
  '302': 'ja',
  '303': 'vånta på svar.',
  '304': 'jå',
  '305': 'k',
  '305': 'kk',
  '305': 'c',
  '306': 'ka',
  '307': 'kal',
  '310': 'kan',
  '311': 'kar',
  '312': 'ki',
  '313': 'sått up en flagg',
  '314': 'kl',
  '315': 'kn',
  '316': 'ko',
  '317': 'kom',
  '320': 'kor',
  '321': 'kort',
  '322': 'kr',
  '323': '',
  '324': 'kring',
  '325': 'ku',
  '325': 'kv',
  '326': 'kull',
  '327': 'kvar',
  '330': 'ky',
  '331': 'kå',
  '332': 'ko',
  '333': 'hur står till?',
  '334': 'l',
  '334': 'll',
  '335': 'la',
  '336': 'lag',
  '337': 'land',
  '340': 'ld',
  '341': 'le',
  '342': 'lem',
  '343': 'sedan sista rapporten har intet forefallit.',
  '344': 'ler',
  '345': 'li',
  '346': 'lif',
  '347': 'lig',
  '350': 'lik',
  '351': 'ljus',
  '352': 'lo',
  '353': 'vet ni om ...',
  '354': 'lots',
  '355': 'ls',
  '356': 'lt',
  '357': 'lu',
  '360': 'lugn',
  '361': 'ly',
  '362': 'lå',
  '363': 'låt ofs veta ...',
  '364': 'låg',
  '365': 'lång',
  '366': 'la',
  '367': 'lag',
  '370': 'lår',
  '371': 'låt',
  '371': 'lått',
  '372': 'lo',
  '373': 'har ni rått forstått rapporten?',
  '374': 'lon',
  '375': 'los',
  '376': 'm',
  '376': 'mm',
  '377': 'ma',
  '400': 'man',
  '401': 'mat',
  '402': 'med',
  '403': 'men',
  '404': 'har intet ...',
  '405': 'mer',
  '406': 'mi',
  '407': 'midt',
  '410': 'mig',
  '411': 'mil',
  '412': 'min',
  '413': 'mis',
  '414': 'kan intet ...',
  '415': 'mit',
  '416': 'mor',
  '417': 'mo',
  '420': 'mot',
  '421': 'mu',
  '422': 'mur',
  '423': 'my',
  '424': 'fåar intet ...',
  '425': 'må',
  '426': 'mål',
  '427': 'mån',
  '430': 'måst',
  '431': 'måt',
  '432': 'må',
  '433': 'mast',
  '434': 'ser intet ...',
  '435': 'mår',
  '436': 'mo',
  '437': 'mor',
  '440': '',
  '441': 'n',
  '441': 'nn',
  '442': 'na',
  '443': 'namn',
  '444': 'vet intet ...',
  '445': 'natt',
  '446': 'nd',
  '446': 'nt',
  '447': 'ned',
  '450': 'nej',
  '451': 'ng',
  '452': 'ni',
  '453': 'ning',
  '454': 'ger tillkånna att',
  '455': 'nog',
  '456': 'ns',
  '457': 'nu',
  '460': 'ny',
  '461': 'nyss',
  '462': 'nytt',
  '463': 'nå',
  '464': 'begår los att ...',
  '465': 'nå',
  '466': 'når',
  '467': 'nåst',
  '470': 'no',
  '471': 'nod',
  '472': 'o',
  '473': 'och',
  '474': 'begar aflosning ...',
  '475': 'om',
  '476': 'ond',
  '476': 'ont',
  '477': 'op',
  '477': 'opp',
  '500': 'ord',
  '501': 'os',
  '501': 'oss',
  '502': 'ot',
  '502': 'ott',
  '503': 'p',
  '503': 'pp',
  '504': 'pa',
  '505': 'behofverny Telegrafart. N:o',
  '506': 'par',
  '507': 'pe',
  '510': 'pi',
  '511': 'pl',
  '512': 'po',
  '513': 'post',
  '514': 'pr',
  '515': 'sjuk, behofver hjelp.',
  '516': 'pu',
  '517': 'på',
  '520': 'r',
  '520': 'rr',
  '521': 'ra',
  '522': 're',
  '523': 'regn',
  '524': 'ren',
  '525': 'vånta',
  '526': 'rna',
  '527': 'rnas',
  '530': 'ri',
  '531': 'ro',
  '532': 'ru',
  '533': 'rum',
  '534': 'ry',
  '535': '',
  '536': 'rå',
  '537': 'råd',
  '540': 'rå',
  '541': 'råt',
  '542': 'ro',
  '543': 'rok',
  '544': 's',
  '544': 'ss',
  '545': 'telegrafen har blisvit befokt af ...',
  '546': 'sa',
  '547': 'sak',
  '550': 'sagd',
  '550': 'sagt',
  '551': 'sal',
  '552': 'salt',
  '553': 'sam',
  '553': 'samt',
  '554': 'san',
  '554': 'sant',
  '555': 'den gisna Befallningen år verkståld.',
  '556': 'se',
  '557': 'sen',
  '560': 'sent',
  '561': 'ser',
  '562': 'sk',
  '563': 'ska',
  '564': 'ske',
  '564': 'skett',
  '565': 'har farit bort ...',
  '566': 'sker',
  '567': 'skepp',
  '570': 'skall',
  '571': 'skått',
  '572': 'si',
  '573': 'sjelf',
  '574': 'sig',
  '575': 'har kommit hit ...',
  '576': 'sin',
  '577': 'sjon',
  '600': 'sist',
  '601': 'sit',
  '602': 'sl',
  '603': 'slog',
  '604': 'slut',
  '605': 'slå',
  '606': 'håll up med alt annat och repetera genast.',
  '607': 'sm',
  '610': 'sn',
  '611': 'snar',
  '612': 'so',
  '613': 'sol',
  '614': 'som',
  '615': 'sor',
  '616': 'en ganska vigtid underråttelse:',
  '617': 'sno',
  '620': 'sp',
  '621': 'spr',
  '622': 'st',
  '623': 'stad',
  '624': 'stark',
  '625': 'sten',
  '626': 'bor genast communiceras med ...',
  '627': 'stor',
  '630': 'storm',
  '631': 'str',
  '632': 'strand',
  '633': 'straxt',
  '634': 'stå',
  '635': 'stod',
  '636': 'allmån upmårksamhet fordras:',
  '637': 'su',
  '637': 'sv',
  '640': 'svag',
  '641': 'svensk',
  '642': 'svar',
  '643': 'svår',
  '644': 'sy',
  '645': 'syns',
  '646': 'allmånna ordres eller tal till alla Stationerne:',
  '647': 'så',
  '650': 'så',
  '650': 'såt',
  '651': 'sått',
  '652': 'so',
  '653': '',
  '654': 't',
  '654': 'tt',
  '655': 'ta',
  '656': 'permission beviljas Norra leden på ...',
  '657': 'tal',
  '660': 'te',
  '661': 'ti',
  '662': 'tid',
  '663': 'tig',
  '664': 'til',
  '665': 'tim',
  '666': 'permission beviljas Ostra leden på ...',
  '667': 'tion',
  '670': 'to',
  '671': 'tog',
  '672': 'tr',
  '673': 'tro',
  '674': 'ts',
  '675': 'tu',
  '675': 'tv',
  '676': 'permission beviljas Sodra leden på ...',
  '677': '',
  '700': 'talslut',
  '701': 'ty',
  '702': 'tå',
  '703': 'ta',
  '704': 'to',
  '705': '',
  '706': 'u',
  '707': 'allmån permission beviljas på ...',
  '710': 'ul',
  '710': 'ull',
  '711': 'up',
  '712': 'ur',
  '713': 'ut',
  '714': 'v',
  '714': 'w',
  '715': 'va',
  '716': 'vad',
  '717': '',
  '720': 'vagt',
  '721': 'val',
  '722': 'tal s.',
  '723': 'van',
  '724': 'var',
  '725': 'vart',
  '726': 've',
  '727': '',
  '730': 'ved',
  '731': 'ver',
  '732': 'vi',
  '733': 'vis',
  '734': 'vid',
  '735': 'vig',
  '736': 'vil',
  '737': '',
  '740': 'vin',
  '741': 'vind',
  '742': 'vr',
  '743': 'va',
  '744': 'våld',
  '745': 'vår',
  '746': 'vårt',
  '747': '',
  '750': 'vå',
  '751': 'våg',
  '752': 'vål',
  '753': 'vån',
  '754': 'vår',
  '755': 'x',
  '756': 'y',
  '757': '',
  '760': 'z',
  '761': 'å',
  '762': 'ång',
  '763': 'år',
  '764': 'åt',
  '765': 'å',
  '766': 'åg',
  '766': 'ågg',
  '767': '',
  '770': 'ål',
  '770': 'åll',
  '771': 'ån',
  '772': 'år',
  '773': 'åt',
  '773': 'ått',
  '774': 'o',
  '775': 'om',
  '776': 'on',
  '777': ' ',
  'a000': '',
  'a001': '',
  'a002': '',
  'a003': '',
  'a004': '',
  'a005': '',
  'a006': '',
  'a007': '',
  'a010': '',
  'a011': 'afresa',
  'a012': 'afstånd',
  'a013': 'afsånda',
  'a014': 'afton',
  'a015': 'aldeles',
  'a016': 'aldrig',
  'a017': 'alla',
  'a020': '',
  'a021': 'allena',
  'a022': 'allestades',
  'a023': 'allmån',
  'a024': 'altid',
  'a025': 'amiral',
  'a026': 'ande',
  'a027': 'andra',
  'a030': '',
  'a031': 'angelågen',
  'a032': 'angående',
  'a033': 'ankomma',
  'a034': 'ankra',
  'a035': 'annars',
  'a036': 'annorlunda',
  'a037': 'annorstades',
  'a040': '',
  'a041': 'antal',
  'a042': 'antingen',
  'a043': 'armee',
  'a044': 'arna',
  'a045': 'arrest',
  'a046': 'artilleri',
  'a047': 'attaquera',
  'a050': '',
  'a051': 'bakom',
  'a052': 'Bataillon',
  'a053': 'befalla',
  'a054': 'Befål',
  'a055': 'begynna',
  'a056': 'begåra',
  'a057': 'behofva',
  'a060': '',
  'a061': 'bekant',
  'a062': 'beratta',
  'a063': 'bestålla',
  'a064': 'betyda',
  'a065': 'bittida',
  'a066': 'blifva',
  'a067': 'blåsa',
  'a070': '',
  'a071': 'bonde',
  'a072': 'borde',
  'a073': 'bredvid',
  'a074': 'brinna',
  'a075': 'bryta',
  'a076': 'brånna',
  'a077': 'både',
  'a100': '',
  'a101': '',
  'a102': '',
  'a103': 'båtsman',
  'a104': 'båra',
  'a105': 'båttre',
  'a106': 'dansk',
  'a107': 'datum',
  'a110': 'denna',
  'a111': '',
  'a112': 'dessa',
  'a113': 'detta',
  'a114': 'deraf',
  'a115': 'deras',
  'a116': 'derefter',
  'a117': 'derfore',
  'a120': 'derifrån',
  'a121': '',
  'a122': 'derigenom',
  'a123': 'dessutom',
  'a124': 'dima',
  'a125': 'diverse',
  'a126': 'difva',
  'a127': 'drottning',
  'a130': 'droija',
  'a131': '',
  'a132': 'edelcrantz',
  'a133': 'efter',
  'a134': 'eftermiddag',
  'a135': 'ehuru',
  'a136': 'eljest',
  'a137': 'eller',
  'a140': 'elfva',
  'a141': '',
  'a142': 'emarkera',
  'a143': 'emedlertid',
  'a144': 'ena',
  'a145': 'endast',
  'a146': 'ende',
  'a147': 'engelsk',
  'a150': 'escadre',
  'a151': '',
  'a152': 'era',
  'a153': 'extra',
  'a154': 'fara',
  'a155': 'fartyg',
  'a156': 'fastån',
  'a157': 'fatta',
  'a160': 'fiende',
  'a161': '',
  'a162': 'finland',
  'a163': 'finna',
  'a164': 'finsk',
  'a165': 'flagga',
  'a166': 'flera',
  'a167': 'flotta',
  'a170': 'flytta',
  'a171': '',
  'a172': 'framdeles',
  'a173': 'fransysk',
  'a174': 'fredag',
  'a175': 'fregatt',
  'a176': 'frisk',
  'a177': 'fråga',
  'a200': '',
  'a201': '',
  'a202': '',
  'a203': 'frånvarande',
  'a204': 'frammande',
  'a205': 'fårdig',
  'a206': 'fåstning',
  'a207': 'folja',
  'a210': 'fora',
  'a211': 'forbi',
  'a212': '',
  'a213': 'forbjuda',
  'a214': 'forbud',
  'a215': 'fore',
  'a216': 'forena',
  'a217': 'foretagande',
  'a220': 'forgåfves',
  'a221': 'forklara',
  'a222': '',
  'a223': 'forliden',
  'a224': 'forlora',
  'a225': 'forsta',
  'a226': 'forsta',
  'a227': 'forstått',
  'a230': 'forstått intet',
  'a231': 'forsvinna',
  'a232': '',
  'a233': 'forsoka',
  'a234': 'fortekning',
  'a235': 'forut',
  'a236': 'galere',
  'a237': 'ganska',
  'a240': 'garnison',
  'a241': 'genast',
  'a242': '',
  'a243': 'genom',
  'a244': 'general',
  'a245': 'gerna',
  'a246': 'gifva',
  'a247': 'gjorde',
  'a250': 'glomma',
  'a251': 'grånts',
  'a252': '',
  'a253': 'gora',
  'a254': 'gotheborg',
  'a255': 'hade',
  'a256': 'hafvet',
  'a257': 'handelsfartyg',
  'a260': 'handlande',
  'a261': 'henne',
  'a262': '',
  'a263': 'hertig',
  'a264': 'hindra',
  'a265': 'hjelpa',
  'a266': 'hinna',
  'a267': 'hollåndsk',
  'a270': 'honom',
  'a271': 'horizont',
  'a272': '',
  'a273': 'hundrade',
  'a274': 'hvarfore',
  'a275': 'hvarken',
  'a276': 'hvalken',
  'a277': 'hålla',
  'a300': '',
  'a301': 'hålsa',
  'a302': 'håmta',
  'a303': '',
  'a304': 'håndelse',
  'a305': 'hora',
  'a306': 'i afton',
  'a307': 'i dag',
  'a310': 'i fall',
  'a311': 'i got tid',
  'a312': 'i forgår',
  'a313': '',
  'a314': 'i går',
  'a315': 'illa',
  'a316': 'i morgon',
  'a317': 'i natt',
  'a320': 'infanteri',
  'a321': 'ingen',
  'a322': 'innan',
  'a323': '',
  'a324': 'innom',
  'a325': 'instruction',
  'a326': 'i synnerhet',
  'a327': 'intet',
  'a330': 'i ofvermorgon',
  'a331': 'kalla',
  'a332': 'kanon',
  'a333': '',
  'a334': 'kapare',
  'a335': 'karlscrona',
  'a336': 'kasta',
  'a337': 'kavalleri',
  'a340': 'kejs. i ryssland',
  'a341': 'klaga',
  'a342': 'klippa',
  'a343': '',
  'a344': 'klådet',
  'a345': 'komma',
  'a346': 'kommendant',
  'a347': 'kongl. maj:t',
  'a350': 'kontinuera',
  'a351': 'kosta',
  'a352': 'krut',
  'a353': '',
  'a354': 'kryssa',
  'a355': 'kusten',
  'a356': 'kunna',
  'a357': 'kurir',
  'a360': 'kånna',
  'a361': 'kolden',
  'a362': 'kopa',
  'a363': '',
  'a364': 'lagom',
  'a365': 'landshofding',
  'a366': 'landstiga',
  'a367': 'ligga',
  'a370': 'lika',
  'a371': 'likvål',
  'a372': 'liten',
  'a373': '',
  'a374': 'lovera',
  'a375': 'lucka',
  'a376': 'luften',
  'a377': 'lycka',
  'a400': '',
  'a401': 'lyfta',
  'a402': 'låfva',
  'a403': 'låta',
  'a404': '',
  'a405': 'lågga',
  'a406': 'låmna',
  'a407': 'långe',
  'a410': 'lordag',
  'a411': 'manskap',
  'a412': 'marche',
  'a413': 'medan',
  'a414': '',
  'a415': 'mellan',
  'a416': 'min h. tit.',
  'a417': 'middag',
  'a420': 'mindre',
  'a421': 'morgon',
  'a422': 'mottaga',
  'a423': 'motvind',
  'a424': '',
  'a425': 'mycket',
  'a426': 'månad',
  'a427': 'måndag',
  'a430': 'många',
  'a431': 'måste',
  'a432': 'mojlig',
  'a433': 'mote',
  'a434': '',
  'a435': 'nalkas',
  'a436': 'nation',
  'a437': 'nummer',
  'a440': 'nedre',
  'a441': 'nordan',
  'a442': 'nordost',
  'a443': 'nordvest',
  'a444': '',
  'a445': 'norrlnad',
  'a446': 'norromkring',
  'a447': 'nyttig',
  'a450': 'någon',
  'a451': 'nårvarande',
  'a452': 'nåstkommande',
  'a453': 'nodvåndig',
  'a454': '',
  'a455': 'oansedt',
  'a456': 'obeståmd',
  'a457': 'observera',
  'a460': 'officerare',
  'a461': 'ofta',
  'a462': 'ofvanpå',
  'a463': 'oforvarandes',
  'a464': '',
  'a465': 'ogerna',
  'a466': 'olika',
  'a467': 'olycka',
  'a470': 'omsider',
  'a471': 'omojlig',
  'a472': 'onsdag',
  'a473': 'ordning',
  'a474': '',
  'a475': 'ordres',
  'a476': 'orsak',
  'a477': 'orått',
  'a500': '',
  'a501': 'osann',
  'a502': 'otydlig',
  'a503': 'parol',
  'a504': 'penningar',
  'a505': '',
  'a506': 'permission',
  'a507': 'person',
  'a510': 'pettersburg',
  'a511': 'proviant',
  'a512': 'påminna',
  'a513': 'rapport',
  'a514': 'rapportera',
  'a515': '',
  'a516': 'regemente',
  'a517': 'regering',
  'a520': 'reglemente',
  'a521': 'reparera',
  'a522': 'repetera',
  'a523': 'resa',
  'a524': 'riksdaler',
  'a525': '',
  'a526': 'rysk',
  'a527': 'råkna',
  'a530': 'sade',
  'a531': 'samla',
  'a532': 'samma',
  'a533': 'sammalunda',
  'a534': 'savolax',
  'a535': '',
  'a536': 'shef',
  'a537': 'sedan',
  'a540': 'sednare',
  'a541': 'segla',
  'a542': 'sida',
  'a543': 'signal',
  'a544': 'signalbokens',
  'a545': '',
  'a546': 'signal:de skepp',
  'a547': 'sista',
  'a550': 'sjuk',
  'a551': 'skaffa',
  'a552': 'skicka',
  'a553': 'siffer',
  'a554': 'skillingar',
  'a555': '',
  'a556': 'skingra',
  'a557': 'skjuta',
  'a560': 'skog',
  'a561': 'skola',
  'a562': 'sktifva',
  'a563': 'skule',
  'a564': 'skynda',
  'a565': '',
  'a566': 'skåne',
  'a567': 'skårgård',
  'a570': 'sluta',
  'a571': 'soldat',
  'a572': 'somliga',
  'a573': 'sommar',
  'a574': 'spannemål',
  'a575': '',
  'a576': 'solrok',
  'a577': 'stadna',
  'a600': '',
  'a601': 'station',
  'a602': 'stilla',
  'a603': 'stockholm',
  'a604': 'stundom',
  'a605': 'stycke',
  'a606': '',
  'a607': 'styra',
  'a610': 'stålle',
  'a611': 'ståndig',
  'a612': 'storre',
  'a613': 'sudost',
  'a614': 'sudvest',
  'a615': 'sundet',
  'a616': '',
  'a617': 'svara',
  'a620': 'sveaborg',
  'a621': 'sverige',
  'a622': 'sysselsatt',
  'a623': 'sådan',
  'a624': 'således',
  'a625': 'såra',
  'a626': '',
  'a627': 'såsom',
  'a630': 'såga',
  'a631': 'sålja',
  'a632': 'sållan',
  'a633': 'såarskild',
  'a634': 'såtta',
  'a635': 'soder',
  'a636': '',
  'a637': 'soka',
  'a640': 'sondag',
  'a641': 'sonder',
  'a642': 'tabell',
  'a643': 'tackar',
  'a644': 'taktik',
  'a645': 'taga',
  'a646': '',
  'a647': 'tela',
  'a650': 'tecken',
  'a651': 'telegraf',
  'a652': 'telegrafist',
  'a653': 'termin',
  'a654': 'tidningar',
  'a655': 'tjenstgoring',
  'a656': '',
  'a657': 'tilbaka',
  'a660': 'tilfålle',
  'a661': 'tillika',
  'a662': 'tilstånd',
  'a663': 'tils vidare',
  'a664': 'timma',
  'a665': 'tio',
  'a666': '',
  'a667': 'tisdag',
  'a670': 'tolf',
  'a671': 'torsdag',
  'a672': 'transport',
  'a673': 'tropp',
  'a674': 'tunna',
  'a675': 'tusende',
  'a676': '',
  'a677': 'tvifla',
  'a700': 'tydlig',
  'a701': 'tysk',
  'a702': 'undan',
  'a703': 'undantagande',
  'a704': 'under',
  'a705': 'underråttelse',
  'a706': 'undvika',
  'a707': '',
  'a710': 'underdånig',
  'a711': 'ungefår',
  'a712': 'uphora',
  'a713': 'upskjuta',
  'a714': 'uptåcka',
  'a715': 'utan',
  'a716': 'utlupen',
  'a717': '',
  'a720': 'utom',
  'a721': 'vakthafvande',
  'a722': 'vara',
  'a723': 'vatten',
  'a724': 'vecka',
  'a725': 'verkstålla',
  'a726': 'vester',
  'a727': '',
  'a730': 'vik',
  'a731': 'vilja',
  'a732': 'vinter',
  'a733': 'visa',
  'a734': 'våra',
  'a735': 'våder',
  'a736': 'våderstreck',
  'a737': '',
  'a740': 'vålkomen',
  'a741': 'vånda',
  'a742': 'vårre',
  'a743': 'åbo',
  'a744': 'åland',
  'a745': 'ålandshaf',
  'a746': 'åter',
  'a747': '',
  'a750': 'åtminsone',
  'a751': 'åfven',
  'a752': 'åmna',
  'a753': 'åndteligen',
  'a754': 'ofva',
  'a755': 'ofverste',
  'a756': 'ofver',
  'a757': '',
  'a760': 'ofre',
  'a761': 'onska',
  'a762': 'orlogsfartyg',
  'a763': 'oster',
  'a764': 'osterbottn',
  'a765': 'ostersjon',
  'a766': 'god dag',
  'a767': '',
  'a770': 'hvad nytt',
  'a771': 'hvad fattas',
  'a772': 'passa up',
  'a773': 'foga anstalt',
  'a774': 'skall ske',
  'a775': 'det år bra',
  'a776': 'farvål',
  'a777': '',
};

final _CODEBOOK_EDELCRANTZ_MUSEUM = {
  '000': '0',
  '001': '1',
  '002': '2',
  '003': '3',
  '004': '3',
  '005': '4',
  '006': '5',
  '007': '7',
  '010': ' ',
  '011': '8',
  '012': '9',
  '013': 'a',
  '014': 'aa',
  '015': 'ai',
  '016': 'al',
  '017': 'an',
  '020': 'aan',
  '021': 'ar',
  '022': 'as',
  '023': 'ass',
  '024': 'at',
  '025': 'aat',
  '031': 'b',
  '047': 'c',
  '063': 'd',
  '064': 'de',
  '065': 'den',
  '066': 'del',
  '067': 'do',
  '115': 'e',
  '116': 'ee',
  '117': 'ek',
  '120': 'em',
  '121': 'en',
  '122': 'ensim',
  '123': 'es',
  '124': 'et',
  '130': 'f',
  '173': 'g',
  '224': 'h',
  '225': 'ha',
  '226': 'he',
  '227': 'hi',
  '230': 'ho',
  '231': 'hj',
  '232': 'ht',
  '273': 'i',
  '274': 'ia',
  '275': 'ie',
  '276': 'in',
  '277': 'inn',
  '300': 'im',
  '301': 'is',
  '302': 'it',
  '303': 'j',
  '304': 'ja',
  '305': 'jo',
  '306': 'k',
  '307': 'ka',
  '310': 'ke',
  '311': 'ki',
  '334': 'l',
  '335': 'la',
  '336': 'lla',
  '337': 'lainen',
  '340': 'le',
  '341': 'lle',
  '342': 'llä',
  '376': 'm',
  '377': 'ma',
  '400': 'me',
  '401': 'men',
  '402': 'mi',
  '403': 'min',
  '404': 'mä',
  '441': 'n',
  '442': 'ne',
  '443': 'ng',
  '444': 'nen',
  '445': 'nn',
  '446': 'ns',
  '447': 'nu',
  '472': 'o',
  '473': 'on',
  '474': 'olen',
  '475': 'oi',
  '476': 'os',
  '477': 'ot',
  '503': 'p',
  '504': 'pa',
  '505': 'pe',
  '506': 'pi',
  '507': 'po',
  '510': 'pu',
  '515': 'q',
  '520': 'r',
  '521': 'ra',
  '522': 'ranska',
  '523': 'ri',
  '524': 'ru',
  '525': 'ruosti',
  '526': 'ro',
  '544': 's',
  '545': 'sa',
  '546': 'saksa',
  '547': 'se',
  '550': 'sen',
  '551': 'sill',
  '552': 'sta',
  '553': 'sti',
  '554': 'siitä',
  '654': 't',
  '655': 'ta',
  '656': 'te',
  '657': 'ti',
  '660': 'tä',
  '661': 'tö',
  '670': 'tti',
  '671': 'tästa',
  '672': 'tuosta',
  '706': 'u',
  '707': 'ua',
  '710': 'uo',
  '711': 'ut',
  '712': 'uu',
  '713': 'us',
  '714': 'v',
  '715': 'w',
  '755': 'x',
  '756': 'y',
  '757': 'yi',
  '760': 'yk',
  '761': 'yn',
  '762': 'z',
  '763': 'å',
  '765': 'ä',
  '774': 'ö',
  '775': ',',
  '776': '?',
  '777': '.',
  'a001': 'telegraph_edelcrantz_a_museum_messagereceived',
  'a002': 'telegraph_edelcrantz_a_museum_doyoucopy',
  'a004': 'telegraph_edelcrantz_a_museum_understood',
  'a005': 'telegraph_edelcrantz_a_museum_repeatmessage',
  'a007': 'telegraph_edelcrantz_a_museum_endcommunication',
  'a010': 'telegraph_edelcrantz_a_museum_whoamitalkingto',
  'a020': 'telegraph_edelcrantz_a_museum_tellmemore',
  'a077': 'telegraph_edelcrantz_a_museum_yes',
  'a700': 'telegraph_edelcrantz_a_museum_no',
  'a777': 'telegraph_edelcrantz_a_museum_maybe',
  'a301': 'telegraph_edelcrantz_a_museum_who',
  'a302': 'telegraph_edelcrantz_a_museum_when',
  'a304': 'telegraph_edelcrantz_a_museum_where',
  'a311': 'telegraph_edelcrantz_a_museum_why',
  'a312': 'telegraph_edelcrantz_a_museum_how',
  'a313': 'telegraph_edelcrantz_a_museum_what',
  'a401': 'telegraph_edelcrantz_a_museum_first',
  'a402': 'telegraph_edelcrantz_a_museum_second',
  'a403': 'telegraph_edelcrantz_a_museum_third',
  'a701': 'telegraph_edelcrantz_a_museum_former',
  'a702': 'telegraph_edelcrantz_a_museum_latter',
};

String _nightTime(String code) {
  if (code.startsWith('a')) {
    return ('a' + (777 - int.parse(code.substring(1))).toString().padLeft(3, '0'));
  } else {
    return (777 - int.parse(code)).toString().padLeft(3, '0');
  }
}

Segments encodeEdelcrantzTelegraph(String input, EdelcrantzCodebook language, bool daytime) {
  if (input.isEmpty) return Segments.Empty();

  List<List<String>> encodedText = [];
  Map<String, String> CODEBOOK;
  switch (language) {
    case EdelcrantzCodebook.YEAR_1795:
      CODEBOOK = switchMapKeyValue(_CODEBOOK_EDELCRANTZ_1795);
      break;
    case EdelcrantzCodebook.YEAR_1808:
      CODEBOOK = switchMapKeyValue(_CODEBOOK_EDELCRANTZ_1808);
      break;
    case EdelcrantzCodebook.MUSEUM:
      CODEBOOK = switchMapKeyValue(_CODEBOOK_EDELCRANTZ_MUSEUM);
      break;
  }

  input.split('').forEach((element) {
    if (CODEBOOK[element] != null) {
      if (daytime) {
        encodedText.add(CODEBOOK[element]!.split(''));
      } else {
        encodedText.add(_nightTime(CODEBOOK[element] ?? '').split(''));
      }
    }
  });
  return Segments(displays: encodedText);
}

SegmentsText decodeVisualEdelcrantzTelegraph(List<String>? inputs, EdelcrantzCodebook language, bool daytime) {
  if (inputs == null || inputs.isEmpty) return SegmentsText(displays: [], text: '');

  var displays = <List<String>>[];
  var segment = <String>[];
  String text = '';

  Map<String, String> CODEBOOK;
  switch (language) {
    case EdelcrantzCodebook.YEAR_1795:
      CODEBOOK = _CODEBOOK_EDELCRANTZ_1795;
      break;
    case EdelcrantzCodebook.YEAR_1808:
      CODEBOOK = _CODEBOOK_EDELCRANTZ_1808;
      break;
    case EdelcrantzCodebook.MUSEUM:
      CODEBOOK = _CODEBOOK_EDELCRANTZ_MUSEUM;
      break;
  }

  for (var element in inputs) {
    segment = _stringToSegment(element);
    displays.add(segment);
    if (CODEBOOK[segmentToCode(segment)] != null) {
      if (daytime) {
        text = text + CODEBOOK[segmentToCode(segment)]!;
      } else {
        text = text + CODEBOOK[_nightTime(segmentToCode(segment))]!;
      }
    } else {
      text = text + UNKNOWN_ELEMENT;
    }
  }

  return SegmentsText(displays: displays, text: text);
}

SegmentsText decodeTextEdelcrantzTelegraph(String inputs, EdelcrantzCodebook language, bool daytime) {
  if (inputs.isEmpty) return SegmentsText(displays: [], text: '');

  var displays = <List<String>>[];
  String text = '';

  Map<String, String> CODEBOOK;
  switch (language) {
    case EdelcrantzCodebook.YEAR_1795:
      CODEBOOK = _CODEBOOK_EDELCRANTZ_1795;
      break;
    case EdelcrantzCodebook.YEAR_1808:
      CODEBOOK = _CODEBOOK_EDELCRANTZ_1808;
      break;
    case EdelcrantzCodebook.MUSEUM:
      CODEBOOK = _CODEBOOK_EDELCRANTZ_MUSEUM;
      break;
  }

  inputs.split(' ').forEach((element) {
    if (CODEBOOK[element] != null) {
      if (daytime) {
        text += CODEBOOK[element]!;
      } else {
        text += CODEBOOK[_nightTime(element)] ?? '';
      }
    } else {
      text += UNKNOWN_ELEMENT;
    }
    displays.add(_buildShutters(element));
  });
  return SegmentsText(displays: displays, text: text);
}

List<String> _stringToSegment(String input) {
  List<String> result = [];
  int j = 0;
  for (int i = 0; i < input.length / 2; i++) {
    result.add(input[j] + input[j + 1]);
    j = j + 2;
  }
  return result;
}

String segmentToCode(List<String> segment) {
  int a = 0;
  int b = 0;
  int c = 0;

  if (segment.contains('a1')) a = a + 1;
  if (segment.contains('a2')) a = a + 2;
  if (segment.contains('a3')) a = a + 4;
  if (segment.contains('b1')) b = b + 1;
  if (segment.contains('b2')) b = b + 2;
  if (segment.contains('b3')) b = b + 4;
  if (segment.contains('c1')) c = c + 1;
  if (segment.contains('c2')) c = c + 2;
  if (segment.contains('c3')) c = c + 4;
  if (segment.contains('t0')) {
    return 'a' + a.toString() + b.toString() + c.toString();
  } else {
    return a.toString() + b.toString() + c.toString();
  }
}

List<String> _buildShutters(String segments) {
  List<String> resultElement = [];

  if (segments.length == 4 && segments.startsWith('a')) {
    segments = segments.substring(1);
    resultElement = ['t0'];
  }
  if (segments.length == 3) {
    switch (segments[0]) {
      case '1':
        resultElement.addAll(['a1']);
        break;
      case '2':
        resultElement.addAll(['a2']);
        break;
      case '3':
        resultElement.addAll(['a1', 'a2']);
        break;
      case '4':
        resultElement.addAll(['a3']);
        break;
      case '5':
        resultElement.addAll(['a3', 'a1']);
        break;
      case '6':
        resultElement.addAll(['a3', 'a2']);
        break;
      case '7':
        resultElement.addAll(['a3', 'a2', 'a1']);
        break;
    }
    switch (segments[1]) {
      case '1':
        resultElement.addAll(['b1']);
        break;
      case '2':
        resultElement.addAll(['b2']);
        break;
      case '3':
        resultElement.addAll(['b1', 'b2']);
        break;
      case '4':
        resultElement.addAll(['b3']);
        break;
      case '5':
        resultElement.addAll(['b3', 'b1']);
        break;
      case '6':
        resultElement.addAll(['b3', 'b2']);
        break;
      case '7':
        resultElement.addAll(['b3', 'b2', 'b1']);
        break;
    }
    switch (segments[2]) {
      case '1':
        resultElement.addAll(['c1']);
        break;
      case '2':
        resultElement.addAll(['c2']);
        break;
      case '3':
        resultElement.addAll(['c1', 'c2']);
        break;
      case '4':
        resultElement.addAll(['c3']);
        break;
      case '5':
        resultElement.addAll(['c3', 'c1']);
        break;
      case '6':
        resultElement.addAll(['c3', 'c2']);
        break;
      case '7':
        resultElement.addAll(['c3', 'c2', 'c1']);
        break;
    }
  }
  return resultElement;
}
