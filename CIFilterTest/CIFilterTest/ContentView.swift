//
//  ContentView.swift
//  CIFilterTest
//
//  Created by Глеб Михновец on 25.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            ZStack {
                Rectangle().foregroundColor(.black)
                MyView()
            }.ignoresSafeArea(.all)
    }
}

struct FilteredView: View {
    var body: some View{
        //Image(systemName: "gamecontroller").resizable().aspectRatio(contentMode: .fit).foregroundColor(.red).frame(width: 100, height: 100)
            List {
                ForEach(0..<50) {
                    i in
                    ZStack {
                        HStack{
                            Spacer()
                            Text("BRUTALISM").font(.custom("DIN Condensed", fixedSize: 350)).foregroundColor(.white)
                            Spacer()
                        }
                    }
                }.listRowBackground(Color.black)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class MyView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let view = NSHostingView(rootView: FilteredView())
        let layer = view.layer!
//        let filter = CIFilter(name:"CIGaussianBlur", parameters: ["inputRadius" : 1.0])!
        let filter = CIFilter(name:"CIBumpDistortion", parameters: ["inputRadius" : 1000.0, "inputCenter" : CIVector(x: 400, y: 200)])!
        layer.filters = [filter]
        view.layer = layer
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
    }
}
