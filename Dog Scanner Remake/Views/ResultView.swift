//
//  ResultView.swift
//  Dog Scanner Remake
//
//  Created by Antonio Scognamiglio on 14/12/21.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject var dogStore: DogStore
    @Binding var image: UIImage?
    @State private var classificationLabel: String = ""
    
    let model = StudentDogModel()
    @State var arrayKeys: [String] = ["",""]
    @State var arrayValues: [String] = ["",""]
    
    @State var dogName = "Pomeranian"
    @State var dogBackground = "PomeranianWallpaper"
    @State var dogIcon = "Pomeranian"
    
    
    var body: some View {
        ScrollView(.vertical){
            VStack (alignment: .leading){
                ZStack{
                    Image(uiImage: UIImage(named: dogBackground)!)
                        .resizable()
                        .frame(width: 360, height: 250)
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 9.0))
                    Image(uiImage: UIImage(named: dogIcon)!)
                        .resizable()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle()).overlay(
                            Circle()
                                .stroke(lineWidth: 5)
                                .foregroundColor(.white)
                        )
                        .shadow(radius: 5)
                    //                    .position(x: 90, y: 510)
                        .offset(x: -100, y: 120)
                    Button{
                        //                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    } label: {
                        Text(" \(Image(systemName: "square.and.arrow.up"))    SHARE")
                            .fontWeight(.medium)
                            .font(.system(size: 18))
                    }
                    .padding()
                    .frame(width: 140, height: 40)
                    .foregroundColor(Color.white)
                    .background(Color(uiColor: .systemMint))
                    .clipShape(RoundedRectangle(cornerRadius: 12.0))
                    .offset(x: 90, y: 125)
                    
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 60)
            
            VStack(alignment: .leading, spacing: 10){
                Text(dogName)
                    .fontWeight(.semibold)
                    .font(.system(size: 24))
                    .foregroundColor(Color(uiColor: .systemMint))
                Text("The dog you scanned look \(Text(arrayValues[0]).bold()) like a \(Text(arrayKeys[0].replacingOccurrences(of: "_", with: " ").capitalized).bold())")
                    .font(.system(size: 19))
                Text("Am I right?")
                    .fontWeight(.medium)
                    .italic()
                    .foregroundColor(Color(uiColor: .systemMint))
                    .font(.system(size: 20))
                
                Text("It look like this dog is primarly a \(Text("\(arrayKeys[0].replacingOccurrences(of: "_", with: " ").capitalized) (\(arrayValues[0]))").bold()). Another match is the \(Text("\(arrayKeys[1].replacingOccurrences(of: "_", with: " ").capitalized) (\(arrayValues[1]))").bold()).")
                    .font(.system(size: 19))
                
    
                
            }
            .padding(.horizontal)
            .padding(2)
        }.onAppear(perform: {
            classifyImage()
            checkDog()
        })
            
    }
    
    
    private func classifyImage() {

        guard let currentImage = image,
        
        let resizedImage = currentImage.resizeImageTo(size: CGSize(width: 224, height: 224)),
              let buffer = resizedImage.convertToBuffer() else {
                  return
              }
              
        let output = try? model.prediction(image: buffer)
        // qui è dove tenta di fare la prediction, e lo fa passandogli buffer perché la prediction di questo modello vuole un immagine Pixel Buffer di 224 * 224
        
        if let output = output {
                // 1 questo ordinamento si riferisce alla probabilità, se ho capito bene, $0.1 sarebbe stringa.double che è appunto dove è contenuta la probabilità, la sintassi non mi è chiarissima però è questo quello che fa mette prima la probabilità maggiore
                let results = output.classLabelProbs.sorted { $0.1 > $1.1 }
                // 2 qui stiamo assegnando a result, i valori che stanno nel dizionario, in formato stringa, inoltre abbiamo formattato in modo che la percentuale mostri le prime due cifre decimali e credo che separator metta due daccapo a tutti i result
            

            
            let result = results.map { (key, value) in
                return "\(key) = \(String(format: "%.2f", value * 100))%"
                // restituisce una stringa che viene salvata in result
                }.joined(separator: "\n")
            
            self.arrayKeys = results.map { (key, value) in
                return "\(key)"
                }

            self.arrayValues = results.map { (key, value) in
                return "\(String(format: "%.2f", value * 100))%"
                }
                // 3 quest'ultima cosa serve solo per refreshare l'interfaccia, e mantenere il valore aggiornato, infatti classification label è di tipo @State var, stiamo semplicemente passando il valore da una parte all'altra per forzare il refresh
                self.classificationLabel = result
    
    }
    }
    
    //devo testarla ancora
    private func checkDog () {
        for number in 0...dogStore.dogs.count - 1 {
            print("VALORE IN ARRAY DI CANI          VALORE KEY")
            print ("\(dogStore.dogs[number].name)                   \(arrayKeys[0].capitalized)")
            if dogStore.dogs[number].name.contains(arrayKeys[0]
                                                    .replacingOccurrences(of: "_", with: " ")
                                                    .capitalized){
                self.dogName = dogStore.dogs[number].name
                self.dogBackground = dogStore.dogs[number].wallpaper
                self.dogIcon = dogStore.dogs[number].icon
                break
            }
            else {
                self.dogName = arrayKeys[0].replacingOccurrences(of: "_", with: " ").capitalized
                self.dogBackground = "DogPlaceholderWallpaper"
                self.dogIcon = "DogPlaceholder"
            }
            }
        }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(image: .constant(UIImage(named: "placeholder"))).environmentObject(DogStore())
    }
}
