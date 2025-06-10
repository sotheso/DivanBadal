import SwiftUI
import UserNotifications

struct AlarmView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var settings: AppSettings
    @EnvironmentObject var languageManager: LanguageManager
    @State private var showWeekDaysPicker = false
    @State private var showPoetsPicker = false
    @State private var showTimePicker = false
    @State private var showNotificationPermissionAlert = false
    
    private let weekDays = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    private let poets = ["Cervantes", "Shakespeare", "Keats", "Dante", "Baudelaire", "Neruda", "García Lorca", "Valéry"]
    
    var selectedTimeText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: settings.dailyReminderTime)
    }
    
    var selectedDaysText: String {
        if settings.selectedDays.isEmpty {
            return languageManager.localizedString(.noDaySelected)
        } else {
            return settings.selectedDays.sorted().joined(separator: "، ")
        }
    }
    
    var selectedPoetsText: String {
        if settings.selectedPoets.isEmpty {
            return languageManager.localizedString(.noPoetSelected)
        } else {
            return settings.selectedPoets.sorted().joined(separator: "، ")
        }
    }
    
    func scheduleNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                if settings.notificationsEnabled {
                    for day in settings.selectedDays {
                        for poet in settings.selectedPoets {
                            let content = UNMutableNotificationContent()
                            content.title = languageManager.localizedString(.poemReminder)
                            content.body = String(format: languageManager.localizedString(.poetThoughts), poet)
                            content.sound = .default
                            
                            let calendar = Calendar.current
                            var dateComponents = DateComponents()
                            dateComponents.hour = calendar.component(.hour, from: settings.dailyReminderTime)
                            dateComponents.minute = calendar.component(.minute, from: settings.dailyReminderTime)
                            
                            let dayNumber = weekDays.firstIndex(of: day)! + 1
                            dateComponents.weekday = dayNumber
                            
                            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                            
                            let request = UNNotificationRequest(
                                identifier: "\(poet)-\(day)",
                                content: content,
                                trigger: trigger
                            )
                            
                            UNUserNotificationCenter.current().add(request)
                        }
                    }
                }
            } else {
                showNotificationPermissionAlert = true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Color Back")
                    .ignoresSafeArea()
                
                Form {
                    Section {
                        Toggle(isOn: Binding(
                            get: { settings.notificationsEnabled },
                            set: { newValue in
                                settings.notificationsEnabled = newValue
                                if newValue {
                                    scheduleNotifications()
                                } else {
                                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                }
                            }
                        )) {
                            Label {
                                Text(languageManager.localizedString(.turnOnNotifications))
                            } icon: {
                                Image(systemName: settings.notificationsEnabled ? "bell.fill" : "bell")
                            }
                        }
                    }
                    
                    Section {
                        DisclosureGroup(
                            isExpanded: $showTimePicker,
                            content: {
                                DatePicker("", selection: $settings.dailyReminderTime, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(.wheel)
                                    .labelsHidden()
                                    .environment(\.locale, Locale(identifier: "en_US"))
                                    .onChange(of: settings.dailyReminderTime) { _, _ in
                                        if settings.notificationsEnabled {
                                            scheduleNotifications()
                                        }
                                    }
                            },
                            label: {
                                HStack {
                                    Text(languageManager.localizedString(.notificationTime))
                                    Spacer()
                                    Text(selectedTimeText)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        )
                        .disabled(!settings.notificationsEnabled)
                        .opacity(settings.notificationsEnabled ? 1.0 : 0.5)
                    }
                    
                    Section(header: Text(languageManager.localizedString(.daysOfWeek))) {
                        Toggle(languageManager.localizedString(.dailyNotification), isOn: Binding(
                            get: { settings.dailyNotification },
                            set: { newValue in
                                settings.dailyNotification = newValue
                                if newValue {
                                    settings.selectedDays = Set(weekDays)
                                } else {
                                    settings.selectedDays.removeAll()
                                }
                                if settings.notificationsEnabled {
                                    scheduleNotifications()
                                }
                            }
                        ))
                        .disabled(!settings.notificationsEnabled)
                        .opacity(settings.notificationsEnabled ? 1.0 : 0.5)
                        
                        DisclosureGroup(
                            isExpanded: $showWeekDaysPicker,
                            content: {
                                ForEach(weekDays, id: \.self) { day in
                                    HStack {
                                        Text(day)
                                        Spacer()
                                        if settings.selectedDays.contains(day) {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(Color("Color"))
                                        }
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if settings.selectedDays.contains(day) {
                                            settings.selectedDays.remove(day)
                                            if settings.selectedDays.isEmpty {
                                                settings.dailyNotification = false
                                            }
                                        } else {
                                            settings.selectedDays.insert(day)
                                            if settings.selectedDays.count == weekDays.count {
                                                settings.dailyNotification = true
                                            }
                                        }
                                        if settings.notificationsEnabled {
                                            scheduleNotifications()
                                        }
                                    }
                                }
                            },
                            label: {
                                HStack {
                                    Text(languageManager.localizedString(.selectedDays))
                                    Spacer()
                                    Text(selectedDaysText)
                                        .foregroundStyle(.secondary)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                        )
                        .disabled(!settings.notificationsEnabled)
                        .opacity(settings.notificationsEnabled ? 1.0 : 0.5)
                    }
                    
                    Section(header: Text(languageManager.localizedString(.favoritePoets))) {
                        DisclosureGroup(
                            isExpanded: $showPoetsPicker,
                            content: {
                                ForEach(poets, id: \.self) { poet in
                                    HStack {
                                        Text(poet)
                                        Spacer()
                                        if settings.selectedPoets.contains(poet) {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(Color("Color"))
                                        }
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if settings.selectedPoets.contains(poet) {
                                            settings.selectedPoets.remove(poet)
                                        } else {
                                            settings.selectedPoets.insert(poet)
                                        }
                                        if settings.notificationsEnabled {
                                            scheduleNotifications()
                                        }
                                    }
                                }
                            },
                            label: {
                                HStack {
                                    Text(languageManager.localizedString(.selectedPoets))
                                    Spacer()
                                    Text(selectedPoetsText)
                                        .foregroundStyle(.secondary)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                        )
                        .disabled(!settings.notificationsEnabled)
                        .opacity(settings.notificationsEnabled ? 1.0 : 0.5)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle(languageManager.localizedString(.notificationSettings))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color("Color"))
                    }
                }
            }
            .alert(languageManager.localizedString(.notificationAccess), isPresented: $showNotificationPermissionAlert) {
                Button(languageManager.localizedString(.ok), role: .cancel) { }
            } message: {
                Text(languageManager.localizedString(.enableNotificationsMessage))
            }
            .localized()
        }
    }
}

#Preview {
    AlarmView()
        .environmentObject(AppSettings())
        .environmentObject(LanguageManager.shared)
} 
