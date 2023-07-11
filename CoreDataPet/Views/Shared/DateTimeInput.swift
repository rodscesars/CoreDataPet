//
//  DateTimeInput.swift
//  CoreDataKalango
//
//  Created by Rodrigo Mendes on 03/07/23.
//

import SwiftUI

struct DateTimeInput: View {
    @State private var isDatePickerShown = false
    @State private var isTimePickerShown = false
    @Binding var selectedDate: Date?
    @Binding var selectedTime: Date?
    
    var timeRange: ClosedRange<Date> {
        let now = Date()
        let minTime: Date
        if let selectedDate = selectedDate, Calendar.current.isDate(selectedDate, inSameDayAs: now) {
            minTime = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: now), minute: Calendar.current.component(.minute, from: now), second: 0, of: selectedDate) ?? now
        } else {
            minTime = Calendar.current.startOfDay(for: selectedDate ?? now)
        }
        let maxTime = Calendar.current.date(byAdding: .day, value: 1, to: minTime)!
        return minTime...maxTime
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Data")
                    
                    Spacer()
                    
                    Text(Helper.shared.dateFormatter(date: selectedDate ?? .now))
                        .onTapGesture {
                            isDatePickerShown.toggle()
                            isTimePickerShown = false
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(4)
                    
                    Text(Helper.shared.timeFormatter(time: selectedTime ?? .now ))
                        .onTapGesture {
                            isDatePickerShown = false
                            isTimePickerShown.toggle()
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(4)
                }
                
                
                if isDatePickerShown {
                    let minDate = Calendar.current.startOfDay(for: Date())
                    Section {
                        DatePicker("", selection: Binding {
                            return selectedDate ?? .now
                        } set: { newValue  in
                            selectedDate = newValue
                        }, in: minDate..., displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .environment(\.locale, Locale(identifier: "pt_BR"))
                    }
                }
                
                if isTimePickerShown {
                    Section {
                        HStack {
                            Spacer()
                            DatePicker("", selection: Binding {
                                return selectedTime ?? .now
                            } set: { newValue  in
                                selectedTime = newValue
                            },in: timeRange, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .clipped()
                            Spacer()
                        }
                    }
                }
            }
        }
    }

}

struct ContentInputView: View {
    @State var date: Date? = .now
    @State var time: Date? = .now

    var body: some View {
        DateTimeInput(selectedDate: $date, selectedTime: $time)
    }
}

struct ContentInputView_Previews: PreviewProvider {
    static var previews: some View {
        ContentInputView()
    }
}
