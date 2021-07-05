//
//  DetailView.swift
//  Bookworm
//
//  Created by KhoiLe on 05/07/2021.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteArlet = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    //show image from Files
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)
                    
                    //Book's genre
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Spacer()
            }
        }
        .navigationBarTitle(Text(self.book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteArlet.toggle()
        }){
            Image(systemName: "trash")
        })
        .alert(isPresented: $showingDeleteArlet) {
            Alert(title: Text("Delete book"), message: Text("Are you sure"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBook()
            }, secondaryButton: .cancel())
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        //create d test value to pass in
        let book = Book(context: moc)
        book.title = "Text book"
        book.author = "KhoiLe"
        book.genre = "mystery"
        book.rating = 4
        book.review = "I have read this book"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
