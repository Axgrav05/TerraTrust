import Foundation

class RiskDataLoader {
    private static let counties = [
        "Anderson", "Andrews", "Angelina", "Aransas", "Archer", "Armstrong", "Atascosa", "Austin", "Bailey", "Bandera",
        "Bastrop", "Baylor", "Bee", "Bell", "Bexar", "Blanco", "Borden", "Bosque", "Bowie", "Brazoria",
        "Brazos", "Brewster", "Briscoe", "Brooks", "Brown", "Burleson", "Burnet", "Caldwell", "Calhoun", "Callahan",
        "Cameron", "Camp", "Carson", "Cass", "Castro", "Chambers", "Cherokee", "Childress", "Clay", "Cochran",
        "Coke", "Coleman", "Collin", "Collingsworth", "Colorado", "Comal", "Comanche", "Concho", "Cooke", "Coryell",
        "Cottle", "Crane", "Crockett", "Crosby", "Culberson", "Dallam", "Dallas", "Dawson", "Deaf Smith", "Delta",
        "Denton", "De Witt", "Dickens", "Dimmit", "Donley", "Duval", "Eastland", "Ector", "Edwards", "Ellis",
        "El Paso", "Erath", "Falls", "Fannin", "Fayette", "Fisher", "Floyd", "Foard", "Fort Bend", "Franklin",
        "Freestone", "Frio", "Gaines", "Galveston", "Garza", "Gillespie", "Glasscock", "Goliad", "Gonzales", "Gray",
        "Grayson", "Gregg", "Grimes", "Guadalupe", "Hale", "Hall", "Hamilton", "Hansford", "Hardeman", "Hardin",
        "Harris", "Harrison", "Hartley", "Haskell", "Hays", "Hemphill", "Henderson", "Hidalgo", "Hill", "Hockley",
        "Hood", "Hopkins", "Houston", "Howard", "Hudspeth", "Hunt", "Hutchinson", "Irion", "Jack", "Jackson",
        "Jasper", "Jeff Davis", "Jefferson", "Jim Hogg", "Jim Wells", "Johnson", "Jones", "Karnes", "Kaufman", "Kendall",
        "Kenedy", "Kent", "Kerr", "Kimble", "King", "Kinney", "Kleberg", "Knox", "Lamar", "Lamb",
        "Lampasas", "La Salle", "Lavaca", "Lee", "Leon", "Liberty", "Limestone", "Lipscomb", "Live Oak", "Llano",
        "Loving", "Lubbock", "Lynn", "McCulloch", "McLennan", "McMullen", "Madison", "Marion", "Martin", "Mason",
        "Matagorda", "Maverick", "Medina", "Menard", "Midland", "Milam", "Mills", "Mitchell", "Montague", "Montgomery",
        "Moore", "Morris", "Motley", "Nacogdoches", "Navarro", "Newton", "Nolan", "Nueces", "Ochiltree", "Oldham",
        "Orange", "Palo Pinto", "Panola", "Parker", "Parmer", "Pecos", "Polk", "Potter", "Presidio", "Rains",
        "Randall", "Reagan", "Real", "Red River", "Reeves", "Refugio", "Roberts", "Robertson", "Rockwall", "Runnels",
        "Rusk", "Sabine", "San Augustine", "San Jacinto", "San Patricio", "San Saba", "Schleicher", "Scurry", "Shackelford", "Shelby",
        "Sherman", "Smith", "Somervell", "Starr", "Stephens", "Sterling", "Stonewall", "Sutton", "Swisher", "Tarrant",
        "Taylor", "Terrell", "Terry", "Throckmorton", "Titus", "Tom Green", "Travis", "Trinity", "Tyler", "Upshur",
        "Upton", "Uvalde", "Val Verde", "Van Zandt", "Victoria", "Walker", "Waller", "Ward", "Washington", "Webb",
        "Wharton", "Wheeler", "Wichita", "Wilbarger", "Willacy", "Williamson", "Wilson", "Winkler", "Wise", "Wood",
        "Yoakum", "Young", "Zapata", "Zavala"
    ]

    private static let risk_scores = [
        44, 43, 43, 41, 30, 27, 33, 32, 32, 21,
        39, 35, 32, 36, 28, 28, 28, 34, 30, 31,
        26, 28, 29, 35, 26, 34, 41, 18, 18, 24,
        40, 36, 33, 35, 44, 31, 24, 30, 25, 36,
        21, 35, 26, 34, 16, 38, 30, 31, 17, 30,
        23, 27, 32, 34, 25, 33, 38, 29, 29, 25,
        33, 26, 30, 31, 30, 19, 34, 26, 23, 34,
        41, 34, 23, 23, 36, 35, 32, 30, 23, 39,
        35, 42, 45, 45, 39, 45, 30, 29, 36, 45,
        37, 37, 24, 41, 37, 29, 29, 34, 34, 38,
        39, 30, 36, 25, 33, 43, 18, 44, 35, 28,
        37, 29, 26, 34, 33, 42, 31, 30, 33, 37,
        43, 22, 39, 27, 36, 31, 31, 40, 28, 34,
        44, 21, 34, 30, 41, 33, 43, 26, 32, 43,
        32, 25, 27, 40, 25, 41, 38, 28, 32, 42,
        30, 29, 42, 32, 37, 25, 45, 33, 24, 39,
        40, 36, 36, 33, 35, 50, 33, 39, 41, 43,
        31, 29, 48, 43, 40, 28, 36, 42, 22, 37,
        41, 43, 35, 21, 39, 31, 32, 42, 39, 37,
        36, 28, 41, 33, 36, 32, 32, 44, 46, 25,
        30, 49, 32, 39, 51, 28, 40, 38, 44, 31,
        35, 40, 45, 38, 34, 32, 37, 28, 46, 33,
        35, 46, 36, 35, 43, 28, 39, 51, 32, 28,
        47, 29, 31, 36, 38, 38, 36, 44, 30, 37,
        38, 31, 40, 42, 35, 34, 43, 42, 42, 29,
        40, 38, 42, 31
    ]
    private var riskData: [String: Int]

        init?() {
            // Check for mismatched array lengths
            guard RiskDataLoader.counties.count == RiskDataLoader.risk_scores.count else {
                print("Error: 'counties' and 'risk_scores' arrays have different lengths.")
                return nil
            }
            
            // Initialize dictionary
            riskData = Dictionary(uniqueKeysWithValues: zip(RiskDataLoader.counties, RiskDataLoader.risk_scores))
        }

        func getRiskScore(for county: String) -> Int? {
            return riskData[county.capitalized]
        }
}
