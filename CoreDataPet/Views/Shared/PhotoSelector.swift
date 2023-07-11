//
//  PhotoPicker.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 10/07/23.
//

import SwiftUI
import PhotosUI

struct PhotoSelector: View {
    
    @State var selectedItems: [PhotosPickerItem] = []
    @Binding var imageData: Data?
    
    var body: some View {
        VStack {
            if let imageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 64, height: 64)
                    .clipped()
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            }
            
            PhotosPicker(
                selection: $selectedItems,
                maxSelectionCount: 1,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Escolher foto")
                }
                .onChange(of: selectedItems) { newItem in
                    guard let item = selectedItems.first else {
                        return
                    }
                    item.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data = data {
                                DispatchQueue.main.async {
                                    imageData = data
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
        }
    }
}

//struct PhotoSelector_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoSelector()
//    }
//}
