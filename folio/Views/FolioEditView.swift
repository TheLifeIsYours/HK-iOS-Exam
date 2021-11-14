//
//  FolioDetailsView.swift
//  folio
//
//  Created by Mats Daniel Larsen on 02/11/2021.
//

import SwiftUI
import CachedAsyncImage

struct FolioEditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @State var folio: Folio
    
    @State var firstName: String
    @State var lastName: String
    @State var phone: String
    @State var email: String
    @State var city: String
    @State var state: String
    @State var date: Date
    
    init(folio: Folio) {
        _folio = State(wrappedValue: folio)
        
        _firstName = State(wrappedValue: folio.firstName)
        _lastName = State(wrappedValue: folio.lastName)
        _phone = State(wrappedValue: folio.phone)
        _email = State(wrappedValue: folio.email)
        _city = State(wrappedValue: folio.city)
        _state = State(wrappedValue: folio.state)
        _date = State(wrappedValue: folio.date)
    }
    
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            PurpleGradient
            
            VStack{
                VStack {
                    CachedAsyncImage(url: URL(string: folio.pictureLarge)) {image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 200, maxHeight: 200)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
                            )
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                HStack {
                    Image(systemName: "person").scaleEffect(1.25)
                    TextField("First name", text: $firstName)
                    TextField("Last name", text: $lastName)
                    Spacer()
                }.padding(.top)
                
                HStack {
                    Image(systemName: "phone").scaleEffect(1.25)
                    TextField("Phone number", text: $phone)
                        .keyboardType(.phonePad)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textFieldStyle(DefaultTextFieldStyle())
                }.padding(.top)
                
                HStack {
                    Image(systemName: "envelope").scaleEffect(1.25)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                    Spacer()
                }.padding(.top)
                
                HStack {
                    Image(systemName: "map").scaleEffect(1.25)
                    TextField("City", text: $city)
                    TextField("State", text: $state)
                    Spacer()
                    
                    Image(systemName: "location.magnifyingglass").opacity(0.6)
                }.padding(.top)
                
                HStack {
                    Image(systemName: "calendar").scaleEffect(1.25)
                    DatePicker("dob", selection: $date, displayedComponents: [.date])
                    Spacer()
                    
                    HStack {
                        Text("🎂").scaleEffect(1.25)
                        Text("Age \(folio.age)")
                    }
                    Spacer()
                }.padding(.top)
                
                Spacer()
                
                HStack {
                    //Save changes
                    Button(action: {
                        self.folio.firstName = firstName
                        self.folio.lastName = lastName
                        self.folio.phone = phone
                        self.folio.email = email
                        self.folio.city = city
                        self.folio.state = state
                        self.folio.date = date
                        self.folio.age = Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
                        self.folio.edited = true
                        
                        try? self.moc.save()
                        
                        dismiss()
                    }) {
                        HStack {
                            Text("Save")
                            Image(systemName: "person.fill.checkmark")
                                .font(Font.title.weight(.light))
                                .scaleEffect(0.7)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Blur(style: .systemUltraThinMaterial))
                        .cornerRadius(10)
                    }
                    
                    
                    //Delete Folio
                    Button(action: {
                        showingAlert = true
                    }) {
                        
                        HStack {
                            Text("Delete")
                            Image(systemName: "trash")
                                .font(Font.title.weight(.light))
                                .scaleEffect(0.7)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Blur(style: .systemUltraThinMaterial))
                        .cornerRadius(10)
                    }.alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Are you sure you want to delete this?"),
                            message: Text("There is no undo"),
                            primaryButton: .destructive(Text("Delete")) {
                                self.folio.removed = true
                                
                                try? self.moc.save()
                                
                                print("Deleting...")
                                dismiss()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .padding()
            .background(Blur(style: .systemUltraThinMaterial))
            .cornerRadius(10)
            .padding()
            .foregroundColor(.white)
        }
        .navigationTitle("Editing")
    }
}
