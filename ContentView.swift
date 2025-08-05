import SwiftUI

@main
struct Divine_mind_1_2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
import SwiftUI
import Foundation

// MARK: - Models
struct WisdomTeaching {
    let teacher: String
    let text: String
    let category: String
}

struct MeditationSession {
    let time: String
    let hour: Int
    let minute: Int
    let name: String
}

// MARK: - Sacred Symbol Component
struct SacredSymbol: View {
    let size: CGFloat
    let animated: Bool
    @State private var rotation: Double = 0
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Outer circle
            Circle()
                .stroke(Color.purple.opacity(0.8))
                .frame(width: size, height: size)
                .shadow(color: .purple.opacity(0.5), radius: 8)
            
            // Middle circle
            Circle()
                .stroke(Color.pink.opacity(0.7))
                .frame(width: size * 0.7, height: size * 0.7)
            
            // Inner sacred center
            Circle()
                .fill(Color.white.opacity(0.9))
                .frame(width: size * 0.2, height: size * 0.2)
                .scaleEffect(animated ? pulseScale : 1.0)
        }
        .rotationEffect(.degrees(animated ? rotation : 0))
        .onAppear {
            if animated {
                withAnimation(.linear(duration: 120).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
                withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                    pulseScale = 1.3
                }
            }
        }
    }
}

// MARK: - View Model
class DivineMindViewModel: ObservableObject {
    @Published var currentView: String = "home"
    @Published var dailyWisdom: WisdomTeaching = WisdomTeaching(
        teacher: "Divine Source", 
        text: "This moment is perfect - you are the Divine recognizing itself", 
        category: "divine presence"
    )
    @Published var currentReminder: String = "Now is the time to be happy - you are already the joy you seek"
    @Published var showWelcome: Bool = false
    @Published var isLiveStreamActive: Bool = false
    @Published var liveViewerCount: Int = 0
    @Published var isStreaming: Bool = false
    @Published var meditationTimer: Int = 0
    @Published var isMeditating: Bool = false
    @Published var nextSessionCountdown: String = "Calculating..."
    @Published var isUnitySessionTime: Bool = false
    @Published var isAudioGuidanceActive: Bool = false
    @Published var paymentMessage: String = ""
    
    private var timer: Timer?
    private var countdownTimer: Timer?
    
    let meditationTimes = [
        MeditationSession(time: "4:44 AM", hour: 4, minute: 44, name: "Dawn Awakening"),
        MeditationSession(time: "11:11 AM", hour: 11, minute: 11, name: "Unity Portal"),
        MeditationSession(time: "3:33 PM", hour: 15, minute: 33, name: "Divine Alignment"),
        MeditationSession(time: "8:08 PM", hour: 20, minute: 8, name: "Evening Integration")
    ]
    
    let wisdomTeachings = [
        WisdomTeaching(teacher: "The Divine Source", text: "The yellow leaf and its life span - it fully had a life span therefore spirit was present in the leaf. This is the promise of the now.", category: "divine presence"),
        WisdomTeaching(teacher: "Cave of Brahma", text: "Within the sacred chamber of your Third Ventricle dwells the Divine Being. This holy cave in the center of your brain is your true home - return here through the sacred spine.", category: "sacred anatomy"),
        WisdomTeaching(teacher: "The Spinal Pathway", text: "Your spine is the highway of consciousness, connecting earth to heaven within you. Each breath up and down this sacred channel awakens the Divine Being in the Cave of Brahma.", category: "divine physiology"),
        WisdomTeaching(teacher: "Third Ventricle Wisdom", text: "Come home to the Cave of Brahma - this sacred hollow in your brain where cerebrospinal fluid flows is the throne room of your Divine Self.", category: "inner sanctuary"),
        WisdomTeaching(teacher: "Buddha", text: "You are what you think. All that you are arises with your thoughts. With your thoughts you make the world.", category: "mindfulness"),
        WisdomTeaching(teacher: "Rumi", text: "You are not just the drop in the ocean, but the entire ocean in each drop.", category: "unity"),
        WisdomTeaching(teacher: "Advaita Vedanta", text: "That which you are seeking is That which is seeking. The observer and the observed are one.", category: "non-dual wisdom"),
        WisdomTeaching(teacher: "Lao Tzu", text: "The Tao that can be spoken is not the eternal Tao. Yet in silence, it reveals itself completely.", category: "mystical truth"),
        WisdomTeaching(teacher: "Jesus", text: "The kingdom of heaven is within you. Split a piece of wood and I am there, lift a stone and you will find me.", category: "divine presence"),
        WisdomTeaching(teacher: "Krishna", text: "I am the Self seated in the hearts of all beings. I am the beginning, the middle, and the end of all beings.", category: "divine identity")
    ]
    
    let joyfulReminders = [
        "Now is the time to be happy - you are already the joy you seek",
        "Stay in the space of joy - it is your natural state of being",
        "Live with peace knowing we are working on revealing ourselves to ourselves",
        "This moment is perfect - you are the Divine recognizing itself",
        "The Divine is celebrating itself through your very existence",
        "Your true home in the Cave of Brahma is always available - return with joy",
        "Every breath is the Divine breathing itself awake through you",
        "You are the awareness in which all experience appears and disappears",
        "The seeking ends when you realize you are what you have been seeking",
        "In this moment, you are exactly where the Divine intended you to be",
        "Your $10 per meditation drops into Creation, building love and kindness worldwide",
        "Each sacred sit becomes a resource for manifesting True Self in All",
        "Through conscious contribution, we build the world we desire together"
    ]
    
    func refreshReminder() {
        currentReminder = joyfulReminders.randomElement() ?? joyfulReminders[0]
    }
    
    func dismissWelcome() {
        showWelcome = false
    }
    
    // MARK: - Simple Payment Function
    func processPayment() {
        paymentMessage = "💳 Processing $10 sacred investment..."
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.paymentMessage = "✅ Sacred investment complete!"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.paymentMessage = ""
            }
        }
    }
    
    // MARK: - Live Streaming Functions
    func startLiveStream() {
        isStreaming = true
        isLiveStreamActive = true
        simulateViewerCount()
    }
    
    func stopLiveStream() {
        isStreaming = false
        isLiveStreamActive = false
        liveViewerCount = 0
    }
    
    private func simulateViewerCount() {
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
            if self.isLiveStreamActive {
                self.liveViewerCount = Int.random(in: 108...888)
            } else {
                timer.invalidate()
            }
        }
    }
    
    // MARK: - Meditation Functions
    func startMeditation(duration: Int = 1080) {
        isMeditating = true
        meditationTimer = duration
        isAudioGuidanceActive = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.meditationTimer > 0 {
                self.meditationTimer -= 1
            } else {
                self.stopMeditation()
            }
        }
    }
    
    func stopMeditation() {
        isMeditating = false
        meditationTimer = 0
        isAudioGuidanceActive = false
        timer?.invalidate()
        timer = nil
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds / 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateCountdown()
        }
        updateCountdown()
    }
    
    private func updateCountdown() {
        let now = Date()
        let calendar = Calendar.current
        
        var nextSession: Date?
        
        for session in meditationTimes {
            var components = calendar.dateComponents([.year, .month, .day], from: now)
            components.hour = session.hour
            components.minute = session.minute
            
            if let sessionTime = calendar.date(from: components) {
                if sessionTime > now {
                    nextSession = sessionTime
                    break
                }
            }
        }
        
        if nextSession == nil {
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: now)!
            var components = calendar.dateComponents([.year, .month, .day], from: tomorrow)
            components.hour = meditationTimes[0].hour
            components.minute = meditationTimes[0].minute
            nextSession = calendar.date(from: components)
        }
        
        if let nextSession = nextSession {
            let timeInterval = nextSession.timeIntervalSince(now)
            let hours = Int(timeInterval) / 3600
            let minutes = Int(timeInterval / 3600) / 60
            let seconds = Int(timeInterval) / 60
            
            isUnitySessionTime = timeInterval <= 300 && timeInterval > 0
            
            if hours > 0 {
                nextSessionCountdown = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            } else {
                nextSessionCountdown = String(format: "%02d:%02d", minutes, seconds)
            }
        }
    }
}

// MARK: - Main Content View
struct ContentView: View {
    @StateObject private var viewModel = DivineMindViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Fixed Navigation Header
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        ForEach(["home", "live", "wisdom", "meditation"], id: \.self) { tab in
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    viewModel.currentView = tab
                                }
                            }) {
                                VStack(spacing: 4) {
                                    Image(systemName: iconForTab(tab))
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Text(tab.capitalized)
                                        .font(.caption2)
                                        .fontWeight(.medium)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(
                                            viewModel.currentView == tab 
                                            ? LinearGradient(colors: [.purple, .pink], startPoint: .leading, endPoint: .trailing)
                                            : LinearGradient(colors: [.gray.opacity(0.3)], startPoint: .leading, endPoint: .trailing)
                                        )
                                )
                                .foregroundColor(.white)
                                .scaleEffect(viewModel.currentView == tab ? 1.05 : 1.0)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.black.opacity(0.95))
                    
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.purple.opacity(0.5), .pink.opacity(0.5)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 2)
                }
                
                // Scrollable Content
                ScrollView {
                    LazyVStack(spacing: 24) {
                        switch viewModel.currentView {
                        case "home":
                            HomeView(viewModel: viewModel)
                        case "live":
                            LiveStreamView(viewModel: viewModel)
                        case "wisdom":
                            WisdomView(viewModel: viewModel)
                        case "meditation":
                            MeditationView(viewModel: viewModel)
                        default:
                            HomeView(viewModel: viewModel)
                        }
                    }
                    .padding()
                    .padding(.bottom, 50)
                }
            }
            .background(
                LinearGradient(
                    colors: [
                        Color.black,
                        Color.indigo.opacity(0.3),
                        Color.purple.opacity(0.2),
                        Color.black
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.dark)
        .onAppear {
            viewModel.refreshReminder()
            viewModel.startCountdown()
        }
    }
    
    private func iconForTab(_ tab: String) -> String {
        switch tab {
        case "home": return "house.fill"
        case "live": return "video.fill"
        case "wisdom": return "sun.max.fill"
        case "meditation": return "circle.dotted"
        default: return "circle"
        }
    }
}

// MARK: - Home View
struct HomeView: View {
    @ObservedObject var viewModel: DivineMindViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Divine Mind")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.purple, .pink, .yellow],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            Text("$10 per meditation drops into Creation")
                .font(.title2)
                .foregroundColor(.green)
                .fontWeight(.bold)
            
            Text("Building the world we desire in love and kindness")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
}

// MARK: - Live Stream View
struct LiveStreamView: View {
    @ObservedObject var viewModel: DivineMindViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Live Divine Guidance")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            Text("Next session: \(viewModel.nextSessionCountdown)")
                .font(.title)
                .foregroundColor(.cyan)
            
            if viewModel.isLiveStreamActive {
                Text("\(viewModel.liveViewerCount) Souls Connected")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            Button(viewModel.isStreaming ? "End Transmission" : "Begin Transmission") {
                if viewModel.isStreaming {
                    viewModel.stopLiveStream()
                } else {
                    viewModel.startLiveStream()
                }
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            Spacer()
        }
    }
}

// MARK: - Wisdom View
struct WisdomView: View {
    @ObservedObject var viewModel: DivineMindViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Sacred Wisdom")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            ForEach(Array(viewModel.wisdomTeachings.prefix(3)), id: \.teacher) { teaching in
                VStack(spacing: 12) {
                    Text("\"\(teaching.text)\"")
                        .font(.body)
                        .foregroundColor(.gray)
                        .italic()
                        .multilineTextAlignment(.center)
                    
                    Text("— \(teaching.teacher)")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                        .fontWeight(.medium)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.orange.opacity(0.1))
                )
            }
            
            Spacer()
        }
    }
}

// MARK: - Meditation View
struct MeditationView: View {
    @ObservedObject var viewModel: DivineMindViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Sacred Meditation")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Journey to the Cave of Brahma")
                .font(.subheadline)
                .foregroundColor(.gray)
                .italic()
            
            SacredSymbol(size: 120, animated: true)
            
            if viewModel.isMeditating {
                VStack(spacing: 16) {
                    Text("Sacred Meditation in Progress")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    SacredSymbol(size: 80, animated: true)
                    
                    Text(viewModel.formatTime(viewModel.meditationTimer))
                        .font(.system(size: 48, weight: .light, design: .monospaced))
                        .foregroundColor(.blue)
                    
                    if viewModel.isAudioGuidanceActive {
                        VStack(spacing: 12) {
                            Text("🎧 Audio Guidance Active")
                                .font(.subheadline)
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                            
                            Text("\"Gently place your attention in the center of your brain... the sacred Cave of Brahma, your true home...\"")
                                .font(.body)
                                .foregroundColor(.green)
                                .italic()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .lineSpacing(4)
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(16)
                    }
                    
                    VStack(spacing: 8) {
                        Button("End Session") {
                            viewModel.stopMeditation()
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(20)
                        
                        Button(viewModel.isAudioGuidanceActive ? "🔇 Silence Guidance" : "🎧 Enable Guidance") {
                            viewModel.isAudioGuidanceActive.toggle()
                        }
                        .font(.caption)
                        .foregroundColor(.cyan)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(Color.cyan.opacity(0.2))
                        .cornerRadius(16)
                    }
                }
            } else {
                VStack(spacing: 20) {
                    Text("Begin Your Sacred Practice")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("Place gentle attention on the center of your brain - the Third Ventricle, your sacred Cave of Brahma")
                        .font(.body)
                        .foregroundColor(.green)
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Sacred Investment: $10 per meditation session")
                        .font(.caption)
                        .foregroundColor(.yellow)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            Button("3 min") {
                                viewModel.startMeditation(duration: 180)
                            }
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(width: 80, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            
                            Button("11 min") {
                                viewModel.startMeditation(duration: 660)
                            }
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(width: 80, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            
                            Button("18 min") {
                                viewModel.startMeditation(duration: 1080)
                            }
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(width: 80, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                        
                        Button("💳 Sacred Investment: $10") {
                            viewModel.processPayment()
                        }
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.green)
                        .cornerRadius(20)
                        .shadow(color: .green.opacity(0.4), radius: 6)
                        
                        if !viewModel.paymentMessage.isEmpty {
                            Text(viewModel.paymentMessage)
                                .font(.subheadline)
                                .foregroundColor(.green)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        Text("Rest as the Divine Being dwelling in your sacred home")
                            .font(.caption)
                            .foregroundColor(.cyan)
                            .italic()
                    }
                }
            }
            
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
