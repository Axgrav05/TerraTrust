import SwiftUI

struct StatsPage: View {
    var county: String
    var riskScore: Int // Accept the risk score as a parameter

    // Example data for the pie chart
    let pieData = [
        ("ENVIRONMENTAL", 55.0),
        ("CRIMES", 15.0),
        ("ECONOMIC", 30.0)
    ]
    
    @State private var imageOffset: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                // Full screen gradient background with forest green to slightly lighter green
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "#1A4C39"), Color(hex: "#0D261C"), Color(hex: "#051912"), Color(hex: "#0D261C"), Color(hex: "#1A4C39")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack {
                    NavigationLink(destination: HomePage().navigationBarBackButtonHidden(true)) {
                        ZStack {
                            Circle()
                                .stroke(Color(hex: "#DFE0DC"), lineWidth: 3)
                                .frame(width: 50, height: 50)
                                .contentShape(Circle())
                            
                            Image(systemName: "house.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color(hex: "#DFE0DC"))
                        }
                    }
                    .padding(.leading, -160)
                    .padding(.top, 20)
                    
                    // Title
                    Text("Risk Analysis for \(county) County")
                        .font(.system(size: 20))
                        .padding(.top, 25)
                        .foregroundColor(Color(hex: "#DFE0DC"))
                        .fontWeight(.bold)
                    
                    // Display the Risk Score
                    Text("Risk Score: \(riskScore)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "#DFE0DC"))
                        .padding()

                    // Donut chart
                    DonutChart(data: pieData)
                        .frame(width: 300, height: 300)
                        .padding()
                    
                    Spacer()
                    
                    // Animated image placeholder at the bottom
                    Image("mountain")
                        .resizable()
                        .frame(width: 600, height: 350)
                        .ignoresSafeArea()
                        .padding(.bottom, -40)
                        .opacity(0.3)
                        .offset(x: imageOffset)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                                imageOffset = 50 // Move the image 50 points to the right and left
                            }
                        }
                }
            }
        }
    }
}


struct DonutChart: View {
    var data: [(String, Double)]
    
    private var totalValue: Double {
        data.reduce(0) { $0 + $1.1 }
    }
    
    private func angle(forIndex index: Int) -> Double {
        let startAngle = data.prefix(index).reduce(0) { $0 + $1.1 } / totalValue * 360
        return startAngle
    }
    
    private func percentage(forIndex index: Int) -> Double {
        return (data[index].1 / totalValue) * 100
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<data.count, id: \.self) { index in
                let angle = angle(forIndex: index)
                let endAngle = angle + (data[index].1 / totalValue * 360)
                
                // Draw the donut slice without animation
                DonutSliceView(startAngle: Angle(degrees: angle), endAngle: Angle(degrees: endAngle))
                    .fill(self.color(forIndex: index)) // Use updated hex color
                    .onTapGesture {
                        print("\(data[index].0) clicked") // Handle click event
                    }
                
                // Percentage label (Optional, can still show if needed)
                let labelAngle = angle + (endAngle - angle) / 2  // Center the label on the slice
                let textRadius = 200.0
                
                Text("\(Int(percentage(forIndex: index)))%\n\(data[index].0.prefix(3))")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(self.color(forIndex: index))
                    .multilineTextAlignment(.center)
                    .position(x: cos(Angle(degrees: labelAngle).radians) * textRadius + 150, y: sin(Angle(degrees: labelAngle).radians) * textRadius + 150)
            }
        }
    }
    
    private func color(forIndex index: Int) -> Color {
        // Updated hex and RGB color values for each slice
        let hexColors: [Color] = [
            Color(hex: "#267355"), // Category A - Dark green
            Color(hex: "#1A4C39"), // Category B - Green
            Color(hex: "#319B72") // Category C - RGB: 113/255, 150/255, 110/255
        ]
        return hexColors[index % hexColors.count]
    }
}

struct DonutSliceView: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius / 2 // Adjust the inner radius for the hole in the center
        
        var path = Path()
        path.move(to: center)
        
        // Outer arc (the edge of the donut)
        path.addArc(center: center, radius: outerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        // Inner arc (the hole in the donut)
        path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        
        path.closeSubpath()
        
        return path
    }
}

extension Color {
    // Custom initializer to create a Color from Hex value
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        if hexSanitized.count == 6 {
            hexSanitized = "FF" + hexSanitized // Adding full opacity
        }
        
        if let hexValue = Int(hexSanitized, radix: 16) {
            self.init(
                .sRGB,
                red: Double((hexValue >> 16) & 0xFF) / 255.0,
                green: Double((hexValue >> 8) & 0xFF) / 255.0,
                blue: Double(hexValue & 0xFF) / 255.0,
                opacity: 1.0
            )
        } else {
            self.init(.clear)
        }
    }
}

struct StatsPage_Previews: PreviewProvider {
    static var previews: some View {
        StatsPage(county: "Harris", riskScore: 75) // Example county and risk score for preview
    }
}

