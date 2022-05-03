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
				ViewToFilter()
					.applyFilter(CIFilter(name:"CIBumpDistortion", parameters: ["inputRadius" : 1000.0, "inputCenter" : CIVector(x: 400, y: 200)])!)
            }.ignoresSafeArea(.all)
    }
}

struct ViewToFilter: View {
    var body: some View{
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

extension View {
	func applyFilter(_ filter: CIFilter) -> some View {
		FilterThroughNSViewRepresentable(viewToFilter: AnyView(self), filterToApply: filter)
	}
}

struct FilterThroughNSViewRepresentable: NSViewRepresentable {
	var viewToFilter: AnyView
	var filter: CIFilter
	
	init(viewToFilter: AnyView, filterToApply: CIFilter) {
		self.viewToFilter = viewToFilter
		self.filter = filterToApply
	}
	
    func makeNSView(context: Context) -> NSView {
        let view = NSHostingView(rootView: viewToFilter)
        let layer = view.layer!
        layer.filters = [filter]
        view.layer = layer
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
    }
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
