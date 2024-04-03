//  LetsCount
//  ContentView.swift
//  Created by Hanna Christensson on 2024-01-27.


import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme // Används för att detektera nuvarande färgschema
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color("Bakgrund1"), Color("Bakgrund2")], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea(.all)
                
                GeometryReader { geometry in
                    VStack(spacing: 20) {
                        Spacer()
                        VStack {
                            Text("Let's Count!")
                                .font(.largeTitle)
                                .bold()
                                .padding(7)

                            Text("An app for different calculations in your life")
                                .fontWeight(.thin)
                              
                        }
                        .padding()
                        
                     Spacer()
                    
                Text("Click on one of the choices below:")
                            .font(.title2)
                       
                        NavigationLink(destination: FyraUtrakningarView()) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("The four methods of calculation")
                                        .font(.headline)
                                        .foregroundStyle(Color("Text"))
                                    Text("Addition, subtraction, multiplication, division")
                                        .font(.subheadline)
                                        .foregroundColor(Color("Text"))
                                }
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("menyVal"))
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                        }
              
                        NavigationLink(destination: NotaDricksView()) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Note with tip")
                                        .font(.headline)
                                        .foregroundStyle(Color("Text"))
                                    Text("Calculate what each person should pay")
                                        .font(.subheadline)
                                        .foregroundStyle(Color("Text"))
                                }
                              Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("menyVal"))
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Image(systemName: "heart")
                                .font(.system(size: 42, weight: .thin))
                                .padding(.top, 80)
                                .padding(.bottom, 64)
                            Image(systemName: "heart")
                                .font(.system(size: 42, weight: .thin))
                                .padding(.top, 80)
                                .padding(.bottom, 64)
                            Image(systemName: "heart")
                                .font(.system(size: 42, weight: .thin))
                                .padding(.top, 80)
                                .padding(.bottom, 64)
                        }
                    }
                    .frame(width: geometry.size.width)
                }
            }
        }
        .accentColor(colorScheme == .light ? .black : .white)
    }
}

#Preview {
    ContentView()
}
