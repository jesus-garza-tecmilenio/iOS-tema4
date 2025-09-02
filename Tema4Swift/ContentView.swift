//  ContentView.swift
//  Tema4Swift
//
//  Created by JESUS GARZA on 02/09/25.
//

import SwiftUI

struct ContentView: View {
    // Estado para el color de fondo
    @State private var bgColor: Color? = nil // nil = usar color automático
    // Estado para el modo oscuro
    @State private var isDarkMode: Bool = false
    // Estado para el tamaño del texto
    @State private var textSize: Double = 20
    // Estado para el nombre ingresado
    @State private var name: String = ""
    // Estado para el mensaje de gestos
    @State private var gestureMessage: String = ""
    // Estado para saber si el usuario cambió el fondo manualmente
    @State private var isCustomBg: Bool = false
    
    // Colores adaptativos para textos y fondos
    var mainTextColor: Color { isDarkMode ? .white : .black }
    var secondaryTextColor: Color { isDarkMode ? .yellow : .accentColor }
    var fieldBackground: Color { isDarkMode ? Color(.systemGray5) : .white }
    var buttonBackground: Color { isDarkMode ? Color(.systemGray3) : Color.accentColor.opacity(0.2) }
    var dividerColor: Color { isDarkMode ? .white.opacity(0.5) : .gray.opacity(0.5) }
    // Fondo adaptativo si no es personalizado
    var adaptiveBgColor: Color {
        if let custom = bgColor, isCustomBg {
            return custom
        } else {
            return isDarkMode ? .black : .white
        }
    }
    
    var body: some View {
        ZStack {
            // Fondo dinámico adaptativo
            adaptiveBgColor
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    // Título principal
                    Text("Demo Controles y Layout en SwiftUI")
                        .font(.title)
                        .bold()
                        .foregroundColor(mainTextColor)
                    // Botón para cambiar el color de fondo
                    Button(action: {
                        if !isCustomBg || bgColor == nil || bgColor == .white || bgColor == .black {
                            bgColor = .blue.opacity(0.2)
                            isCustomBg = true
                        } else {
                            bgColor = nil
                            isCustomBg = false
                        }
                    }) {
                        Text(isCustomBg ? "Restaurar fondo automático" : "Cambiar color de fondo")
                            .padding()
                            .background(buttonBackground)
                            .foregroundColor(mainTextColor)
                            .cornerRadius(8)
                    }
                    // Toggle para modo oscuro
                    Toggle(isOn: $isDarkMode) {
                        Text("Modo Oscuro")
                            .foregroundColor(mainTextColor)
                    }
                    .padding(.horizontal)
                    // Slider para ajustar tamaño de texto
                    VStack {
                        Slider(value: $textSize, in: 16...40, step: 1) {
                            Text("Tamaño del texto")
                        }
                        .accentColor(secondaryTextColor)
                        Text("Tamaño actual: \(Int(textSize))")
                            .foregroundColor(mainTextColor)
                    }
                    // TextField para ingresar nombre
                    TextField("Ingresa tu nombre", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .background(fieldBackground)
                        .foregroundColor(mainTextColor)
                    // Texto dinámico con el nombre
                    Text("Hola, \(name)")
                        .font(.system(size: CGFloat(textSize)))
                        .foregroundColor(mainTextColor)
                    // Ícono con gestos
                    VStack {
                        Image(systemName: "star.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                gestureMessage = "¡Tocaste la estrella!"
                            }
                            .onLongPressGesture {
                                gestureMessage = "¡Presionaste largo la estrella!"
                            }
                        Text(gestureMessage)
                            .foregroundColor(secondaryTextColor)
                    }
                    Divider()
                        .background(dividerColor)
                    // Ejemplos de layouts
                    VStackExampleView(isDarkMode: isDarkMode)
                    HStackExampleView(isDarkMode: isDarkMode)
                    ZStackExampleView(isDarkMode: isDarkMode)
                }
                .padding()
            }
        }
        // Cambia el esquema de color según el toggle
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

// Ejemplo de VStack con Spacer y padding
struct VStackExampleView: View {
    let isDarkMode: Bool
    var body: some View {
        VStack {
            Text("Ejemplo VStack")
                .font(.headline)
                .foregroundColor(isDarkMode ? .white : .black)
            Spacer()
            Text("Elemento 1")
                .foregroundColor(isDarkMode ? .white : .black)
            Text("Elemento 2")
                .foregroundColor(isDarkMode ? .white : .black)
            Spacer()
        }
        .padding()
        .background(isDarkMode ? Color.green.opacity(0.3) : Color.green.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    VStackExampleView(isDarkMode: false)
}

// Ejemplo de HStack con Spacer y padding
struct HStackExampleView: View {
    let isDarkMode: Bool
    var body: some View {
        HStack {
            Text("Ejemplo HStack")
                .font(.headline)
                .foregroundColor(isDarkMode ? .white : .black)
            Spacer()
            Image(systemName: "bolt.fill")
                .foregroundColor(.blue)
            Text("Elemento")
                .foregroundColor(isDarkMode ? .white : .black)
        }
        .padding()
        .background(isDarkMode ? Color.blue.opacity(0.3) : Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    HStackExampleView(isDarkMode: false)
}

// Ejemplo de ZStack con fondo y texto superpuesto
struct ZStackExampleView: View {
    let isDarkMode: Bool
    var body: some View {
        ZStack {
            (isDarkMode ? Color.purple.opacity(0.3) : Color.purple.opacity(0.1))
            Text("Ejemplo ZStack")
                .font(.headline)
                .padding()
                .foregroundColor(isDarkMode ? .white : .black)
            VStack {
                Spacer()
                Text("Texto sobre fondo")
                    .padding(8)
                    .background(isDarkMode ? Color.black.opacity(0.7) : Color.white.opacity(0.7))
                    .cornerRadius(8)
                    .foregroundColor(isDarkMode ? .white : .black)
            }
        }
        .frame(height: 100)
        .cornerRadius(10)
    }
}

#Preview {
    ZStackExampleView(isDarkMode: false)
}

#Preview {
    ContentView()
}
