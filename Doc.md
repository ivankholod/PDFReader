После успешной авторизации, отправляется первый пакет данных.

| Тип данных | Имя |
|--|--|
| int32_t| screenWidth |
|int32_t|screenHeight|
| char| deviceModel[50] |
| char| deviceName[50] |
| char| systemName[10] |
| int8_t| numberProcessors |
| char| diskSpace[50] |
| double| totalMemory |

Это данные, которые **не меняются**.


Второй тип данных: статические данные, которые меняются реже, чем динамические.

| Тип данных | Имя |
|--|--|
| float | screenBrightness |
| char | systemsVersion[50] |
| char | carrierCountry[50] |
| char | systemDeviceTypeNotFormatted[50] |
| char | systemDeviceTypeFormatted[50] |
| char | currency[50] |
| int8_t | debuggerAttached|
| int8_t | multitaskingEnabled |
| char | country[50] |
| char | language[50] |
| char | timeZoneSS[50] |
| int8_t | charging |
| int8_t | fullyCharged |
| int8_t | stepCountingAvailable |
| int8_t | distanceAvailable |
| int8_t | floorCountingAvailable |
| char | usedDiskSpaceinRaw[50] |
| char | freeDiskSpaceinRaw[50] |

Третий тип данных: данные, которые **меняются часто.**

| Тип данных|   |
|--|--|
| int8_t| numberActiveProcessors|
| float| firstCoreUsage|
| float| secondCoreUsage|
| float| thirdCoreUsage|
| float| fourthCoreUsage|
| double| usedMemoryinRaw|
| double| wiredMemoryinRaw|
| double| activeMemoryinRaw|
| double| inactiveMemoryinRaw|
| double| freeMemoryinRaw|
| double| purgableMemoryinRaw| 
| int8_t| connectedToWiFi|
| int8_t| connectedToCellNetwork|


