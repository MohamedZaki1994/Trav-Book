//
//  UploadPost.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 10/8/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import SwiftUI

struct UploadPost: View {
    @State var postText: String = ""
    @State var isPresented = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var numberOfImages = 0
    @EnvironmentObject var model: DashboardViewModel

    var body: some View {
        VStack {
            Text("write a text").foregroundColor(Color.gray).onTapGesture {
                self.isPresented = true
            }.sheet(isPresented: $isPresented, onDismiss: nil, content: {
                TextField("What's on your mind", text: self.$postText).padding(.top, 30).padding(.leading, 30)
                image?.resizable().frame(width: 300, height: 200)
                HStack(spacing: 20) {
                Button("Post") {
                    let name = CurrentUser.shared.name
                    self.model.postDummy(name: name ?? "", text: self.postText, numberOfImages: numberOfImages)
                    self.isPresented = false
                    self.postText = ""
                }
                    Button {
                        print("uploading")
                        self.showingImagePicker = true
                    } label: {
                        Text("upload a photo")
                    }

                    Button {
                        print("take")
                    } label: {
                        Text("take a photo")
                    }

            }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
                Spacer()
            })
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        numberOfImages += 1
        image = Image(uiImage: inputImage)
    }
}

struct UploadPost_Previews: PreviewProvider {
    static var previews: some View {
        UploadPost()
    }
}

// Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

