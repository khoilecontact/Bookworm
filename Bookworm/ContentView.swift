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
    //FectchRequest to pull object out of core data
    @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true), NSSortDescriptor(keyPath: \Book.author, ascending: true)]) var books: FetchedResults<Book>
    
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
                .onDelete(perform: deleteBooks)
            }
                .navigationBarTitle("Bookworm")
                .navigationBarItems(leading: EditButton(),trailing: Button(action:  {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus") 
                })
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
                }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            //find the book in our fetch request
            let book = books[offset]
            
            //delete it from the context
            moc.delete(book)
        }
        
        try? moc.save()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
