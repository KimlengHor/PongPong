//
//  NotificationViewModel.swift
//  PongPong
//
//  Created by Kimleng Hor on 5/12/23.
//

import Foundation
import UserNotifications

@MainActor
class NotificationViewModel: ObservableObject {
    
    @Published var showingAlert = false
    @Published var errorMessage = ""
    @Published var success = false
    
    func getNotificationPermission() async {
        do {
            let success = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            if success {
                scheduleNotification()
                self.success = true
            } else {
                showingAlert = true
                errorMessage = "Sorry, we cannot register notification for you this time"
            }
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "It's Story Time!"
        content.body = "Time to read with your little one. Choose a bedtime story and make lasting memories together."
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = 18
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
