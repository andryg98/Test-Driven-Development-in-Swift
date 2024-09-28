//
//  MenuRow.swift
//  Albertos
//
//  Created by Andrea Garau on 27/09/24.
//

import SwiftUI

struct MenuRow: View {
    let viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.text)
    }
}
