//  LetsCount
//  FyraUtrakningarView.swift
//  Created by Hanna Christensson on 2024-01-27.


import SwiftUI

enum CalculationType {
    case addition, subtraction, multiplication, division
}


struct FyraUtrakningarView: View {
    
    @State private var input1: String = ""
    @State private var input2: String = ""
    @State private var result: Double? = nil
    @State private var resultString: String = "Result"
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var selectedCalculation: CalculationType = .addition
    
    @FocusState private var isInputFocused: Bool  //Används för att hålla koll på tangentbordets fokus.
    @Environment(\.colorScheme) var colorScheme // Används för att detektera nuvarande färgschema
    
    var body: some View {
       
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Bakgrund1"), Color("Bakgrund2")]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea(.all)
                
                ScrollView {
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("First number:")
                                .foregroundStyle(Color("Text"))
                            .fontWeight(.bold)
                            TextField("Enter the first number", text: $input1)
                                .keyboardType(.decimalPad)
                                .focused($isInputFocused)
                                .padding()
                                .background(Color("TextField"))
                                .foregroundStyle(Color("Text"))
                                .font(.headline)
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading) {
                            Text("Second number:")
                                .foregroundStyle(Color("Text"))
                            .fontWeight(.bold)
                            TextField("Enter the second number", text: $input2)
                                .keyboardType(.decimalPad)
                                .focused($isInputFocused)
                                .padding()
                                .background(Color("TextField"))
                                .foregroundStyle(Color("Text"))
                                .font(.headline)
                                .cornerRadius(10)
                        }
                        
                    Spacer()
                        VStack(alignment: .leading) {
                            Text("Select desired calculation method:")
                                .foregroundStyle(Color("Text"))
                                .fontWeight(.bold)
                            Picker("Select calculation", selection: $selectedCalculation) {
                                Text("+").tag(CalculationType.addition)
                                Text("-").tag(CalculationType.subtraction)
                                Text("x").tag(CalculationType.multiplication)
                                Text("÷").tag(CalculationType.division)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                       
                      Spacer()
                        
                        Button(action: {
                            self.calculate()
                            isInputFocused = false
                            }, label: {
                                Text("Calculate")
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.bold)
                            })
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("BeraknaKnapp"))
                            .clipShape(Capsule())
                            .padding(.bottom)
                        
                        Text(resultString)
                                .padding()
                                .padding(.bottom, 20)
                                .padding(.top, 10)
                                .frame(maxWidth: .infinity)
                                .background(Color("ResultatBakgrund"))
                                .foregroundStyle(resultString == "Result" ? .black.opacity(0.4) : .white)
                                .font(.headline)
                                .cornerRadius(10)
                                .padding(.bottom, 50)
                        
                       

                        Button(action: {
                                resultString = "Result"
                            }, label: {
                                Text("Reset")
                                    .foregroundStyle(Color.white)
                            })
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("AterstallKnapp"))
                            .clipShape(Capsule())
                        
                     Spacer()
                        
                    } //Slut VStack
                    .padding()
                    .padding(.horizontal)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Four calculations".uppercased()).bold()
                                .padding().foregroundStyle(colorScheme == .light ? Color.black : Color.white)
                        }
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Wrong"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }//Slut scrollview
            }// Slut på ZStack
        
    } // Slut på body
    
func calculate() {
    guard let number1 = Double(input1), let number2 = Double(input2) else {
        alertMessage = "Invalid input"
        showingAlert = true
            return
        }
        let calculationString = "\(input1) \(symbolForCalculationType(selectedCalculation)) \(input2) = "

            switch selectedCalculation {
            case .addition:
                result = number1 + number2
            case .subtraction:
                result = number1 - number2
            case .multiplication:
                result = number1 * number2
            case .division:
                if number2 != 0 {
                    result = number1 / number2
                } else {
                    result = nil
                    alertMessage = "Division by 0 is not allowed"
                    showingAlert = true
                    //errorMessage = "Division med noll är inte tillåten"
                    //resultString = "Division med noll är inte tillåten"
                    return
                }
            }

        
        if let result = result {
            let formattedResult = formatResult(result)
            resultString = calculationString + formattedResult
        }
        // Rensa textfälten
        input1 = ""
        input2 = ""
        } // Slut func

func symbolForCalculationType(_ type: CalculationType) -> String {
        switch type {
        case .addition: return "+"
        case .subtraction: return "-"
        case .multiplication: return "*"
        case .division: return "/"
        }
    }
    // Antingen visas som heltal eller decimaltal
    func formatResult(_ result: Double) -> String {
        return result.truncatingRemainder(dividingBy: 1) == 0 ?
        String(format: "%.0f", result) : String(result)
    }
    private func performCalculation(_ number1: Double, _ number2: Double) {
        switch selectedCalculation {
        case .addition:
            result = number1 + number2
        case .subtraction:
            result = number1 - number2
        case .multiplication:
            result = number1 * number2
        case .division:
            result = number1 / number2
        }
    } // Slut func
    func displayResult() -> String {
        guard let result = result else { return "Result" }
        return result.truncatingRemainder(dividingBy: 1) == 0 ?
        String(format: "%.0f", result) : //Visa som heltal om det inte finns decimaler
        String(result) // Visa som decimaltal annars
    }
    
    
}

#Preview {
    FyraUtrakningarView()
}
