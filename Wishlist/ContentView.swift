//
//  ContentView.swift
//  Wishlist
//
//  Created by Weerawut Chaiyasomboon on 22/2/2568 BE.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishs: [Wish]
    @State private var showAlert = false
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishs) { wish in
                    Text(wish.title)
                        .font(.title)
                        .fontWeight(.light)
                        .padding(.vertical,2)
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(wish)
                                try! modelContext.save()
                            }
                        }
                }
            }
            .navigationTitle("Wish List")
            .overlay {
                if wishs.isEmpty {
                    ContentUnavailableView("My Wish List", systemImage: "heart.circle", description: Text("No wishs yet. Add one to get started."))
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAlert.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
                
                if !wishs.isEmpty {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(wishs.count) wish\(wishs.count > 1 ? "es" : "")")
                    }
                }
            }
            .alert("Create a new wish", isPresented: $showAlert) {
                TextField("Wish tilte", text: $title)
                
                Button {
                    if !title.isEmpty {
                        modelContext.insert(Wish(title: title))
                        title = ""
                        try! modelContext.save()
                    }
                } label: {
                    Text("Save")
                }

            }
        }
    }
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true) //inMemory means no save to device, just in memory
}

#Preview("List with Sample data") {
    let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    container.mainContext.insert(Wish(title: "Buy iPhone"))
    container.mainContext.insert(Wish(title: "Go to swim"))
    container.mainContext.insert(Wish(title: "Pay electricity bill"))
    container.mainContext.insert(Wish(title: "Jump from the building"))
    container.mainContext.insert(Wish(title: "A walk to remember"))
    
    return ContentView()
        .modelContainer(container)
}
