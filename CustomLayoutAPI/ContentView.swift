//
//  ContentView.swift
//  CustomLayoutAPI
//
//  Created by harsh  on 17/03/25.
//

import SwiftUI

let hashtags: [String] = ["IOS 14", "SwiftUI", "macOS", "watchOS", "tvOS", "Xcode", "AppKit", "Cocoa", "Python", "IOS", "C++", "Objective-C", "Go", "R", "SQL", "DBMS"]


struct ContentView: View {
	var body: some View {
		NavigationStack {
			VStack {
				HashTagsView(tags: hashtags) { tag, isSelected in
					TagView(tag, isSelected: isSelected)
				} didChangeSelection: { selection in
					print(selection)
				}
				.padding(10)
				.background(.gray.opacity(0.1), in: .rect(cornerRadius: 20))
			}
			.padding(15)
			.navigationTitle(Text("HashTags"))
		}
	}
}

	/// View for the collection of tags.
	/// Controls the size and design of the whole collection of tags.
struct HashTagsView<Content: View, Tag: Equatable>: View where Tag: Hashable {
	var spacing: CGFloat = 10
	var tags: [Tag]
	
	@ViewBuilder var content: (Tag, Bool) -> Content
	var didChangeSelection: ([Tag]) -> ()
	
	@State private var selectedTags: [Tag] = []
	
	var body: some View {
		VStack {
			ForEach(tags, id: \.self) { tag in
				content(tag, selectedTags.contains(tag))
					.contentShape(.rect)
					.onTapGesture {
						withAnimation {
							if selectedTags.contains(tag) {
								selectedTags.removeAll { $0 == tag }
							} else {
								selectedTags.append(tag)
							}
						}
						didChangeSelection(selectedTags)
					}
			}
		}
	}
}

	/// View for each tag.
	/// Controls how each tag is designed.
@ViewBuilder
func TagView(_ tag: String, isSelected: Bool) -> some View {
	HStack(spacing: 10) {
		Text("#" + tag)
			.font(.callout)
			.foregroundStyle(isSelected ? .white : Color.primary)
		
	}
}

	
	
#Preview {
    ContentView()
}
