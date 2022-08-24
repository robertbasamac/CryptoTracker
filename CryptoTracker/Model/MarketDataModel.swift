//
//  MarketDataModel.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 24.08.2022.
//

import Foundation

// JSON Data:
/*
 URL: https://api.coingecko.com/api/v3/global

 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 12903,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 557,
     "total_market_cap": {
       "btc": 50185840.92594428,
       "eth": 650958246.8689535,
       "ltc": 19092227224.03217,
       "bch": 8058753774.507476,
       "bnb": 3626571106.793506,
       "eos": 631528765892.7108,
       "xrp": 3123692674970.244,
       "xlm": 9838952936555.62,
       "link": 149753776929.77914,
       "dot": 141920646014.2181,
       "yfi": 116344518.01509826,
       "usd": 1078414796897.143,
       "aed": 3961049901447.1084,
       "ars": 147621289827297.94,
       "aud": 1563548320599.6948,
       "bdt": 102419636064760.19,
       "bhd": 406549437452.6599,
       "bmd": 1078414796897.143,
       "brl": 5492582243556.522,
       "cad": 1401658848119.0938,
       "chf": 1040772728411.4462,
       "clp": 986997574564172.6,
       "cny": 7405905776211.458,
       "czk": 26763990587913.6,
       "dkk": 8077822899566.145,
       "eur": 1086014385970.877,
       "gbp": 915478183648.7482,
       "hkd": 8462062091700.627,
       "huf": 446275003325960,
       "idr": 16021891891550194,
       "ils": 3538533454511.5894,
       "inr": 86088610902452.97,
       "jpy": 147494105511581.88,
       "krw": 1446866707080369,
       "kwd": 331979211076.8163,
       "lkr": 392353235751801.5,
       "mmk": 2263410655700246.5,
       "mxn": 21504454860381.344,
       "myr": 4837229571482.133,
       "ngn": 458917141364357.25,
       "nok": 10465818253978.938,
       "nzd": 1745897478607.034,
       "php": 60439217006286.94,
       "pkr": 233462757175501.5,
       "pln": 5181855352882.148,
       "rub": 64516166302786.54,
       "sar": 4053553087480.554,
       "sek": 11493045014126.56,
       "sgd": 1504977456150.6172,
       "thb": 38959891367503.06,
       "try": 19578652990111.51,
       "twd": 32635527791099.742,
       "uah": 39808189701379.086,
       "vef": 107981673613.31102,
       "vnd": 25278042839269000,
       "zar": 18329805518712.734,
       "xdr": 797631171473.4221,
       "xag": 56699135375.1392,
       "xau": 617888542.0301872,
       "bits": 50185840925944.28,
       "sats": 5018584092594428
     },
     "total_volume": {
       "btc": 3080653.6638529697,
       "eth": 39959017.74748262,
       "ltc": 1171974777.42018,
       "bch": 494685929.008537,
       "bnb": 222616765.23170704,
       "eos": 38766340676.58233,
       "xrp": 191747614593.0836,
       "xlm": 603963306248.1495,
       "link": 9192623119.642664,
       "dot": 8711787031.032099,
       "yfi": 7141798.544759094,
       "usd": 66198402456.11924,
       "aed": 243148718173.39938,
       "ars": 9061720576531.512,
       "aud": 95978283388.22394,
       "bdt": 6287020826431.523,
       "bhd": 24956003345.12747,
       "bmd": 66198402456.11924,
       "brl": 337161703389.50616,
       "cad": 86040711608.3165,
       "chf": 63887747218.388275,
       "clp": 60586763879914.05,
       "cny": 454610909027.15436,
       "czk": 1642905332315.7214,
       "dkk": 495856485661.4611,
       "eur": 66664902598.2275,
       "gbp": 56196552027.4265,
       "hkd": 519442976456.57825,
       "huf": 27394553896403.535,
       "idr": 983502498850109.5,
       "ils": 217212581281.5066,
       "inr": 5284542207512.374,
       "jpy": 9053913377908.027,
       "krw": 88815792264023.97,
       "kwd": 20378516212.091736,
       "lkr": 24084570686520.04,
       "mmk": 138939274517210.22,
       "mxn": 1320049169895.3848,
       "myr": 296932934216.9227,
       "ngn": 28170590486572.33,
       "nok": 642443381528.9877,
       "nzd": 107171771259.52922,
       "php": 3710056300253.56,
       "pkr": 14331091897557.803,
       "pln": 318087759094.6166,
       "rub": 3960319493135.746,
       "sar": 248827018540.8779,
       "sek": 705499610614.1248,
       "sgd": 92382915754.02719,
       "thb": 2391549685532.2183,
       "try": 1201833982542.917,
       "twd": 2003329154328.3057,
       "uah": 2443622408078.6396,
       "vef": 6628446037.931226,
       "vnd": 1551690553571433.2,
       "zar": 1125173584562.6318,
       "xdr": 48962523003.82669,
       "xag": 3480471700.9418435,
       "xau": 37929036.67125809,
       "bits": 3080653663852.9697,
       "sats": 308065366385296.94
     },
     "market_cap_percentage": {
       "btc": 38.119552541183296,
       "eth": 18.464000760085543,
       "usdt": 6.27348920070495,
       "usdc": 4.859770463521394,
       "bnb": 4.507601474643379,
       "busd": 1.7677768747365055,
       "xrp": 1.58603035995851,
       "ada": 1.4512760001448977,
       "sol": 1.1494284845533511,
       "doge": 0.8390976591446626
     },
     "market_cap_change_percentage_24h_usd": 0.86730625229106,
     "updated_at": 1661344019
   }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
//        if let item = totalMarketCap.first(where: { (key, value) in
//            return key == "usd"
//        }) {
//            return "\(item.value)"
//        }
        
        // shorter version of the above code
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        
        return ""
    }
}
