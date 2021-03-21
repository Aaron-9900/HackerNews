//
//  VirtualList.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 13/03/2021.
//

import SwiftUI

struct VirtualList<ItemView, Item, SpinnerView>: View where ItemView: View, Item: Identifiable, SpinnerView: View {
    let view: (Item, Int) -> ItemView
    let onItemAppear: () -> Void
    let items: [Item]
    let spinner: () -> SpinnerView
    init(items: [Item], view: @escaping (Item, Int) -> ItemView, callback: @escaping () -> Void, spinner: @escaping () -> SpinnerView) {
        self.items = items
        self.view = view
        self.onItemAppear = callback
        self.spinner = spinner
    }
    var body: some View {
        LazyVStack {
            ForEach(Array(items.enumerated()), id: \.0) { (index, item) in
                view(item, index)
            }
            self.onAppear()
        }
    }
    private func onAppear() -> some View {
        HStack {
            Text("")
                .onAppear {
                    onItemAppear()
                }
            self.spinner()
        }
    }
}
