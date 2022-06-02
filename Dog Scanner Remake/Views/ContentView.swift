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
					.confirmationDialog("Select Photo", isPresented: $showSheet) {
						Button("Photo Library") {
							showImagePicker = true
							sourceType = .photoLibrary
						}
						Button("Camera") {
							showImagePicker = true
							sourceType = .camera
						}
					} message: {
						Text("Choose")
					}
					.font(.system(size: 21))
					.foregroundColor(Color(uiColor: .systemBlue))
				
				
				NavigationLink(destination: ResultView(image: $image)) {
					ZStack{
						RoundedRectangle(cornerRadius: 12)
							.foregroundColor(Color(uiColor: .systemMint))
						Text("Classify")
							.foregroundColor(.white)
							.font(.system(size: 21))
					}
					.frame(width: 350, height: 40.0)
					
				}
				
				Spacer().frame(height: 100)
			}
			.navigationBarTitle("Dog Scanner")
		}
		.fullScreenCover(isPresented: $showImagePicker) {
			ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
				.environmentObject(dogStore)
				.ignoresSafeArea(.container, edges: .vertical)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
