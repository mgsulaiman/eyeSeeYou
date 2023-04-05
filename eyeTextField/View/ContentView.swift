//
//  ContentView.swift
//  eyeTextField
//
//  Created by mgsulaiman on 04/04/2023.
//

import SwiftUI

private enum Field {
    case secure, plain
}
struct ContentView: View {
    @State private var toggle = true
    @State private var isEyeWatching = false
    @State private var userName = ""
    @State private var password = ""
    @State private var showPassword: Bool = false
    @FocusState private var inFocus: Field?
    var body: some View {
            ZStack {
                (isEyeWatching ? Color(Constants.Colors.theme) : Color.green)
                    .ignoresSafeArea(.all)
                        Triangle()
                            .fill(.yellow)
                            .frame(width: 220, height: 400)
                            .rotationEffect(Angle(degrees: 90))
                            .position(x: 135, y: 235)
                            .opacity(isEyeWatching ? 1 : 0)
                VStack {
                    Text("Login Screen")
                        .font(.largeTitle)
                                    TextField("Enter User Name", text: $userName)
                                        .padding(.leading, 10)
                                        .frame(height: 70)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
                                        )
                                        .padding([.horizontal, .top], 20)
                                        .padding(.bottom, 10)
                                        .cornerRadius(20)
                                    HStack(spacing: 0) {
                                        VStack {
                                            if showPassword {
                                                TextField("Enter Password", text: $password)
                                                    .focused($inFocus, equals: .plain)
                                            } else {
                                                SecureField("Enter Password", text: $password)
                                                    .focused($inFocus, equals: .secure)
                                            }
                                        }
                                        .foregroundColor(Color.black)
                                        .padding(.horizontal, 10)
                                        .onChange(of: isEyeWatching, perform: { newValue in
                                            showPassword = newValue
                                            inFocus = showPassword ? .plain : .secure
                                        })
                                        EyeView(isEyeWatching: $isEyeWatching, toggle: $toggle)
                                            .onChange(of: isEyeWatching, perform: { newValue in
                                                showPassword = newValue
                                                inFocus = showPassword ? .plain : .secure
                                            })
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
                                            .frame(height: 70)
                                    )
                                    .padding(.horizontal, 20)
                                    Button(action: {
                                    }) {
                                        Text("Login")
                                            .fontWeight(.semibold)
                                            .font(.title)
                                            .frame(minWidth: 0, maxWidth: 200)
                                            .padding()
                                            .foregroundColor(.white)
                                            .background(isEyeWatching ? Color.green : Color.teal)
                                            .animation(.easeInOut(duration: 0.5), value: isEyeWatching)
                                            .cornerRadius(40)
                                            .shadow(radius: 5)
                                    }
                            Spacer()
                    }
                }
        .preferredColorScheme(isEyeWatching ? .dark : .light)
        .ignoresSafeArea(.keyboard)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
