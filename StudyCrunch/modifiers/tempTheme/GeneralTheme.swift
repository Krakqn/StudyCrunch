//
//  GeneralTheme.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/24/23.
//

import Foundation

struct GeneralTheme: Codable, Hashable {
  var navPanelBG: ThemeForegroundBG
  var tabBarBG: ThemeForegroundBG
  var floatingPanelsBG: ThemeForegroundBG
  var modalsBG: ThemeForegroundBG
  var accentColor: ColorSchemes<ThemeColor>
}

