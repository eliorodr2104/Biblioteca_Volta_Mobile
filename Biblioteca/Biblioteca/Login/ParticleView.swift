//
//  ParticleView.swift
//  Biblioteca
//
//  Created by eliomar rodriguez on 22/05/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct ParticleView: View {
    @State private var particles: [Particle] = []
    let maxParticles = 50
    
    var body: some View {
        ZStack {
            ForEach(particles.indices, id: \.self) { index in
                let particle = particles[index]
                if particle.isAnimating {
                    Circle()
                        .foregroundColor(particle.color)
                        .frame(width: particle.size, height: particle.size)
                        .position(particle.position)
                        .opacity(particle.opacity)
                        .animation(particle.animation, value: particle.isAnimating)
                        .offset(x: particle.offsetX, y: particle.offsetY)
                        .onAppear {
                            startAnimation(for: index)
                        }
                }
            }
        }
        .onAppear {
            startEmittingParticles()
        }
        .drawingGroup()
    }
    
    private func generateParticle() -> Particle {
        let size = CGFloat.random(in: 5...20)
        let position = CGPoint(x: CGFloat.random(in: -500...500), y: CGFloat.random(in: 0...100))
        let color = Color.purple.opacity(0.8)
        let opacity = Double.random(in: 0.3...1)
        let animationDuration = Double.random(in: 3...5)
        let initialOffsetX = 0 // Spostamento iniziale verso sinistra
        let finalOffsetX = CGFloat.random(in: 400...500) // Spostamento finale verso destra
        let initialOffsetY = 0 // Spostamento iniziale verso l'alto
        let finalOffsetY = 1000 // Spostamento finale verso il basso
        
        return Particle(size: size, position: position, color: color, opacity: opacity, animationDuration: animationDuration, initialOffsetX: CGFloat(initialOffsetX), finalOffsetX: CGFloat(finalOffsetX), initialOffsetY: CGFloat(initialOffsetY), finalOffsetY: CGFloat(finalOffsetY))
    }
    
    private func startAnimation(for index: Int) {
        let particle = particles[index]
        let animation = particle.animation
        
        withAnimation(animation) {
            particles[index].offsetX = particle.finalOffsetX
            particles[index].offsetY = particle.finalOffsetY
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + particle.animationDuration) {
            particles[index].isAnimating = false
            particles[index].offsetX = particle.initialOffsetX
            particles[index].offsetY = particle.initialOffsetY
        }
    }

    private func startParticleAnimation() {
        var currentIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if currentIndex >= particles.count {
                timer.invalidate()
                return
            }
            
            particles[currentIndex].isAnimating = true
            
            startAnimation(for: currentIndex)
            
            currentIndex += 1
        }
    }

    private func startEmittingParticles() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            if particles.count < maxParticles {
                let recycledParticles = particles.filter { !$0.isAnimating }
                if recycledParticles.isEmpty {
                    particles.append(generateParticle())
                } else {
                    let recycledParticle = recycledParticles.first!
                    let index = particles.firstIndex(of: recycledParticle)!
                    particles[index] = generateParticle()
                    
                    particles[index].isAnimating = true
                    
                    startAnimation(for: index)
                }
            }
        }
    }
}

struct Particle: Identifiable, Equatable {
    let id = UUID()
    let size: CGFloat
    let position: CGPoint
    let color: Color
    let opacity: Double
    let animationDuration: Double
    var initialOffsetX: CGFloat
    var finalOffsetX: CGFloat
    var initialOffsetY: CGFloat
    var finalOffsetY: CGFloat
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    var isAnimating: Bool = true
    
    var animation: Animation {
        Animation.linear(duration: animationDuration)
    }
}

struct ParticleView_Previews: PreviewProvider {
    static var previews: some View {
        ParticleView()
    }
}
