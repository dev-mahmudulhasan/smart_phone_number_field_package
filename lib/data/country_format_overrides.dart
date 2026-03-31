import '../models/phone_format_spec.dart';

/// ISO 3166-1 alpha-2 → detailed phone format (national number only, no country code).
///
/// Pattern legend:
///   `#`  = one digit
///   ` `  = space separator
///   `-`  = dash separator
///   `(`  = open parenthesis
///   `)`  = close parenthesis
///
/// Countries not listed fall back to [PhoneFormatSpec.generic].
const Map<String, PhoneFormatSpec> kCountryFormatOverrides = {
  // ─────────────────────────────────────────────
  // South Asia
  // ─────────────────────────────────────────────

  /// Bangladesh: 01758 691303 → national 10 digits → #### ######
  'BD': PhoneFormatSpec(
    pattern: r'#### ######',
    example: r'1758 691303',
    minLength: 10,
    maxLength: 10,
  ),

  /// India: 98765 43210 → 10 digits → ##### #####
  'IN': PhoneFormatSpec(
    pattern: r'##### #####',
    example: r'98765 43210',
    minLength: 10,
    maxLength: 10,
  ),

  /// Pakistan: 0300 1234567 → national 10 digits → #### #######
  'PK': PhoneFormatSpec(
    pattern: r'### #######',
    example: r'300 1234567',
    minLength: 10,
    maxLength: 11,
  ),

  /// Nepal: 9841 234567 → 10 digits → #### ######
  'NP': PhoneFormatSpec(
    pattern: r'#### ######',
    example: r'9841 234567',
    minLength: 10,
    maxLength: 10,
  ),

  /// Sri Lanka: 071 234 5678 → 9 digits → ### ### ####
  'LK': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'071 234 5678',
    minLength: 9,
    maxLength: 10,
  ),

  /// Maldives: 791 1234 → 7 digits → ### ####
  'MV': PhoneFormatSpec(
    pattern: r'### ####',
    example: r'791 1234',
    minLength: 7,
    maxLength: 7,
  ),

  /// Afghanistan: 070 123 4567 → 9 digits → ### ### ####
  'AF': PhoneFormatSpec(
    pattern: r'## ### ####',
    example: r'70 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Bhutan: 17 123 456 → 8 digits → ## ### ###
  'BT': PhoneFormatSpec(
    pattern: r'## ### ###',
    example: r'17 123 456',
    minLength: 8,
    maxLength: 8,
  ),

  /// Myanmar: 09 1234 5678 → 9-10 digits → ## #### ####
  'MM': PhoneFormatSpec(
    pattern: r'## #### ####',
    example: r'09 1234 5678',
    minLength: 8,
    maxLength: 10,
  ),

  // ─────────────────────────────────────────────
  // Middle East
  // ─────────────────────────────────────────────

  /// Saudi Arabia: 050 1234 5678 → 9 digits → ### #### ####
  'SA': PhoneFormatSpec(
    pattern: r'## #### ####',
    example: r'50 1234 5678',
    minLength: 9,
    maxLength: 9,
  ),

  /// UAE: 050 1234 5678 → 9 digits
  'AE': PhoneFormatSpec(
    pattern: r'## #### ####',
    example: r'50 1234 5678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Kuwait: 5123 4567 → 8 digits → #### ####
  'KW': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'5123 4567',
    minLength: 8,
    maxLength: 8,
  ),

  /// Qatar: 5123 4567 → 8 digits
  'QA': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'5123 4567',
    minLength: 8,
    maxLength: 8,
  ),

  /// Oman: 9123 4567 → 8 digits
  'OM': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'9123 4567',
    minLength: 8,
    maxLength: 8,
  ),

  /// Bahrain: 3123 4567 → 8 digits
  'BH': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'3123 4567',
    minLength: 8,
    maxLength: 8,
  ),

  /// Iraq: 0770 123 4567 → 10 digits → ### ### ####
  'IQ': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'770 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  /// Jordan: 07 9123 4567 → 9 digits → ## #### ####
  'JO': PhoneFormatSpec(
    pattern: r'# #### ####',
    example: r'7 9123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Lebanon: 03 123 456 → 7-8 digits → ## ### ###
  'LB': PhoneFormatSpec(
    pattern: r'## ### ###',
    example: r'03 123 456',
    minLength: 7,
    maxLength: 8,
  ),

  /// Turkey: 0505 123 4567 → 10 digits → ### ### ####
  'TR': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'505 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  /// Iran: 0912 345 6789 → 10 digits → ### ### ####
  'IR': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'912 345 6789',
    minLength: 10,
    maxLength: 10,
  ),

  /// Syria: 011 2345 678 → 9 digits → ## #### ###
  'SY': PhoneFormatSpec(
    pattern: r'## #### ###',
    example: r'11 2345 678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Yemen: 0712 345 678 → 9 digits → ### ### ###
  'YE': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'712 345 678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Palestine: 059 123 4567 → 9 digits → ## ### ####
  'PS': PhoneFormatSpec(
    pattern: r'## ### ####',
    example: r'59 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Cyprus: 99 123456 → 8 digits → ## ######
  'CY': PhoneFormatSpec(
    pattern: r'## ######',
    example: r'99 123456',
    minLength: 8,
    maxLength: 8,
  ),

  // ─────────────────────────────────────────────
  // Europe
  // ─────────────────────────────────────────────

  /// United Kingdom: 07911 123456 → 10 digits → ##### ######
  'GB': PhoneFormatSpec(
    pattern: r'##### ######',
    example: r'07911 123456',
    minLength: 10,
    maxLength: 10,
  ),

  /// Germany: 0151 2345 6789 → 10-11 digits → ### #### ####
  'DE': PhoneFormatSpec(
    pattern: r'### #### ####',
    example: r'151 2345 6789',
    minLength: 10,
    maxLength: 11,
  ),

  /// France: 06 12 34 56 78 → 9-10 digits → # ## ## ## ##
  'FR': PhoneFormatSpec(
    pattern: r'# ## ## ## ##',
    example: r'6 12 34 56 78',
    minLength: 9,
    maxLength: 10,
  ),

  /// Italy: 312 345 6789 → 10 digits → ### ### ####
  'IT': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'312 345 6789',
    minLength: 10,
    maxLength: 10,
  ),

  /// Spain: 612 345 678 → 9 digits → ### ### ###
  'ES': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'612 345 678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Portugal: 912 345 678 → 9 digits → ### ### ###
  'PT': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'912 345 678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Netherlands: 06 1234 5678 → 9-10 digits → ## #### ####
  'NL': PhoneFormatSpec(
    pattern: r'## #### ####',
    example: r'06 1234 5678',
    minLength: 9,
    maxLength: 10,
  ),

  /// Belgium: 0470 12 34 56 → 9 digits → ### ## ## ##
  'BE': PhoneFormatSpec(
    pattern: r'### ## ## ##',
    example: r'470 12 34 56',
    minLength: 9,
    maxLength: 10,
  ),

  /// Switzerland: 078 123 4567 → 9 digits → ### ### ####
  'CH': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'078 123 4567',
    minLength: 9,
    maxLength: 10,
  ),

  /// Sweden: 070 123 45 67 → 9 digits → ### ### ## ##
  'SE': PhoneFormatSpec(
    pattern: r'### ### ## ##',
    example: r'070 123 45 67',
    minLength: 9,
    maxLength: 10,
  ),

  /// Norway: 412 34 567 → 8 digits → ### ## ###
  'NO': PhoneFormatSpec(
    pattern: r'### ## ###',
    example: r'412 34 567',
    minLength: 8,
    maxLength: 8,
  ),

  /// Denmark: 12 34 56 78 → 8 digits → ## ## ## ##
  'DK': PhoneFormatSpec(
    pattern: r'## ## ## ##',
    example: r'12 34 56 78',
    minLength: 8,
    maxLength: 8,
  ),

  /// Finland: 040 123 4567 → 9-10 digits → ### ### ####
  'FI': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'040 123 4567',
    minLength: 9,
    maxLength: 10,
  ),

  /// Ireland: 085 123 4567 → 9-10 digits → ### ### ####
  'IE': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'085 123 4567',
    minLength: 9,
    maxLength: 10,
  ),

  /// Poland: 512 345 678 → 9 digits → ### ### ###
  'PL': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'512 345 678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Russia: 912 345 67 89 → 10 digits → ### ### ## ##
  'RU': PhoneFormatSpec(
    pattern: r'### ### ## ##',
    example: r'912 345 67 89',
    minLength: 10,
    maxLength: 10,
  ),

  /// Ukraine: 050 123 45 67 → 9 digits → ### ### ## ##
  'UA': PhoneFormatSpec(
    pattern: r'### ### ## ##',
    example: r'050 123 45 67',
    minLength: 9,
    maxLength: 9,
  ),

  /// Romania: 071 234 5678 → 9-10 digits → ### ### ####
  'RO': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'071 234 5678',
    minLength: 9,
    maxLength: 10,
  ),

  /// Greece: 690 123 4567 → 10 digits → ### ### ####
  'GR': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'690 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  /// Hungary: 20 123 4567 → 9 digits → ## ### ####
  'HU': PhoneFormatSpec(
    pattern: r'## ### ####',
    example: r'20 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Czech Republic: 721 123 456 → 9 digits → ### ### ###
  'CZ': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'721 123 456',
    minLength: 9,
    maxLength: 9,
  ),

  /// Austria: 0664 123 4567 → 10-11 digits → #### ### ####
  'AT': PhoneFormatSpec(
    pattern: r'#### ### ####',
    example: r'0664 123 4567',
    minLength: 10,
    maxLength: 11,
  ),

  /// Bulgaria: 087 123 4567 → 9 digits → ### ### ###
  'BG': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'087 123 456',
    minLength: 9,
    maxLength: 9,
  ),

  /// Croatia: 091 123 4567 → 9 digits → ### ### ####
  'HR': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'091 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Slovakia: 0912 123 456 → 9 digits → #### ### ###
  'SK': PhoneFormatSpec(
    pattern: r'#### ### ###',
    example: r'0912 123 456',
    minLength: 9,
    maxLength: 9,
  ),

  /// Slovenia: 031 123 456 → 8 digits → ### ### ###
  'SI': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'031 123 456',
    minLength: 8,
    maxLength: 8,
  ),

  /// Lithuania: 612 34 567 → 8 digits → ### ## ###
  'LT': PhoneFormatSpec(
    pattern: r'### ## ###',
    example: r'612 34 567',
    minLength: 8,
    maxLength: 8,
  ),

  /// Latvia: 21 123 456 → 8 digits → ## ### ###
  'LV': PhoneFormatSpec(
    pattern: r'## ### ###',
    example: r'21 123 456',
    minLength: 8,
    maxLength: 8,
  ),

  /// Estonia: 5123 4567 → 7-8 digits → #### ####
  'EE': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'5123 4567',
    minLength: 7,
    maxLength: 8,
  ),

  /// Iceland: 611 1234 → 7 digits → ### ####
  'IS': PhoneFormatSpec(
    pattern: r'### ####',
    example: r'611 1234',
    minLength: 7,
    maxLength: 7,
  ),

  /// Luxembourg: 621 123 → 6-9 digits → ### ###
  'LU': PhoneFormatSpec(
    pattern: r'### ###',
    example: r'621 123',
    minLength: 6,
    maxLength: 9,
  ),

  /// Malta: 7912 3456 → 8 digits → #### ####
  'MT': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'7912 3456',
    minLength: 8,
    maxLength: 8,
  ),

  /// Serbia: 060 123 4567 → 9 digits → ### ### ####
  'RS': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'060 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Bosnia: 061 123 456 → 8-9 digits → ### ### ###
  'BA': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'061 123 456',
    minLength: 8,
    maxLength: 9,
  ),

  /// North Macedonia: 070 123 456 → 8 digits → ### ### ###
  'MK': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'070 123 456',
    minLength: 8,
    maxLength: 8,
  ),

  /// Albania: 067 123 4567 → 9 digits → ### ### ####
  'AL': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'067 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Moldova: 0621 12 345 → 8 digits → #### ## ###
  'MD': PhoneFormatSpec(
    pattern: r'#### ## ###',
    example: r'0621 12 345',
    minLength: 8,
    maxLength: 8,
  ),

  /// Belarus: 029 123 4567 → 9 digits → ### ### ####
  'BY': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'029 123 4567',
    minLength: 9,
    maxLength: 10,
  ),

  // ─────────────────────────────────────────────
  // North America
  // ─────────────────────────────────────────────

  /// United States: (212) 555 1234 → 10 digits → (###) ### ####
  'US': PhoneFormatSpec(
    pattern: r'(###) ### ####',
    example: r'(212) 555 1234',
    minLength: 10,
    maxLength: 10,
  ),

  /// Canada: (416) 555 1234 → 10 digits
  'CA': PhoneFormatSpec(
    pattern: r'(###) ### ####',
    example: r'(416) 555 1234',
    minLength: 10,
    maxLength: 10,
  ),

  /// Mexico: 55 1234 5678 → 10 digits → ## #### ####
  'MX': PhoneFormatSpec(
    pattern: r'## #### ####',
    example: r'55 1234 5678',
    minLength: 10,
    maxLength: 10,
  ),

  // ─────────────────────────────────────────────
  // Caribbean
  // ─────────────────────────────────────────────

  /// Cuba: 5123 4567 → 8 digits → #### ####
  'CU': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'5123 4567',
    minLength: 8,
    maxLength: 8,
  ),

  /// Jamaica: (876) 123 4567 → 10 digits
  'JM': PhoneFormatSpec(
    pattern: r'(###) ### ####',
    example: r'(876) 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  /// Dominican Republic
  'DO': PhoneFormatSpec(
    pattern: r'(###) ### ####',
    example: r'(809) 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  /// Puerto Rico
  'PR': PhoneFormatSpec(
    pattern: r'(###) ### ####',
    example: r'(787) 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  /// Trinidad & Tobago
  'TT': PhoneFormatSpec(
    pattern: r'(###) ### ####',
    example: r'(868) 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  /// Bahamas
  'BS': PhoneFormatSpec(
    pattern: r'(###) ### ####',
    example: r'(242) 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  /// Barbados
  'BB': PhoneFormatSpec(
    pattern: r'(###) ### ####',
    example: r'(246) 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  // ─────────────────────────────────────────────
  // East Asia
  // ─────────────────────────────────────────────

  /// China: 138 1234 5678 → 11 digits → ### #### ####
  'CN': PhoneFormatSpec(
    pattern: r'### #### ####',
    example: r'138 1234 5678',
    minLength: 11,
    maxLength: 11,
  ),

  /// Japan: 090 1234 5678 → 10-11 digits → ### #### ####
  'JP': PhoneFormatSpec(
    pattern: r'### #### ####',
    example: r'090 1234 5678',
    minLength: 10,
    maxLength: 11,
  ),

  /// South Korea: 010 1234 5678 → 10-11 digits → ### #### ####
  'KR': PhoneFormatSpec(
    pattern: r'### #### ####',
    example: r'010 1234 5678',
    minLength: 10,
    maxLength: 11,
  ),

  /// North Korea: 191 123 4567 → 8 digits → ### ### ####
  'KP': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'191 123 4567',
    minLength: 8,
    maxLength: 8,
  ),

  /// Mongolia: 9912 3456 → 8 digits → #### ####
  'MN': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'9912 3456',
    minLength: 8,
    maxLength: 8,
  ),

  // ─────────────────────────────────────────────
  // Southeast Asia
  // ─────────────────────────────────────────────

  /// Malaysia: 012 3456 7890 → 9-10 digits → ### #### ####
  'MY': PhoneFormatSpec(
    pattern: r'### #### ####',
    example: r'012 3456 7890',
    minLength: 9,
    maxLength: 10,
  ),

  /// Singapore: 9123 4567 → 8 digits → #### ####
  'SG': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'9123 4567',
    minLength: 8,
    maxLength: 8,
  ),

  /// Indonesia: 0812 3456 7890 → 10-12 digits → #### #### ####
  'ID': PhoneFormatSpec(
    pattern: r'#### #### ####',
    example: r'0812 3456 7890',
    minLength: 10,
    maxLength: 12,
  ),

  /// Philippines: 0912 345 6789 → 10 digits → #### ### ####
  'PH': PhoneFormatSpec(
    pattern: r'#### ### ####',
    example: r'0912 345 6789',
    minLength: 10,
    maxLength: 10,
  ),

  /// Vietnam: 091 2345 6789 → 9-10 digits → ### #### ####
  'VN': PhoneFormatSpec(
    pattern: r'### #### ####',
    example: r'091 2345 6789',
    minLength: 9,
    maxLength: 10,
  ),

  /// Thailand: 081 234 5678 → 9 digits → ### ### ####
  'TH': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'081 234 5678',
    minLength: 9,
    maxLength: 10,
  ),

  /// Cambodia: 012 345 678 → 8-9 digits → ### ### ###
  'KH': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'012 345 678',
    minLength: 8,
    maxLength: 9,
  ),

  /// Laos: 020 123 456 → 8 digits → ### ### ###
  'LA': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'020 123 456',
    minLength: 8,
    maxLength: 8,
  ),

  /// Brunei: 712 3456 → 7 digits → ### ####
  'BN': PhoneFormatSpec(
    pattern: r'### ####',
    example: r'712 3456',
    minLength: 7,
    maxLength: 7,
  ),

  /// Timor-Leste: 7721 2345 → 7-8 digits → #### ####
  'TL': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'7721 2345',
    minLength: 7,
    maxLength: 8,
  ),

  // ─────────────────────────────────────────────
  // Central Asia
  // ─────────────────────────────────────────────

  /// Kazakhstan: 701 234 5678 → 10 digits → ### ### ####
  'KZ': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'701 234 5678',
    minLength: 10,
    maxLength: 10,
  ),

  /// Uzbekistan: 90 123 4567 → 9 digits → ## ### ####
  'UZ': PhoneFormatSpec(
    pattern: r'## ### ####',
    example: r'90 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Georgia: 555 12 34 56 → 9 digits → ### ## ## ##
  'GE': PhoneFormatSpec(
    pattern: r'### ## ## ##',
    example: r'555 12 34 56',
    minLength: 9,
    maxLength: 9,
  ),

  /// Azerbaijan: 050 123 4567 → 9 digits → ### ### ####
  'AZ': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'050 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Armenia: 077 12 34 56 → 8 digits → ### ## ## ##
  'AM': PhoneFormatSpec(
    pattern: r'## ## ## ##',
    example: r'77 12 34 56',
    minLength: 8,
    maxLength: 8,
  ),

  // ─────────────────────────────────────────────
  // Africa
  // ─────────────────────────────────────────────

  /// Egypt: 0100 123 4567 → 10 digits → #### ### ####
  'EG': PhoneFormatSpec(
    pattern: r'#### ### ####',
    example: r'0100 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  /// Nigeria: 0802 123 4567 → 10 digits → #### ### ####
  'NG': PhoneFormatSpec(
    pattern: r'#### ### ####',
    example: r'0802 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  /// South Africa: 071 234 5678 → 9 digits → ### ### ####
  'ZA': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'071 234 5678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Morocco: 0612 345 678 → 9 digits → #### ### ###
  'MA': PhoneFormatSpec(
    pattern: r'#### ### ###',
    example: r'0612 345 678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Kenya: 0712 345 678 → 9 digits → #### ### ###
  'KE': PhoneFormatSpec(
    pattern: r'#### ### ###',
    example: r'0712 345 678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Algeria: 055 123 4567 → 9 digits → ### ### ####
  'DZ': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'055 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Tunisia: 20 123 456 → 8 digits → ## ### ###
  'TN': PhoneFormatSpec(
    pattern: r'## ### ###',
    example: r'20 123 456',
    minLength: 8,
    maxLength: 8,
  ),

  /// Libya: 091 123 456 → 9 digits → ### ### ###
  'LY': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'091 123 456',
    minLength: 9,
    maxLength: 9,
  ),

  /// Sudan: 091 123 4567 → 9 digits → ### ### ####
  'SD': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'091 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Ethiopia: 091 123 4567 → 9 digits → ### ### ####
  'ET': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'091 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Somalia: 061 234 567 → 8 digits → ### ### ###
  'SO': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'061 234 567',
    minLength: 8,
    maxLength: 8,
  ),

  /// Ghana: 020 123 4567 → 9 digits → ### ### ####
  'GH': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'020 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Ivory Coast: 07 123 456 → 8 digits → ## ### ###
  'CI': PhoneFormatSpec(
    pattern: r'## ### ###',
    example: r'07 123 456',
    minLength: 8,
    maxLength: 8,
  ),

  /// Senegal: 77 123 4567 → 9 digits → ## ### ####
  'SN': PhoneFormatSpec(
    pattern: r'## ### ####',
    example: r'77 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Cameroon: 67 123 4567 → 9 digits → ## ### ####
  'CM': PhoneFormatSpec(
    pattern: r'## ### ####',
    example: r'67 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Uganda: 0712 345 678 → 9 digits → #### ### ###
  'UG': PhoneFormatSpec(
    pattern: r'#### ### ###',
    example: r'0712 345 678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Tanzania: 071 123 4567 → 9 digits → ### ### ####
  'TZ': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'071 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Rwanda: 0788 123 456 → 9 digits → #### ### ###
  'RW': PhoneFormatSpec(
    pattern: r'#### ### ###',
    example: r'0788 123 456',
    minLength: 9,
    maxLength: 9,
  ),

  /// Zimbabwe: 071 123 4567 → 9 digits → ### ### ####
  'ZW': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'071 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Zambia: 096 123 4567 → 9 digits → ### ### ####
  'ZM': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'096 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Malawi: 088 123 4567 → 9 digits → ### ### ####
  'MW': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'088 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Botswana: 71 234 5678 → 8 digits → ## ### ####
  'BW': PhoneFormatSpec(
    pattern: r'## ### ####',
    example: r'71 234 5678',
    minLength: 8,
    maxLength: 8,
  ),

  /// Namibia: 081 123 4567 → 9 digits → ### ### ####
  'NA': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'081 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Mauritius: 5123 4567 → 7-8 digits → #### ####
  'MU': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'5123 4567',
    minLength: 7,
    maxLength: 8,
  ),

  /// Angola: 923 123 456 → 9 digits → ### ### ###
  'AO': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'923 123 456',
    minLength: 9,
    maxLength: 9,
  ),

  /// Mozambique: 84 123 4567 → 9 digits → ## ### ####
  'MZ': PhoneFormatSpec(
    pattern: r'## ### ####',
    example: r'84 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  // ─────────────────────────────────────────────
  // Oceania
  // ─────────────────────────────────────────────

  /// Australia: 0412 345 678 → 9-10 digits → #### ### ###
  'AU': PhoneFormatSpec(
    pattern: r'#### ### ###',
    example: r'0412 345 678',
    minLength: 9,
    maxLength: 10,
  ),

  /// New Zealand: 021 123 4567 → 9-10 digits → ### ### ####
  'NZ': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'021 123 4567',
    minLength: 9,
    maxLength: 10,
  ),

  /// Fiji: 7012 3456 → 7 digits → #### ####
  'FJ': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'7012 3456',
    minLength: 7,
    maxLength: 7,
  ),

  /// Papua New Guinea: 7123 4567 → 7-8 digits → #### ####
  'PG': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'7123 4567',
    minLength: 7,
    maxLength: 8,
  ),

  /// Solomon Islands: 7123 456 → 7 digits → #### ###
  'SB': PhoneFormatSpec(
    pattern: r'#### ###',
    example: r'7123 456',
    minLength: 7,
    maxLength: 7,
  ),

  // ─────────────────────────────────────────────
  // South America
  // ─────────────────────────────────────────────

  /// Brazil: (11) 91234 5678 → 10-11 digits → (##) ##### ####
  'BR': PhoneFormatSpec(
    pattern: r'(##) ##### ####',
    example: r'(11) 91234 5678',
    minLength: 10,
    maxLength: 11,
  ),

  /// Argentina: 911 2345 6789 → 10 digits → ### #### ####
  'AR': PhoneFormatSpec(
    pattern: r'### #### ####',
    example: r'911 2345 6789',
    minLength: 10,
    maxLength: 10,
  ),

  /// Colombia: 301 234 5678 → 10 digits → ### ### ####
  'CO': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'301 234 5678',
    minLength: 10,
    maxLength: 10,
  ),

  /// Chile: 9 1234 5678 → 9 digits → # #### ####
  'CL': PhoneFormatSpec(
    pattern: r'# #### ####',
    example: r'9 1234 5678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Peru: 912 345 678 → 9 digits → ### ### ###
  'PE': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'912 345 678',
    minLength: 9,
    maxLength: 9,
  ),

  /// Venezuela: 0412 123 4567 → 10 digits → #### ### ####
  'VE': PhoneFormatSpec(
    pattern: r'#### ### ####',
    example: r'0412 123 4567',
    minLength: 10,
    maxLength: 10,
  ),

  /// Ecuador: 099 123 4567 → 9 digits → ### ### ####
  'EC': PhoneFormatSpec(
    pattern: r'### ### ####',
    example: r'099 123 4567',
    minLength: 9,
    maxLength: 9,
  ),

  /// Bolivia: 7123 4567 → 8 digits → #### ####
  'BO': PhoneFormatSpec(
    pattern: r'#### ####',
    example: r'7123 4567',
    minLength: 8,
    maxLength: 8,
  ),

  /// Paraguay: 0961 123 456 → 9 digits → #### ### ###
  'PY': PhoneFormatSpec(
    pattern: r'#### ### ###',
    example: r'0961 123 456',
    minLength: 9,
    maxLength: 9,
  ),

  /// Uruguay: 094 123 456 → 8 digits → ### ### ###
  'UY': PhoneFormatSpec(
    pattern: r'### ### ###',
    example: r'094 123 456',
    minLength: 8,
    maxLength: 8,
  ),

  /// Guyana: 612 3456 → 7 digits → ### ####
  'GY': PhoneFormatSpec(
    pattern: r'### ####',
    example: r'612 3456',
    minLength: 7,
    maxLength: 7,
  ),

  /// Suriname: 712 3456 → 7 digits → ### ####
  'SR': PhoneFormatSpec(
    pattern: r'### ####',
    example: r'712 3456',
    minLength: 6,
    maxLength: 7,
  ),
};