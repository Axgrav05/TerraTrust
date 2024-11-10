import Foundation

struct CountyDataLoader {
    // Function to read the CSV and return the features for a specified county
    static func loadFeatures(forCounty countyName: String) -> [Double]? {
        guard let path = Bundle.main.path(forResource: "Data", ofType: "csv") else {
            print("CSV file not found in assets.")
            return nil
        }

        do {
            let content = try String(contentsOfFile: path)
            let rows = content.components(separatedBy: "\n")
            
            // Assuming the first row contains the headers
            let headers = rows[0].components(separatedBy: ",")
            let countyIndex = headers.firstIndex(of: "County")
            
            guard let countyIndex = countyIndex else {
                print("County column not found in CSV.")
                return nil
            }
            
            for row in rows.dropFirst() { // Skip headers row
                let columns = row.components(separatedBy: ",")
                
                if columns.count > countyIndex, columns[countyIndex].trimmingCharacters(in: .whitespaces) == countyName {
                    // Convert the columns (excluding the "County" column) into Double values
                    let features = columns.enumerated()
                        .filter { $0.offset != countyIndex } // Skip the county name
                        .compactMap { Double($0.element.trimmingCharacters(in: .whitespaces)) }
                    
                    return features
                }
            }
            print("County \(countyName) not found in CSV.")
            return nil
            
        } catch {
            print("Failed to read CSV file: \(error)")
            return nil
        }
    }
}
