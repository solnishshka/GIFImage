//
//  SwiftUIView.swift
//  
//
//  Created by Igor Ferreira on 25/04/2022.
//

import SwiftUI
import GIFImage

struct ListItem: Identifiable {
    let id: UUID
    let source: GIFSource

    init(_ source: GIFSource) {
        self.id = UUID()
        self.source = source
    }
}

struct ContentView: View {

    @State var items = [
        ListItem(.remote(url: URL(string: "https://raw.githubusercontent.com/igorcferreira/GIFImage/main/Tests/test.gif")!)),
        ListItem(.local(filePath: Bundle.main.path(forResource: "test", ofType: "gif")!))
    ]
    @State var placeholder = UIImage(systemName: "photo.circle.fill")!
    @State var error: UIImage?
    @State var animate: Bool = true
    @State var loop: Bool = true

    var body: some View {
        
        VStack {
            Toggle("Animate", isOn: $animate).padding([.leading, .trailing])
            Toggle("Loop", isOn: $loop).padding([.leading, .trailing])
            List(items) { item in
                GIFImage(
                    source: item.source,
                    animate: $animate,
                    loop: $loop,
                    placeholder: placeholder,
                    errorImage: error,
                    frameRate: .dynamic,
                    loopAction: loopAction(source:)
                ).frame(width: 310.0, height: 175.0, alignment: .center)
            }
        }
    }
    
    @MainActor
    @Sendable private func loopAction(source: GIFSource) async {
        print("Loop for source: \(source)")
    }
}
