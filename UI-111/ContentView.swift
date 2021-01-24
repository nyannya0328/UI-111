//
//  ContentView.swift
//  UI-111
//
//  Created by にゃんにゃん丸 on 2021/01/24.
//

import SwiftUI

let ang = AngularGradient(gradient: .init(colors: [.yellow,.blue]), center: .bottomTrailing)

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var text = ""
    @State var heigth : CGFloat = 0
    @State var keyboardheigth : CGFloat = 0
    var body: some View{
        
        VStack(spacing:0){
            
            HStack{
                
                Text("Chat")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                   
                
                Spacer()
                
            }
            .background(Color.white)
            .padding()
            .padding(.horizontal)
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                Text("Git hub")
            })
                HStack{
                    
                    ResizabelTF(text: $text, heigth: $heigth)
                        .frame(height: heigth < 150 ? heigth : 150)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray,lineWidth: 2))
                    
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(10)
                    })
                    .background(ang)
                    .clipShape(Circle())
                    
                    
                }
                .padding(.horizontal)
                
            
            
            
                
            
            
        }
        .padding(.bottom,keyboardheigth)
        .background(Color.gray.opacity(0.03).ignoresSafeArea(.all, edges: .bottom))
        .onTapGesture {
            UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
        }
        .onAppear{
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { (data) in
                let heigth1 = data.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
                
                self.keyboardheigth = heigth1.cgRectValue.height / 3
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { (_) in
              
                
                self.keyboardheigth = 0
            }
            
            
            
        }
        
        
    }
}

struct ResizabelTF : UIViewRepresentable {
    
    @Binding var text : String
    @Binding var heigth : CGFloat
    func makeCoordinator() -> Coordinator {
        return ResizabelTF.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        
        let view = UITextView()
        view.isScrollEnabled = true
        view.font = .systemFont(ofSize: 20)
        view.textColor = .black
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        return view
        
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
        DispatchQueue.main.async {
            self.heigth = uiView.contentSize.height
        }
        
    }
    
    class Coordinator: NSObject,UITextViewDelegate {
        let parent : ResizabelTF
        
        init(parent : ResizabelTF) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.text == ""{
                
                textView.text = ""
                textView.textColor = .black
                
                
                
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if self.parent.text == ""{
                
                textView.text = "Enter Your Message"
                textView.textColor = .gray
                
                
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.heigth = textView.contentSize.height
                self.parent.text = textView.text
            }
        }
        
    }
}
