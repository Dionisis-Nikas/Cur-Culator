//
//  SearchBar.swift
//  Cur-Culator
//
//  Created by Dennis Nikas on 5/10/21.
//

import SwiftUI

struct SearchBar: View {
	@Binding var text: String
	@State var isEditing: Bool = false
	
	var body: some View {
		HStack {
			TextField("Search Currencies", text: $text)
				.padding(7)
				.padding(.horizontal, 25)
				
				.cornerRadius(8)
				.overlay(
					HStack {
						Image(systemName: "magnifyingglass")
							.foregroundColor(.gray)
							.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
							.padding(.leading, 8)
						if isEditing {
							Button(action: {
								self.text = ""
							}) {
								Image(systemName: "multiply.circle.fill")
									.foregroundColor(.gray)
									.padding(.trailing, 8)
							}
						}
					}
				)
				.padding(.horizontal, 10)
				.onTapGesture {
					self.isEditing = true
				}
			if isEditing {
				Button(action: {
					UIApplication.shared.endEditing(true)
					self.isEditing = false
					self.text = ""
				}) {
					Text("Cancel")
				}
				.animation(.default)
			}
		}
	}
}
extension UIApplication {
	func endEditing(_ force: Bool) {
		self.windows
			.filter{$0.isKeyWindow}
			.first?
			.endEditing(force)
	}
}
struct ResignKeyboardOnDragGesture: ViewModifier {
	var gesture = DragGesture().onChanged{_ in
		UIApplication.shared.endEditing(true)
	}
	func body(content: Content) -> some View {
		content.gesture(gesture)
	}
}
extension View {
	func resignKeyboardOnDragGesture() -> some View {
		return modifier(ResignKeyboardOnDragGesture())
	}
}
