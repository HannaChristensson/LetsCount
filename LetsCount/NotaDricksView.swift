//       LetsCount
//  NotaDricksView.swift
//  Created by Hanna Christensson on 2024-01-27.


import SwiftUI

struct NotaDricksView: View {
 @Environment(\.colorScheme) var colorScheme // Detektera nuvarande färgschema
    //LIGHT MODE

    var resultLight = #colorLiteral(red: 0.8941176471, green: 0.3843137255, blue: 0.7215686275, alpha: 1)  //Resultat bakgrund
    var resultDark = #colorLiteral(red: 0.3254901961, green: 0.1921568627, blue: 0.2784313725, alpha: 1) // Resultat bakgrund

    
    @FocusState private var isInputFocused: Bool  //Håller koll på tangentbordets fokus.
    
    @State private var showingAlert = false
    @State private var alertMessage: String = ""
    
    let step = 1
    let range = 1...20
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = "."
        return formatter
    }()
    // Variabler för beräkning
    @State var nota: String = ""
    @State var valdDricksProcent: Int = 0
    @State var personerDelarNota:Int = 1
    
    @State var totalPerPerson: Double = 0.0
    @State var totalNota: Double = 0.0  // grand total
    @State var dricks: String = "0.0"
    
    @State private var berakningGjord = false
    
    var body: some View {
        
            ZStack {
                LinearGradient(colors: [Color("Bakgrund1"), Color("Bakgrund2")], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea(.all)
                ScrollView {
              //     GeometryReader { geometry in
                        VStack(alignment: .leading) {
                           Spacer()
                            Text("Bill amount:")
                                .foregroundStyle(Color("Text"))
                                .fontWeight(.bold)
                            
                            TextField("Enter the bill amount", text: $nota)
                                .keyboardType(.decimalPad)
                                .focused($isInputFocused)
                                .padding()
                                .background(Color("TextField"))
                                .foregroundStyle(Color("Text"))
                                .font(.headline)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                Text("Select desired tip percentage:")
                                    .foregroundStyle(Color("Text"))
                                    .fontWeight(.bold)
                          
                                Picker("Tip", selection: $valdDricksProcent) {
                                    Text("0%").tag(0)
                                    Text("5%").tag(5)
                                    Text("10%").tag(10)
                                    Text("15%").tag(15)
                                }
                                .pickerStyle(.segmented)
                            }
                            .padding(.top)
                            .padding(.bottom)
                           
                            VStack(alignment: .leading) {
                                Text("Bill divided by:")
                                     .foregroundColor(Color("Text"))
                                     .fontWeight(.bold)
                                     .underline()
                                 Stepper(value: $personerDelarNota, in: range, step: step) {
                                     
                                     HStack {
                                         Text("Number of people:")
                                         Text("   \(personerDelarNota)  ")
                                             .font(.title2)
                                             .background(Color("TextField"))
                                             
                                     }
                                     .foregroundStyle(Color("Text"))
                                 }
                            }
                            .padding(.top)
                            .padding(.bottom)
                            
                            Button(action: {
                                calculateTip()
                                isInputFocused = false
                            }, label: {
                                Text("Calculate")
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.bold)
                            })
                            .padding(.vertical, 15)
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                            .background(Color("BeraknaKnapp"))
                            .clipShape(Capsule())
                            .padding(.top)
                            .padding(.bottom, 25)
                            
            //Översiktsruta
        VStack(alignment: .leading, spacing: 8) {
         
                        if berakningGjord {
                            HStack {
                                Text("Total bill: ")
                                Text("\(totalNota, specifier: "%.2f")")
                                    .fontWeight(.medium)
                                    
                            }
                            .foregroundStyle(.white)
                            HStack {
                                Text("Cost/person: ")
                                Text("\(totalPerPerson, specifier: "%.2f")")
                                    .fontWeight(.medium)
                                    
                            }
                            .foregroundStyle(.white)
                            HStack {
                                Text("Tip: ")
                                Text("\(dricks)")
                                    .fontWeight(.medium)
                                   
                            }
                            .foregroundStyle(.white)
                        } else {
                            Text("")
                            Text("")
                            Text("")
                
                        }
                    }
                    .padding()
                    .padding(.bottom, 18)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .light ? Color(resultLight) : Color(resultDark))
                    .foregroundStyle(Color("Text"))
                    .cornerRadius(10)
                    .padding(.bottom, 50)
                           
                            
                            Button(action: {
                              resetValues()
                                // optional
                                personerDelarNota = 1
                                valdDricksProcent = 0
                                nota = ""
                            }, label: {
                                Text("Reset")
                                    .foregroundStyle(Color.white)
                            })
                            .padding()
                         //   .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                            .frame(maxWidth: .infinity)
                            .background(Color("AterstallKnapp"))
                            .clipShape(Capsule())
                          
                         Spacer()
                        }//Slut Vstack
                    //    .frame(width: geometry.size.width)
                        .padding()
                        .padding(.horizontal)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("Bill with tip".uppercased()).bold()
                                    .padding().foregroundStyle(colorScheme == .light ? Color.black : Color.white)
                            }
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Please enter a valid amount"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                    //} Slut Geometry
                    
                } //Slut ScrollView
            } //Slut ZStack
       
    }// Slut body
    
    func calculateTip() {
        guard let billAmount = Double(nota)
        else {
            showingAlert = true
            alertMessage = "Only numbers"
            return
        }
        let tipPercentage = Double(valdDricksProcent) / 100.0
        let tipAmount = billAmount * tipPercentage
        let totalBillWithTip = billAmount + tipAmount
        
        totalPerPerson = totalBillWithTip / Double(personerDelarNota)
        totalNota = totalBillWithTip
        dricks = String(format: "%.2f", tipAmount)
        
        berakningGjord = true
    }
    func resetValues() {
        nota = ""
        totalPerPerson = 0.0
        totalNota = 0.0
        dricks = "0.0"
        valdDricksProcent = 0
        personerDelarNota = 1
        
        berakningGjord = false
        print("Användaren har återställt uträkning")
    }
    
    
} //Slut struct-View

#Preview {
    NotaDricksView()
}
