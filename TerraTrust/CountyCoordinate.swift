import Foundation
import CoreLocation

struct CountyCoordinate: Identifiable {
    var id = UUID() // Conforms to Identifiable
    var coordinate: CLLocationCoordinate2D
}
