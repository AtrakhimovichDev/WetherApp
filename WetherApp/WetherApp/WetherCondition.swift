//
//  WetherCondition.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 15.08.21.
//

import Foundation

enum WetherCondition: Int {
    case clear = 1000, partlyCloudy = 1003, cloudy = 1006, overcast = 1009,
         mist = 1030, rainPossible = 1063, snowPossible = 1066,
         sleetPossible = 1069, freezingDrizzlePossible = 1072, thunderyOutbreaks = 1087,
         blowingSnow = 1114, blizzard = 1117,fog = 1135, freezingFog = 1147,
         patchyLightDrizzle = 1150, lightDrizzle = 1153, freezingDrizzle = 1168,
         heavyFreezingDrizzle = 1171, patchyLightRain = 1180, lightRain = 1183,
         moderateRainAtTimes = 1186, moderateRain = 1189,
         heavyRainAtTimes = 1192, heavyRain = 1195, lightFreezingRain = 1198,
         moderateOrHeavyFreezingRain = 1201, lightSleet = 1204, moderateOrHeavySleet = 1207,
         patchyLightSnow = 1210, lightSnow = 1213, patchyModerateSnow = 1216,
         moderateSnow = 1219, patchyHeavySnow = 1222, heavySnow = 1225, icePellets = 1237,
         lightRainShower = 1240, moderateOrHeavyRainShower = 1243, torrentialRainShower = 1246,
         lightSleetShowers = 1249, moderateOrHeavySleetShowers = 1253, lightSnowShowers = 1255,
         moderateOrHeavySnowShowers = 1258, lightShowersOfIcePellets = 1261,
         moderateOrHeavyShowersOfIcePellets = 1264, patchyLightRainWithThunder = 1273,
         moderateOrHeavyRainWithThunder = 1276, patchyLightSnowWithThunder = 1279,
         moderateOrHeavySnowWithThunder = 1282
    
    func getIconCode() -> Int {
        switch self {
        case .clear:
            return 113
        case .partlyCloudy:
            return 116
        case .cloudy:
            return 119
        case .overcast:
            return 122
        case .mist:
            return 143
        case .rainPossible:
            return 176
        case .snowPossible:
            return 179
        case .sleetPossible:
            return 182
        case .freezingDrizzlePossible:
            return 185
        case .thunderyOutbreaks:
            return 200
        case .blowingSnow:
            return 227
        case .blizzard:
            return 230
        case .fog:
            return 248
        case .freezingFog:
            return 260
        case .patchyLightDrizzle:
            return 263
        case .lightDrizzle:
            return 266
        case .freezingDrizzle:
            return 281
        case .heavyFreezingDrizzle:
            return 284
        case .patchyLightRain:
            return 293
        case .lightRain:
            return 296
        case .moderateRainAtTimes:
            return 299
        case .moderateRain:
            return 302
        case .heavyRainAtTimes:
            return 305
        case .heavyRain:
            return 308
        case .lightFreezingRain:
            return 311
        case .moderateOrHeavyFreezingRain:
            return 314
        case .lightSleet:
            return 317
        case .moderateOrHeavySleet:
            return 320
        case .patchyLightSnow:
            return 323
        case .lightSnow:
            return 326
        case .patchyModerateSnow:
            return 329
        case .moderateSnow:
            return 332
        case .patchyHeavySnow:
            return 335
        case .heavySnow:
            return 338
        case .icePellets:
            return 350
        case .lightRainShower:
            return 353
        case .moderateOrHeavyRainShower:
            return 356
        case .torrentialRainShower:
            return 359
        case .lightSleetShowers:
            return 362
        case .moderateOrHeavySleetShowers:
            return 365
        case .lightSnowShowers:
            return 368
        case .moderateOrHeavySnowShowers:
            return 371
        case .lightShowersOfIcePellets:
            return 374
        case .moderateOrHeavyShowersOfIcePellets:
            return 377
        case .patchyLightRainWithThunder:
            return 386
        case .moderateOrHeavyRainWithThunder:
            return 389
        case .patchyLightSnowWithThunder:
            return 392
        case .moderateOrHeavySnowWithThunder:
            return 395
        }
    }
}
