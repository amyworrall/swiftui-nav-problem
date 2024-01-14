/* Deluge, (c) 2023 Double & Thrice Ltd */

import Foundation
import SwiftUI

@Observable class NavigationModel {
  
  enum Mode: Codable {
    case tabs
    case sidebar
  }
  
  enum TopLevelContainer: Int, Codable, Identifiable {
    var id: RawValue { rawValue }
    
    case home
    case today
    case inbox
    case review
    case everything
  }
  
  struct ScreenWithID: Codable, Hashable {
    let screen: Screen
    let id: UUID
  }

  enum Screen: Codable, Hashable {
    case home
    case today(day: DateComponents?)
    case inbox
    case review
    case everything // TODO: should the filter state go in here?
    case project(id: UUID)
    case area(id: UUID)
    case editProject(id: UUID)
    case editArea(id: UUID)
    case editTask(id: UUID)
    case newInboxItem
    case newTask
    case newProject
    case newArea
    case processInboxItem(id: UUID)
    case devColors
    case devAllProjects
    case devAllAreas
    case devAllTasks
    case settings
  }

  func updateWithSizeClass(_ sizeClass: SwiftUI.UserInterfaceSizeClass) {
    self.navigationMode = switch sizeClass {
    case .regular:
      .sidebar
    case .compact:
      .tabs
    @unknown default:
      .tabs
    }
  }

  // The actual navigation state
  var navigationMode: Mode = .tabs {
    didSet {
      print("Set mode to \(navigationMode)")
      // TODO: calculate equivalent place in the view hierarchy here
    }
  }

  var topLevel: [TopLevelContainer] = [.home, .today]
  var selectedTopLevelContainer: TopLevelContainer = .home
  var paths: [TopLevelContainer : NavigationPath] = [.home: NavigationPath(), .today: NavigationPath()]
  
  func navigateTo(_ screen: Screen) {
    let screenWithID = ScreenWithID(screen: screen, id: UUID())
    paths[selectedTopLevelContainer]?.append(screenWithID)
  }
}
