/* Deluge, (c) 2023 Double & Thrice Ltd */

import SwiftUI
import SwiftData


struct NavButton<Content: View>: View {
    
  @Environment(NavigationModel.self) var navigationModel
  let destination: NavigationModel.Screen
  @ViewBuilder var content: () -> Content
  
  init(_ destination: NavigationModel.Screen, content: @escaping () -> Content) {
    self.destination = destination
    self.content = content
  }
  
  var body: some View {
    Button(action: {
      navigationModel.navigateTo(destination)
    }) {
        content()
    }
  }
}

#Preview {
  List{
    NavButton(.home) {
      Text("Hello")
    }
  }
  .environment(NavigationModel())
}
