//
//  ContentView.swift
//  Dog Scanner Remake
//
//  Created by Antonio Scognamiglio on 14/12/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dogStore: DogStore
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    // sono sicuto al 90% che qua dentro viene memorizzata la foto sia se viene scattata sia se viene scelta dal picker
    @State private var image: UIImage?
    
    var body: some View {
        
        NavigationView {
            
            VStack (spacing: 10) {
                
                Image(uiImage: image ?? UIImage(named: "DogPlaceholderWallpaper")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 23.0))
                    .shadow(radius: 10)
                    .overlay(RoundedRectangle(cornerRadius: 23).stroke(Color(uiColor: .systemGray), lineWidth: 0.3))
                
                Button("Choose Picture") {
                    self.showSheet = true
                }.padding()
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                                //adesso credo che qua devo performare l'azione del machine learning e passargli l'immagine che sta qua
                            },
                            .default(Text("Camera")) {
                                self.showImagePicker = true
                                self.sourceType = .camera
                                //adesso credo che qua devo performare l'azione del machine learning e passargli l'immagine che sta qua
                            },
                            .cancel()
                        ])
                }
                    .font(.system(size: 21))
                    .foregroundColor(Color(uiColor: .systemBlue))
//                    per usare il system blue bisgna fare un macello ma ne vale la pena perché si vede tutto lui per la dark mode
                
                NavigationLink(destination: ResultView(image: $image)) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color(uiColor: .systemMint))
                        Text("Classify")
                            .foregroundColor(.white)
                            .font(.system(size: 21))
                    }
                    .frame(width: 350, height: 40.0)
//                Button("Classify") {
//                    classifyImage()
//                }
//                .padding()
//                .frame(width: 140, height: 40)
//                .foregroundColor(Color.white)
//                .background(Color.green)
//                .clipShape(RoundedRectangle(cornerRadius: 12.0))
                }
//                Text(classificationLabel)
//                    .padding()
//                    .font(.body)
                Spacer().frame(height: 100)
            }
            .navigationBarTitle("Dog Scanner")
            
            
            
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                .environmentObject(dogStore)
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
