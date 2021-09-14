//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Andres Marquez on 2021-09-07.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @ObservedObject var favorites = Favorites()
    
    @State private var filterCriteria = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Filter:", text: $filterCriteria)
                    }
                    .foregroundColor(.gray)
                    .padding(.leading, 13)
                }
                .frame(height: 25)
                .cornerRadius(13)
                .padding()
                
                List {
                    ForEach(searchResults, id: \.self) { resort in
                        NavigationLink(destination: ResortView(resort: resort)) {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundColor(.secondary)
                            }
                            .layoutPriority(1)
                            
                            if self.favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .accessibility(label: Text("This is a favorite resort"))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Resorts")
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
    
    var searchResults: [Resort] {
        if filterCriteria.isEmpty {
            return resorts
        } else {
            var output: [Resort] = []
            
            for resort in resorts {
                if resort.name.contains(filterCriteria) {
                    output.append(resort)
                }
            }
            return output
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
