import SwiftUI
import MapKit

struct HomePage: View {
    @State private var countyInput: String = ""
    @State private var isValidCounty = true
    @State private var navigateToStatsPage = false
    @State private var riskScore: Int? = nil // State to hold the risk score
    @StateObject private var locationViewModel = LocationViewModel()
    private let riskDataLoader = RiskDataLoader() // Ensure this is non-optional
    
    // List of valid counties
        let validCounties = [
                "Anderson", "Andrews", "Angelina", "Aransas", "Archer", "Armstrong", "Atascosa",
                "Austin", "Bailey", "Bandera", "Bastrop", "Baylor", "Bee", "Bell", "Bexar", "Blanco",
                "Borden", "Bosque", "Bowie", "Brazoria", "Brazos", "Brewster", "Briscoe", "Brooks",
                "Brown", "Burleson", "Burnet", "Caldwell", "Calhoun", "Callahan", "Cameron", "Camp",
                "Carson", "Cass", "Castro", "Chambers", "Cherokee", "Childress", "Clay", "Cochran",
                "Coke", "Coleman", "Collin", "Collingsworth", "Colorado", "Comal", "Comanche", "Concho",
                "Cooke", "Coryell", "Cottle", "Crane", "Crockett", "Crosby", "Culberson", "Dallam",
                "Dallas", "Dawson", "Deaf Smith", "Delta", "Denton", "De Witt", "Dickens", "Dimmit",
                "Donley", "Duval", "Eastland", "Ector", "Edwards", "Ellis", "El Paso", "Erath", "Falls",
                "Fannin", "Fayette", "Fisher", "Floyd", "Foard", "Fort Bend", "Franklin", "Freestone",
                "Frio", "Gaines", "Galveston", "Garza", "Gillespie", "Glasscock", "Goliad", "Gonzales",
                "Gray", "Grayson", "Gregg", "Grimes", "Guadalupe", "Hale", "Hall", "Hamilton", "Hansford",
                "Hardeman", "Hardin", "Harris", "Harrison", "Hartley", "Haskell", "Hays", "Hemphill",
                "Henderson", "Hidalgo", "Hill", "Hockley", "Hood", "Hopkins", "Houston", "Howard",
                "Hudspeth", "Hunt", "Hutchinson", "Irion", "Jack", "Jackson", "Jasper", "Jeff Davis",
                "Jefferson", "Jim Hogg", "Jim Wells", "Johnson", "Jones", "Karnes", "Kaufman", "Kendall",
                "Kenedy", "Kent", "Kerr", "Kimble", "King", "Kinney", "Kleberg", "Knox", "Lamar", "Lamb",
                "Lampasas", "La Salle", "Lavaca", "Lee", "Leon", "Liberty", "Limestone", "Lipscomb",
                "Live Oak", "Llano", "Loving", "Lubbock", "Lynn", "McCulloch", "McLennan", "McMullen",
                "Madison", "Marion", "Martin", "Mason", "Matagorda", "Maverick", "Medina", "Menard",
                "Midland", "Milam", "Mills", "Mitchell", "Montague", "Montgomery", "Moore", "Morris",
                "Motley", "Nacogdoches", "Navarro", "Newton", "Nolan", "Nueces", "Ochiltree", "Oldham",
                "Orange", "Palo Pinto", "Panola", "Parker", "Parmer", "Pecos", "Polk", "Potter", "Presidio",
                "Rains", "Randall", "Reagan", "Real", "Red River", "Reeves", "Refugio", "Roberts",
                "Robertson", "Rockwall", "Runnels", "Rusk", "Sabine", "San Augustine", "San Jacinto",
                "San Patricio", "San Saba", "Schleicher", "Scurry", "Shackelford", "Shelby", "Sherman",
                "Smith", "Somervell", "Starr", "Stephens", "Sterling", "Stonewall", "Sutton", "Swisher",
                "Tarrant", "Taylor", "Terrell", "Terry", "Throckmorton", "Titus", "Tom Green", "Travis",
                "Trinity", "Tyler", "Upshur", "Upton", "Uvalde", "Val Verde", "Van Zandt", "Victoria",
                "Walker", "Waller", "Ward", "Washington", "Webb", "Wharton", "Wheeler", "Wichita",
                "Wilbarger", "Willacy", "Williamson", "Wilson", "Winkler", "Wise", "Wood", "Yoakum",
                "Young", "Zapata", "Zavala"
            ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 26 / 255, green: 76 / 255, blue: 57 / 255),
                        Color(red: 13 / 255, green: 38 / 255, blue: 28 / 255),
                        Color(red: 5 / 255, green: 25 / 255, blue: 18 / 255),
                        Color(red: 13 / 255, green: 38 / 255, blue: 28 / 255),
                        Color(red: 26 / 255, green: 76 / 255, blue: 57 / 255)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("TerraTrust")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 223 / 255, green: 224 / 255, blue: 220 / 255))
                        .padding(.top, 150)

                    // County Input and Validation
                    HStack(spacing: 0) {
                        TextField("Enter a Texas County", text: $countyInput)
                            .padding()
                            .background(Color(red: 223 / 255, green: 224 / 255, blue: 220 / 255))
                            .cornerRadius(25)
                            .padding(.leading, 8)

                        Button(action: {
                            let formattedCounty = countyInput.capitalized
                            if validCounties.contains(formattedCounty) {
                                isValidCounty = true
                                locationViewModel.updateLocation(for: countyInput) // Update location on the map
                            } else {
                                isValidCounty = false
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color(hexString: "#051912"))
                                    .frame(width: 36, height: 36)
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing, 10)
                        }
                    }
                    .background(Color(red: 223 / 255, green: 224 / 255, blue: 220 / 255))
                    .cornerRadius(25)
                    .padding(.horizontal)

                    if !isValidCounty {
                        Text("Invalid county. Please enter a valid Texas county.")
                            .foregroundColor(.red)
                            .padding(.top, 5)
                    }

                    // "Analyze" Button to Get Risk Score
                    Button(action: {
                        let formattedCounty = countyInput.capitalized
                        if validCounties.contains(formattedCounty), let score = riskDataLoader?.getRiskScore(for: formattedCounty) {
                            riskScore = score
                            navigateToStatsPage = true // Trigger navigation to StatsPage
                        } else {
                            isValidCounty = false
                        }
                    }) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Analyze")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .background(LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 113 / 255, green: 150 / 255, blue: 110 / 255),
                                Color(red: 45 / 255, green: 85 / 255, blue: 60 / 255)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .foregroundColor(Color(red: 223 / 255, green: 224 / 255, blue: 220 / 255))
                        .cornerRadius(10)
                    }
                    .padding(.top)

                    // NavigationLink to StatsPage
                    NavigationLink(
                        destination: StatsPage(county: countyInput, riskScore: riskScore ?? 0).navigationBarBackButtonHidden(true),
                        isActive: $navigateToStatsPage
                    ) {
                        EmptyView()
                    }

                    // MapView to Display County Location
                    Map(coordinateRegion: $locationViewModel.region, annotationItems: locationViewModel.countyCoordinate != nil ? [locationViewModel.countyCoordinate!] : []) { annotation in
                        MapPin(coordinate: annotation.coordinate, tint: .red)
                    }
                    .cornerRadius(10)
                    .frame(height: 300)
                    .padding(.horizontal)
                    .padding(.top, 30)

                    Spacer()

                    Image("mountain")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                        .opacity(0.3)
                }
            }
        }
    }
}

// Extension to support hex color
extension Color {
    init(hexString: String) {
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 1 // Skip the `#`

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
