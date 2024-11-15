import Foundation
import MapKit

// Define a struct for county coordinates with unique ID and CLLocationCoordinate2D
struct CountyAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

class LocationViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 31.9686, longitude: -99.9018), // Center of Texas
        span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
    )
    @Published var countyCoordinate: CountyAnnotation?

    // Dictionary to store coordinates for Texas counties
    private let countyCoordinates: [String: CLLocationCoordinate2D] = [
        "Anderson": CLLocationCoordinate2D(latitude: 31.8154, longitude: -95.6530),
        "Andrews": CLLocationCoordinate2D(latitude: 32.3087, longitude: -102.5502),
        "Angelina": CLLocationCoordinate2D(latitude: 31.2504, longitude: -94.6110),
        "Aransas": CLLocationCoordinate2D(latitude: 28.1087, longitude: -96.9716),
        "Archer": CLLocationCoordinate2D(latitude: 33.6133, longitude: -98.6896),
        "Armstrong": CLLocationCoordinate2D(latitude: 34.9657, longitude: -101.3566),
        "Atascosa": CLLocationCoordinate2D(latitude: 28.8942, longitude: -98.5272),
        "Austin": CLLocationCoordinate2D(latitude: 29.8888, longitude: -96.2713),
        "Bailey": CLLocationCoordinate2D(latitude: 34.0659, longitude: -102.8298),
        "Bandera": CLLocationCoordinate2D(latitude: 29.7469, longitude: -99.2456),
        "Bastrop": CLLocationCoordinate2D(latitude: 30.1005, longitude: -97.3116),
        "Baylor": CLLocationCoordinate2D(latitude: 33.6179, longitude: -99.2122),
        "Bee": CLLocationCoordinate2D(latitude: 28.4170, longitude: -97.7416),
        "Bell": CLLocationCoordinate2D(latitude: 31.0365, longitude: -97.4789),
        "Bexar": CLLocationCoordinate2D(latitude: 29.4492, longitude: -98.5167),
        "Blanco": CLLocationCoordinate2D(latitude: 30.2640, longitude: -98.3999),
        "Borden": CLLocationCoordinate2D(latitude: 32.7436, longitude: -101.4316),
        "Bosque": CLLocationCoordinate2D(latitude: 31.9004, longitude: -97.6304),
        "Bowie": CLLocationCoordinate2D(latitude: 33.4451, longitude: -94.4173),
        "Brazoria": CLLocationCoordinate2D(latitude: 29.1688, longitude: -95.4345),
        "Brazos": CLLocationCoordinate2D(latitude: 30.6624, longitude: -96.3020),
        "Brewster": CLLocationCoordinate2D(latitude: 29.8170, longitude: -103.2522),
        "Briscoe": CLLocationCoordinate2D(latitude: 34.5304, longitude: -101.2037),
        "Brooks": CLLocationCoordinate2D(latitude: 27.0336, longitude: -98.2146),
        "Brown": CLLocationCoordinate2D(latitude: 31.7724, longitude: -98.9999),
        "Burleson": CLLocationCoordinate2D(latitude: 30.4910, longitude: -96.6213),
        "Burnet": CLLocationCoordinate2D(latitude: 30.7887, longitude: -98.2413),
        "Caldwell": CLLocationCoordinate2D(latitude: 29.8371, longitude: -97.6122),
        "Calhoun": CLLocationCoordinate2D(latitude: 28.5833, longitude: -96.6146),
        "Callahan": CLLocationCoordinate2D(latitude: 32.2935, longitude: -99.3715),
        "Cameron": CLLocationCoordinate2D(latitude: 26.1072, longitude: -97.5081),
        "Camp": CLLocationCoordinate2D(latitude: 32.9729, longitude: -94.9785),
        "Carson": CLLocationCoordinate2D(latitude: 35.4031, longitude: -101.3546),
        "Cass": CLLocationCoordinate2D(latitude: 33.0738, longitude: -94.3527),
        "Castro": CLLocationCoordinate2D(latitude: 34.5324, longitude: -102.2607),
        "Chambers": CLLocationCoordinate2D(latitude: 29.7062, longitude: -94.6714),
        "Cherokee": CLLocationCoordinate2D(latitude: 31.8370, longitude: -95.1641),
        "Childress": CLLocationCoordinate2D(latitude: 34.5270, longitude: -100.2074),
        "Clay": CLLocationCoordinate2D(latitude: 33.7822, longitude: -98.2022),
        "Cochran": CLLocationCoordinate2D(latitude: 33.6078, longitude: -102.8298),
        "Coke": CLLocationCoordinate2D(latitude: 31.8882, longitude: -100.5300),
        "Coleman": CLLocationCoordinate2D(latitude: 31.7662, longitude: -99.4564),
        "Collin": CLLocationCoordinate2D(latitude: 33.1795, longitude: -96.4930),
        "Collingsworth": CLLocationCoordinate2D(latitude: 34.9658, longitude: -100.2708),
        "Colorado": CLLocationCoordinate2D(latitude: 29.6223, longitude: -96.5177),
        "Comal": CLLocationCoordinate2D(latitude: 29.8086, longitude: -98.2718),
        "Comanche": CLLocationCoordinate2D(latitude: 31.9487, longitude: -98.5514),
        "Concho": CLLocationCoordinate2D(latitude: 31.3261, longitude: -99.8644),
        "Cooke": CLLocationCoordinate2D(latitude: 33.6386, longitude: -97.2123),
        "Coryell": CLLocationCoordinate2D(latitude: 31.3895, longitude: -97.7995),
        "Cottle": CLLocationCoordinate2D(latitude: 34.0908, longitude: -100.2779),
        "Crane": CLLocationCoordinate2D(latitude: 31.4308, longitude: -102.5102),
        "Crockett": CLLocationCoordinate2D(latitude: 30.7252, longitude: -101.4134),
        "Crosby": CLLocationCoordinate2D(latitude: 33.6124, longitude: -101.2995),
        "Culberson": CLLocationCoordinate2D(latitude: 31.4489, longitude: -104.5174),
        "Dallam": CLLocationCoordinate2D(latitude: 36.2780, longitude: -102.6009),
        "Dallas": CLLocationCoordinate2D(latitude: 32.7767, longitude: -96.7970),
        "Dawson": CLLocationCoordinate2D(latitude: 32.7381, longitude: -101.9479),
        "Deaf Smith": CLLocationCoordinate2D(latitude: 34.9669, longitude: -102.6048),
        "Delta": CLLocationCoordinate2D(latitude: 33.3845, longitude: -95.6771),
        "Denton": CLLocationCoordinate2D(latitude: 33.2034, longitude: -97.1280),
        "De Witt": CLLocationCoordinate2D(latitude: 29.0800, longitude: -97.3517),
        "Dickens": CLLocationCoordinate2D(latitude: 33.6170, longitude: -100.7819),
        "Dimmit": CLLocationCoordinate2D(latitude: 28.4222, longitude: -99.7594),
        "Donley": CLLocationCoordinate2D(latitude: 34.9649, longitude: -100.8150),
        "Duval": CLLocationCoordinate2D(latitude: 27.6858, longitude: -98.5086),
        "Eastland": CLLocationCoordinate2D(latitude: 32.3323, longitude: -98.8361),
        "Ector": CLLocationCoordinate2D(latitude: 31.8656, longitude: -102.5431),
        "Edwards": CLLocationCoordinate2D(latitude: 29.9822, longitude: -100.3047),
        "Ellis": CLLocationCoordinate2D(latitude: 32.3487, longitude: -96.7970),
        "El Paso": CLLocationCoordinate2D(latitude: 31.7587, longitude: -106.4869),
        "Erath": CLLocationCoordinate2D(latitude: 32.2367, longitude: -98.2165),
        "Falls": CLLocationCoordinate2D(latitude: 31.2519, longitude: -96.9367),
        "Fannin": CLLocationCoordinate2D(latitude: 33.5928, longitude: -96.1089),
        "Fayette": CLLocationCoordinate2D(latitude: 29.8754, longitude: -96.9186),
        "Fisher": CLLocationCoordinate2D(latitude: 32.7436, longitude: -100.4016),
        "Floyd": CLLocationCoordinate2D(latitude: 34.0741, longitude: -101.3031),
        "Foard": CLLocationCoordinate2D(latitude: 33.9742, longitude: -99.7767),
        "Fort Bend": CLLocationCoordinate2D(latitude: 29.5254, longitude: -95.7710),
        "Franklin": CLLocationCoordinate2D(latitude: 33.1746, longitude: -95.2182),
        "Freestone": CLLocationCoordinate2D(latitude: 31.7048, longitude: -96.1494),
        "Frio": CLLocationCoordinate2D(latitude: 28.8669, longitude: -99.1064),
        "Gaines": CLLocationCoordinate2D(latitude: 32.7436, longitude: -102.6370),
        "Galveston": CLLocationCoordinate2D(latitude: 29.3784, longitude: -94.9658),
        "Garza": CLLocationCoordinate2D(latitude: 33.1794, longitude: -101.2995),
        "Gillespie": CLLocationCoordinate2D(latitude: 30.3181, longitude: -98.9455),
        "Glasscock": CLLocationCoordinate2D(latitude: 31.8656, longitude: -101.5239),
        "Goliad": CLLocationCoordinate2D(latitude: 28.6585, longitude: -97.4258),
        "Gonzales": CLLocationCoordinate2D(latitude: 29.4558, longitude: -97.4936),
        "Gray": CLLocationCoordinate2D(latitude: 35.4031, longitude: -100.8150),
        "Grayson": CLLocationCoordinate2D(latitude: 33.6243, longitude: -96.6789),
        "Gregg": CLLocationCoordinate2D(latitude: 32.4818, longitude: -94.8160),
        "Grimes": CLLocationCoordinate2D(latitude: 30.5441, longitude: -95.9838),
        "Guadalupe": CLLocationCoordinate2D(latitude: 29.5830, longitude: -97.9647),
        "Hale": CLLocationCoordinate2D(latitude: 34.0741, longitude: -101.8241),
        "Hall": CLLocationCoordinate2D(latitude: 34.5304, longitude: -100.6789),
        "Hamilton": CLLocationCoordinate2D(latitude: 31.7048, longitude: -98.1102),
        "Hansford": CLLocationCoordinate2D(latitude: 36.2780, longitude: -101.3566),
        "Hardeman": CLLocationCoordinate2D(latitude: 34.2874, longitude: -99.7455),
        "Hardin": CLLocationCoordinate2D(latitude: 30.3293, longitude: -94.3889),
        "Harris": CLLocationCoordinate2D(latitude: 29.8573, longitude: -95.3923),
        "Harrison": CLLocationCoordinate2D(latitude: 32.5487, longitude: -94.3715),
        "Hartley": CLLocationCoordinate2D(latitude: 35.8399, longitude: -102.6009),
        "Haskell": CLLocationCoordinate2D(latitude: 33.1794, longitude: -99.7455),
        "Hays": CLLocationCoordinate2D(latitude: 30.0572, longitude: -98.0289),
        "Hemphill": CLLocationCoordinate2D(latitude: 35.8399, longitude: -100.2708),
        "Henderson": CLLocationCoordinate2D(latitude: 32.2135, longitude: -95.8506),
        "Hidalgo": CLLocationCoordinate2D(latitude: 26.3964, longitude: -98.1836),
        "Hill": CLLocationCoordinate2D(latitude: 32.0035, longitude: -97.1314),
        "Hockley": CLLocationCoordinate2D(latitude: 33.6078, longitude: -102.3431),
        "Hood": CLLocationCoordinate2D(latitude: 32.4367, longitude: -97.8330),
        "Hopkins": CLLocationCoordinate2D(latitude: 33.1451, longitude: -95.5671),
        "Houston": CLLocationCoordinate2D(latitude: 31.3184, longitude: -95.4258),
        "Howard": CLLocationCoordinate2D(latitude: 32.3035, longitude: -101.4316),
        "Hudspeth": CLLocationCoordinate2D(latitude: 31.4489, longitude: -105.3777),
        "Hunt": CLLocationCoordinate2D(latitude: 33.1246, longitude: -96.0864),
        "Hutchinson": CLLocationCoordinate2D(latitude: 35.8399, longitude: -101.3566),
        "Irion": CLLocationCoordinate2D(latitude: 31.3042, longitude: -100.9820),
        "Jack": CLLocationCoordinate2D(latitude: 33.2323, longitude: -98.1722),
        "Jackson": CLLocationCoordinate2D(latitude: 28.9558, longitude: -96.5847),
        "Jasper": CLLocationCoordinate2D(latitude: 30.7402, longitude: -94.0138),
        "Jeff Davis": CLLocationCoordinate2D(latitude: 30.7170, longitude: -104.1270),
        "Jefferson": CLLocationCoordinate2D(latitude: 29.8832, longitude: -94.1555),
        "Jim Hogg": CLLocationCoordinate2D(latitude: 27.0453, longitude: -98.6949),
        "Jim Wells": CLLocationCoordinate2D(latitude: 27.7336, longitude: -98.0894),
        "Johnson": CLLocationCoordinate2D(latitude: 32.3793, longitude: -97.3641),
        "Jones": CLLocationCoordinate2D(latitude: 32.7436, longitude: -99.8788),
        "Karnes": CLLocationCoordinate2D(latitude: 28.9053, longitude: -97.8558),
        "Kaufman": CLLocationCoordinate2D(latitude: 32.5991, longitude: -96.2864),
        "Kendall": CLLocationCoordinate2D(latitude: 29.9447, longitude: -98.7117),
        "Kenedy": CLLocationCoordinate2D(latitude: 26.9248, longitude: -97.6686),
        "Kent": CLLocationCoordinate2D(latitude: 33.1794, longitude: -100.7819),
        "Kerr": CLLocationCoordinate2D(latitude: 30.0572, longitude: -99.3502),
        "Kimble": CLLocationCoordinate2D(latitude: 30.4833, longitude: -99.7455),
        "King": CLLocationCoordinate2D(latitude: 33.6170, longitude: -100.2536),
        "Kinney": CLLocationCoordinate2D(latitude: 29.3467, longitude: -100.4180),
        "Kleberg": CLLocationCoordinate2D(latitude: 27.4311, longitude: -97.6558),
        "Knox": CLLocationCoordinate2D(latitude: 33.6078, longitude: -99.7455),
        "Lamar": CLLocationCoordinate2D(latitude: 33.6673, longitude: -95.5714),
        "Lamb": CLLocationCoordinate2D(latitude: 34.0659, longitude: -102.3431),
        "Lampasas": CLLocationCoordinate2D(latitude: 31.1940, longitude: -98.2413),
        "La Salle": CLLocationCoordinate2D(latitude: 28.3467, longitude: -99.1064),
        "Lavaca": CLLocationCoordinate2D(latitude: 29.3784, longitude: -96.9258),
        "Lee": CLLocationCoordinate2D(latitude: 30.3122, longitude: -96.9789),
        "Leon": CLLocationCoordinate2D(latitude: 31.2935, longitude: -95.9122),
        "Liberty": CLLocationCoordinate2D(latitude: 30.1508, longitude: -94.8158),
        "Limestone": CLLocationCoordinate2D(latitude: 31.5435, longitude: -96.5861),
        "Lipscomb": CLLocationCoordinate2D(latitude: 36.2780, longitude: -100.2708),
        "Live Oak": CLLocationCoordinate2D(latitude: 28.3508, longitude: -98.1247),
        "Llano": CLLocationCoordinate2D(latitude: 30.7531, longitude: -98.6894),
        "Loving": CLLocationCoordinate2D(latitude: 31.8490, longitude: -103.5645),
        "Lubbock": CLLocationCoordinate2D(latitude: 33.6103, longitude: -101.8213),
        "Lynn": CLLocationCoordinate2D(latitude: 33.1794, longitude: -101.8184),
        "McCulloch": CLLocationCoordinate2D(latitude: 31.1940, longitude: -99.3442),
        "McLennan": CLLocationCoordinate2D(latitude: 31.5493, longitude: -97.2022),
        "McMullen": CLLocationCoordinate2D(latitude: 28.3508, longitude: -98.5678),
        "Madison": CLLocationCoordinate2D(latitude: 30.9619, longitude: -95.9313),
        "Marion": CLLocationCoordinate2D(latitude: 32.7935, longitude: -94.3589),
        "Martin": CLLocationCoordinate2D(latitude: 32.3035, longitude: -101.9479),
        "Mason": CLLocationCoordinate2D(latitude: 30.7114, longitude: -99.2324),
        "Matagorda": CLLocationCoordinate2D(latitude: 28.7862, longitude: -95.9658),
        "Maverick": CLLocationCoordinate2D(latitude: 28.7425, longitude: -100.3155),
        "Medina": CLLocationCoordinate2D(latitude: 29.3556, longitude: -99.1103),
        "Menard": CLLocationCoordinate2D(latitude: 30.8799, longitude: -99.8211),
        "Midland": CLLocationCoordinate2D(latitude: 31.8490, longitude: -102.0314),
        "Milam": CLLocationCoordinate2D(latitude: 30.7849, longitude: -96.9789),
        "Mills": CLLocationCoordinate2D(latitude: 31.4940, longitude: -98.5939),
        "Mitchell": CLLocationCoordinate2D(latitude: 32.3035, longitude: -100.9198),
        "Montague": CLLocationCoordinate2D(latitude: 33.6673, longitude: -97.7214),
        "Montgomery": CLLocationCoordinate2D(latitude: 30.3079, longitude: -95.5023),
        "Moore": CLLocationCoordinate2D(latitude: 35.8399, longitude: -101.8927),
        "Morris": CLLocationCoordinate2D(latitude: 33.1146, longitude: -94.7315),
        "Motley": CLLocationCoordinate2D(latitude: 34.0741, longitude: -100.7819),
        "Nacogdoches": CLLocationCoordinate2D(latitude: 31.6218, longitude: -94.6110),
        "Navarro": CLLocationCoordinate2D(latitude: 32.0420, longitude: -96.4764),
        "Newton": CLLocationCoordinate2D(latitude: 30.7849, longitude: -93.7400),
        "Nolan": CLLocationCoordinate2D(latitude: 32.3035, longitude: -100.4016),
        "Nueces": CLLocationCoordinate2D(latitude: 27.7361, longitude: -97.5136),
        "Ochiltree": CLLocationCoordinate2D(latitude: 36.2780, longitude: -100.8150),
        "Oldham": CLLocationCoordinate2D(latitude: 35.4031, longitude: -102.6009),
        "Orange": CLLocationCoordinate2D(latitude: 30.1230, longitude: -93.8935),
        "Palo Pinto": CLLocationCoordinate2D(latitude: 32.7549, longitude: -98.3103),
        "Panola": CLLocationCoordinate2D(latitude: 32.1637, longitude: -94.3027),
        "Parker": CLLocationCoordinate2D(latitude: 32.7781, longitude: -97.8055),
        "Parmer": CLLocationCoordinate2D(latitude: 34.5324, longitude: -102.7840),
        "Pecos": CLLocationCoordinate2D(latitude: 30.7806, longitude: -102.7223),
        "Polk": CLLocationCoordinate2D(latitude: 30.7941, longitude: -94.8474),
        "Potter": CLLocationCoordinate2D(latitude: 35.4031, longitude: -101.8927),
        "Presidio": CLLocationCoordinate2D(latitude: 29.9999, longitude: -104.2412),
        "Rains": CLLocationCoordinate2D(latitude: 32.8709, longitude: -95.7928),
        "Randall": CLLocationCoordinate2D(latitude: 34.9669, longitude: -101.8927),
        "Reagan": CLLocationCoordinate2D(latitude: 31.3670, longitude: -101.5239),
        "Real": CLLocationCoordinate2D(latitude: 29.8308, longitude: -99.8211),
        "Red River": CLLocationCoordinate2D(latitude: 33.6161, longitude: -95.0483),
        "Reeves": CLLocationCoordinate2D(latitude: 31.3261, longitude: -103.6926),
        "Refugio": CLLocationCoordinate2D(latitude: 28.3234, longitude: -97.1519),
        "Roberts": CLLocationCoordinate2D(latitude: 35.8399, longitude: -100.8150),
        "Robertson": CLLocationCoordinate2D(latitude: 31.0270, longitude: -96.5138),
        "Rockwall": CLLocationCoordinate2D(latitude: 32.8896, longitude: -96.4058),
        "Runnels": CLLocationCoordinate2D(latitude: 31.8330, longitude: -99.9720),
        "Rusk": CLLocationCoordinate2D(latitude: 32.1091, longitude: -94.7610),
        "Sabine": CLLocationCoordinate2D(latitude: 31.3436, longitude: -93.8508),
        "San Augustine": CLLocationCoordinate2D(latitude: 31.3951, longitude: -94.1711),
        "San Jacinto": CLLocationCoordinate2D(latitude: 30.5718, longitude: -95.1638),
        "San Patricio": CLLocationCoordinate2D(latitude: 28.0110, longitude: -97.5172),
        "San Saba": CLLocationCoordinate2D(latitude: 31.1557, longitude: -98.8161),
        "Schleicher": CLLocationCoordinate2D(latitude: 30.8966, longitude: -100.5300),
        "Scurry": CLLocationCoordinate2D(latitude: 32.7436, longitude: -100.9198),
        "Shackelford": CLLocationCoordinate2D(latitude: 32.7436, longitude: -99.3503),
        "Shelby": CLLocationCoordinate2D(latitude: 31.7935, longitude: -94.1430),
        "Sherman": CLLocationCoordinate2D(latitude: 36.2780, longitude: -101.8927),
        "Smith": CLLocationCoordinate2D(latitude: 32.3746, longitude: -95.2708),
        "Somervell": CLLocationCoordinate2D(latitude: 32.2179, longitude: -97.7714),
        "Starr": CLLocationCoordinate2D(latitude: 26.5624, longitude: -98.7456),
        "Stephens": CLLocationCoordinate2D(latitude: 32.7381, longitude: -98.8361),
        "Sterling": CLLocationCoordinate2D(latitude: 31.8330, longitude: -101.0501),
        "Stonewall": CLLocationCoordinate2D(latitude: 33.1794, longitude: -100.2536),
        "Sutton": CLLocationCoordinate2D(latitude: 30.4872, longitude: -100.5300),
        "Swisher": CLLocationCoordinate2D(latitude: 34.5324, longitude: -101.7344),
        "Tarrant": CLLocationCoordinate2D(latitude: 32.7732, longitude: -97.2918),
        "Taylor": CLLocationCoordinate2D(latitude: 32.3035, longitude: -99.8788),
        "Terrell": CLLocationCoordinate2D(latitude: 30.2252, longitude: -102.0693),
        "Terry": CLLocationCoordinate2D(latitude: 33.1740, longitude: -102.3431),
        "Throckmorton": CLLocationCoordinate2D(latitude: 33.1794, longitude: -99.2122),
        "Titus": CLLocationCoordinate2D(latitude: 33.2134, longitude: -94.9658),
        "Tom Green": CLLocationCoordinate2D(latitude: 31.4033, longitude: -100.4621),
        "Travis": CLLocationCoordinate2D(latitude: 30.2390, longitude: -97.7695),
        "Trinity": CLLocationCoordinate2D(latitude: 31.0850, longitude: -95.1377),
        "Tyler": CLLocationCoordinate2D(latitude: 30.7715, longitude: -94.3715),
        "Upshur": CLLocationCoordinate2D(latitude: 32.7361, longitude: -94.9444),
        "Upton": CLLocationCoordinate2D(latitude: 31.3670, longitude: -102.0431),
        "Uvalde": CLLocationCoordinate2D(latitude: 29.3556, longitude: -99.7644),
        "Val Verde": CLLocationCoordinate2D(latitude: 29.8908, longitude: -101.1519),
        "Van Zandt": CLLocationCoordinate2D(latitude: 32.5618, longitude: -95.8358),
        "Victoria": CLLocationCoordinate2D(latitude: 28.7950, longitude: -96.9716),
        "Walker": CLLocationCoordinate2D(latitude: 30.7383, longitude: -95.5722),
        "Waller": CLLocationCoordinate2D(latitude: 30.0119, longitude: -95.9880),
        "Ward": CLLocationCoordinate2D(latitude: 31.5108, longitude: -103.0595),
        "Washington": CLLocationCoordinate2D(latitude: 30.2135, longitude: -96.4033),
        "Webb": CLLocationCoordinate2D(latitude: 27.7610, longitude: -99.3312),
        "Wharton": CLLocationCoordinate2D(latitude: 29.2793, longitude: -96.2230),
        "Wheeler": CLLocationCoordinate2D(latitude: 35.4031, longitude: -100.2708),
        "Wichita": CLLocationCoordinate2D(latitude: 33.9873, longitude: -98.7016),
        "Wilbarger": CLLocationCoordinate2D(latitude: 34.0833, longitude: -99.2434),
        "Willacy": CLLocationCoordinate2D(latitude: 26.4758, longitude: -97.7886),
        "Williamson": CLLocationCoordinate2D(latitude: 30.6459, longitude: -97.6022),
        "Wilson": CLLocationCoordinate2D(latitude: 29.1741, longitude: -98.0866),
        "Winkler": CLLocationCoordinate2D(latitude: 31.8490, longitude: -103.0595),
        "Wise": CLLocationCoordinate2D(latitude: 33.2134, longitude: -97.6547),
        "Wood": CLLocationCoordinate2D(latitude: 32.7860, longitude: -95.3825),
        "Yoakum": CLLocationCoordinate2D(latitude: 33.1740, longitude: -102.8298),
        "Young": CLLocationCoordinate2D(latitude: 33.1746, longitude: -98.6896),
        "Zapata": CLLocationCoordinate2D(latitude: 26.9787, longitude: -99.2619),
        "Zavala": CLLocationCoordinate2D(latitude: 28.8669, longitude: -99.7594)
    ]

    // Function to update location based on county name input
    func updateLocation(for countyName: String) {
        if let coordinate = countyCoordinates[countyName.capitalized] {
            countyCoordinate = CountyAnnotation(coordinate: coordinate)
            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            )
        } else {
            countyCoordinate = nil // Reset if county name is invalid
        }
    }
}
