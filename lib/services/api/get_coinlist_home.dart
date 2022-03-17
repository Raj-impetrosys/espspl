import 'dart:convert';
import 'package:espspl/globals/constants.dart';
import 'package:http/http.dart' as http;

Future<CoinListResponse> getCoinlistHome({required String type}) async {
  var response = await http.post(Uri.parse(AppConstants.baserl),
      body: json.encode({"user_id": "12", "currency": "USD", "type": type}));
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data);
    return CoinListResponse.fromJson(data);
  } else {
    throw Exception("Server Error");
  }
}

CoinListResponse CoinListResponseFromJson(String str) =>
    CoinListResponse.fromJson(json.decode(str));

String CoinListResponseToJson(CoinListResponse data) =>
    json.encode(data.toJson());

class CoinListResponse {
  CoinListResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  final bool code;
  final String message;
  final List<Detail> data;

  factory CoinListResponse.fromJson(Map<String, dynamic> json) =>
      CoinListResponse(
        code: json["code"],
        message: json["message"],
        data: List<Detail>.from(json["data"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    required this.id,
    required this.name,
    required this.symbol,
    required this.coinType,
    required this.percentChange24H,
    required this.marketCap,
    required this.the24High,
    required this.the24Low,
    required this.tradingVolume,
    required this.currencySymbol,
    required this.price,
    required this.logo,
    required this.barcodeLink,
    required this.address,
    required this.userBalance,
    required this.fiatBalance,
    required this.feePercent,
  });

  final String id;
  final String name;
  final String symbol;
  final String coinType;
  final String percentChange24H;
  final double? marketCap;
  final int the24High;
  final int the24Low;
  final double? tradingVolume;
  final String? currencySymbol;
  final String? price;
  final String logo;
  final String barcodeLink;
  final String address;
  final String userBalance;
  final int fiatBalance;
  final String? feePercent;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        coinType: json["coin_type"],
        percentChange24H: json["percent_change_24h"],
        marketCap:
            json["market_cap"] == null ? null : json["market_cap"].toDouble(),
        the24High: json["24_high"],
        the24Low: json["24_low"],
        tradingVolume: json["trading_volume"] == null
            ? null
            : json["trading_volume"].toDouble(),
        currencySymbol:
            json["currency_symbol"] == null ? null : json["currency_symbol"],
        price: json["price"],
        logo: json["logo"],
        barcodeLink: json["barcode_link"],
        address: json["address"] ?? "",
        userBalance: json["user_balance"],
        fiatBalance: json["fiat_balance"],
        feePercent: json["fee_percent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "coin_type": coinType,
        "percent_change_24h": percentChange24H,
        "market_cap": marketCap == null ? null : marketCap,
        "24_high": the24High,
        "24_low": the24Low,
        "trading_volume": tradingVolume == null ? null : tradingVolume,
        "currency_symbol": currencySymbol == null ? null : currencySymbol,
        "price": price,
        "logo": logo,
        "barcode_link": barcodeLink,
        "address": address,
        "user_balance": userBalance,
        "fiat_balance": fiatBalance,
        "fee_percent": feePercent,
      };
}

// enum Address {
//   THE_0_X78_FEB_FC2253233367637_AD5_D73_E89_BE_DDC2_FC074,
//   MS_HMN_SXVV1_IKBIZ_T_GIEUGV_B_MAUX_SB15_W_RE,
//   EMPTY
// }

// final addressValues = EnumValues({
//   "": Address.EMPTY,
//   "msHmnSXVV1ikbizTGieugvBMauxSB15wRE":
//       Address.MS_HMN_SXVV1_IKBIZ_T_GIEUGV_B_MAUX_SB15_W_RE,
//   "0x78FEBFc2253233367637AD5D73e89BeDdc2Fc074":
//       Address.THE_0_X78_FEB_FC2253233367637_AD5_D73_E89_BE_DDC2_FC074
// });

// enum CoinType { TRADABLE, EMPTY }

// final coinTypeValues =
//     EnumValues({" ": CoinType.EMPTY, "Tradable": CoinType.TRADABLE});

// class EnumValues<T> {
//   Map<String, T> map = {};
//   Map<T, String> reverseMap = {};

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap;
//     return reverseMap;
//   }
// }
