//
//  TLRootA.swift
//  NavIssueDemo
//
//  Created by Amy Worrall on 14/01/2024.
//

import SwiftUI

struct TLRootA: View {
  @Environment(NavigationModel.self) var navigationModel

  var body: some View {
    VStack {
      Text("This is view A!")
      NavButton(.newArea) {
        Text("Go on, navigate!")
      }
      Divider()
      Text("""
To demonstrate the problem:

1. In this tab, press the "Go on, navigate!" button.
2. Switch to the Today tab
3. Switch back to the Home tab

Expected result:
Home tab remembers its navigation path, and thus "This is NewArea view" is on the screen.

Actual result:
Home tab forgets its navigation path, and thus "This is view A!" is on the screen.

Notes:
This issue is somehow related to List with a selection binding. Somehow during the process of switching tabs, the NavigationPath for the Home top level item is being reset back to a blank navigation path. If I use a list without selection, this bug does not happen.
""")
    }
  }
}

#Preview {
  TLRootA()
}
