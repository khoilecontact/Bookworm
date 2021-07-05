//
//  AddBookView.swift
//  Bookworm
//
//  Created by KhoiLe on 03/07/2021.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    //we dont have to declare id because it has been generated automatically
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var rating = 3
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    
    var body: some View {
        NavigationView {
            Form {
                //input book's data
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                //rating
                Section {
                    //attach rating view
                    RatingView(rating: $rating)
                    
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        //using CORE DATA to save data
                            //call core data
                            let newBook = Book(context: self.moc)
                            //assign value for data
                            newBook.title = self.title
                            newBook.author = self.author
                            newBook.genre = self.genre
                            newBook.rating = Int16(self.rating)
                            newBook.review = self.review
                        
                            //save data to core data
                            try? self.moc.save()
                        
                        //dismiss the sheet after saving 
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
