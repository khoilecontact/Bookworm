//
//  ContentView.swift
//  Bookworm
//
//  Created by KhoiLe on 03/07/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknow title")
                                .font(.headline)
                            Text(book.author ?? "Unknow author")
                        }
                    }
                }
            }
                .navigationBarTitle("Bookworm")
                .navigationBarItems(trailing: Button(action:  {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus") 
                })
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
                }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
