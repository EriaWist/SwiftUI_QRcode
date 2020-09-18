
import SwiftUI
import CoreImage.CIFilterBuiltins
import PlaygroundSupport

struct CheckInView1: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    var body: some View {
        VStack {
            Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            
            
                
            TextField("Name", text: $name)
                .textContentType(.name)
                .font(.title)
                .padding(.horizontal)

            TextField("Email address", text: $emailAddress)
                .textContentType(.emailAddress)
                .font(.title)
                .padding([.horizontal, .bottom])
            

            Spacer()
        }
        .navigationBarTitle("Your code")
        
    }
}
let context = CIContext()
let filter = CIFilter.qrCodeGenerator()
func generateQRCode(from string: String) -> UIImage {
    let data = Data(string.utf8)
    filter.setValue(data, forKey: "inputMessage")

    if let outputImage = filter.outputImage {
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgimg)
        }
    }

    return UIImage(systemName: "xmark.circle") ?? UIImage()
}
PlaygroundPage.current.setLiveView(CheckInView1())
