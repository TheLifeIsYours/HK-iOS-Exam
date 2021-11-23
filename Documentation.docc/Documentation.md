# PG5601 iOS programmering
## Folio

Folio er en Portfolio-applikasjon skrevet i Swift med det nye SwiftUI rammeverket.
Man kan legge til Folio’s man er interessert i, redigere de, og slette de om så.
Vil man se utover en bredere horisont, kan man endre Folio seed nøkkelen i under innstillings menyen.

Appliokasjonen er bygget med XCode 13 i Swift 5, for iPhone 13 Pro Max simulatoren.

## Forutsetninger

Fordi jeg brukte SwiftUI og ikke Story Boards ble det at jeg laget min egen versjon av animasjoner for bursdag konfetti. Denne kjører da ikke hele tiden man er på skjermen, men skyter ut en mengde med konfetti når man først åpner den detaljerte Folio siden. Trykker man på Party ikonet som da vises på profil bildet skyter man ut konfetti på nytt. Så man kan hygge seg med mere enn bare en salve konfetti!

## Eksterne Biblioteker

### Pods:
- Alamofire
- ObjectMapper
- SwiftyJSON

### Packages:
- CachedAsyncImage

## Inspirert Kode

Date Extension: By Leo Dabus
https://stackoverflow.com/a/43664156/2359829

Navigation Button Component: By arsenius
https://stackoverflow.com/a/58908409/2359829

Custom NavigationView Bar Styles:
https://medium.com/swlh/custom-navigationview-bar-in-swiftui-4b782eb68e94
https://gist.github.com/apatronl/29b6c82085afd1c6177715d88411aaf4

## Kjente Bugs
Det er ingen, så gjerne si ifra om du finner noen for meg. Takk.
