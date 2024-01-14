/* Deluge, (c) 2023 Double & Thrice Ltd */

import SwiftUI

@ViewBuilder
func topLevelNavStackFor(_ screen: NavigationModel.TopLevelContainer) -> some View {
  DelugeNavigationStackWrapper(topLevelContainer: screen)
}

struct DelugeNavigationStackWrapper: View {
  let topLevelContainer: NavigationModel.TopLevelContainer
  @Environment(NavigationModel.self) var navigationModel

  init(topLevelContainer: NavigationModel.TopLevelContainer) {
    self.topLevelContainer = topLevelContainer
  }
  
  private var pathBinding : Binding<NavigationPath> {
    Binding {
      navigationModel.paths[topLevelContainer] ?? NavigationPath()
    } set: {
      navigationModel.paths[topLevelContainer] = $0
    }
  }
  
  var body: some View {
    NavigationStack(path: pathBinding) {
      topLevelRootViewFor(topLevelContainer)
        .withNavigationDestinations()
        .navigationTitle(titleFor(topLevelContainer))
    }
    .tag(topLevelContainer)
    .tabItem {
      Label(titleFor(topLevelContainer), systemImage: imageFor(topLevelContainer))
    }
  }
}

@ViewBuilder
private func topLevelRootViewFor(_ screen: NavigationModel.TopLevelContainer) -> some View {
  switch screen {
  case .home:
    TLRootA()
  case .today:
    TLRootB()
  case .inbox:
    Text("Hello, World!")
  case .review:
    Text("Hello, World!")
  case .everything:
    Text("Hello, World!")
  }
}

func titleFor(_ screen: NavigationModel.TopLevelContainer) -> String {
  switch screen {
  case .home:
    "Home"
  case .today:
    "Today"
  case .inbox:
    "Inbox"
  case .review:
    "Review"
  case .everything:
    "Everything"
  }
}

private func imageFor(_ screen: NavigationModel.TopLevelContainer) -> String {
  switch screen {
  case .home:
    "house.fill"
  case .today:
    "calendar.badge.clock"
  case .inbox:
    "archivebox.fill"
  case .review:
    "person.badge.clock.fill"
  case .everything:
    "folder.fill"
  }
}

struct NavigationDestinationApplier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .navigationDestination(for: NavigationModel.ScreenWithID.self) { screenWithID in
        screenViewFor(screenWithID.screen)
      }
  }
  
  @ViewBuilder
  private func screenViewFor(_ screen: NavigationModel.Screen) -> some View {
    switch screen {
    case .home:
      TLRootA()
    case .today(day: _):
      TLRootB()
    case .newArea:
      NewArea()
    default:
      Text("View has not been defined")
    }
  }

}

extension View {
  func withNavigationDestinations() -> some View {
    modifier(NavigationDestinationApplier())
  }
}
