//
//  ContentView.swift
//  NavIssueDemo
//
//  Created by Amy Worrall on 14/01/2024.
//

import SwiftUI

struct ContentView: View {
  @State var navigationModel = NavigationModel()
  @Environment(\.horizontalSizeClass) var horizontalSizeClass

  var body: some View {
    mainViewForCurrentNavMode
      .environment(navigationModel)
      .onChange(of: horizontalSizeClass, initial: true, { oldValue, newValue in
#if os(macOS)
        // horizontal size class seems to be nil initially on macos.
        let defaultVal = UserInterfaceSizeClass.regular
#else
        let defaultVal = UserInterfaceSizeClass.compact
#endif
        navigationModel.updateWithSizeClass(newValue ?? defaultVal)
      })
  }

  @ViewBuilder
  var mainViewForCurrentNavMode: some View {
    switch navigationModel.navigationMode {
    case .tabs:
      bodyTabs
    case .sidebar:
      bodySidebar
    }
  }

  @ViewBuilder
  var bodyTabs: some View {
    TabView(selection: $navigationModel.selectedTopLevelContainer) {
      ForEach(navigationModel.topLevel) { level in
        topLevelNavStackFor(level)
      }
    }
  }

  @ViewBuilder
  var bodySidebar: some View {
    NavigationSplitView {
      bodySidebarList
    } detail: {
      topLevelNavStackFor(navigationModel.selectedTopLevelContainer)
    }
  }

  @ViewBuilder
  var bodySidebarList: some View {
    List(navigationModel.topLevel, id: \.self, selection: $navigationModel.selectedTopLevelContainer) { level in
      Text(titleFor(level))
    }
  }
}
