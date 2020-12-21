

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
  
  @Binding var image: UIImage?
  @Binding var isShown: Bool
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image)
  }
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<ImagePicker>) {
    
  }
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    
    init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
      _isShown = isShown
      _image = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      isShown.toggle()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      isShown.toggle()
    }
  }
}
