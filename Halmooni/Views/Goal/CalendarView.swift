//
//  CalendarView.swift
//  Halmooni
//
//  Created by 추서연 on 5/19/24.
//

import SwiftUI

struct CalendarView: View {
    @State var month: Date
    @State var offset: CGSize = CGSize()
    @State var uploadDate: Set<Date> = [Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 2))!, Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 11))!]
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
        .gesture(
            DragGesture()
                .onChanged { gesture in self.offset = gesture.translation }
                .onEnded { gesture in if gesture.translation.width < -100 { changeMonth(by: 1) }
                    else if gesture.translation.width > 100 { changeMonth(by: -1) }
                    self.offset = CGSize()}
        )
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.backward")
                    .onTapGesture {
                        changeMonth(by: -1)
                    }
                Spacer()
                Text(month, formatter: Self.dateFormatter)
                    .font(.headline)
                    .foregroundColor(Color("TextColor"))
                Spacer()
                Image(systemName: "chevron.right")
                    .onTapGesture {
                        changeMonth(by: 1)
                    }
            }
            .padding(.bottom)
            
            Divider()
                .overlay(Color("SecColor"))
                .frame(minHeight: 1)
                .background(Color("SecColor"))
                .padding(.bottom, 16)
            
            HStack {
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color("GryColor"))
                }
            }
            .padding(.bottom, 5)
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        
        return VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                    if index < firstWeekday {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        let date = getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        let selected = uploadDate.contains(date)
                        let isToday = Calendar.current.isDateInToday(date)
                        
                        CellView(day: day, selected: selected, isToday: isToday)
                            
                    }
                }.padding(.vertical,5)
            }
        }.foregroundColor(Color("TextColor"))
        
    }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
    var day: Int
    var selected: Bool = false
    var isToday: Bool = false
    
    init(day: Int, selected: Bool, isToday: Bool) {
        self.day = day
        self.selected = selected
        self.isToday = isToday
    }
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .opacity(0)
                .foregroundColor(.gray)
                .overlay(Text(String(day)))
                .frame(width: 33, height: 33)
                .background(isToday ? Color("SecColor") : Color.clear)
                .overlay(
                    Group {
                        if selected {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 23, height: 23)
                                .foregroundColor(Color.white)
                            Image(systemName: "star.circle.fill")
                                .resizable()
                                .frame(width: 23, height: 23)
                                .rotationEffect(.degrees(30))
                                .foregroundColor(Color("PrimColor"))
                        }
                    }
                )
        }
    }
}

// MARK: - 내부 메서드
private extension CalendarView {
    /// 특정 해당 날짜
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    /// 해당 월의 시작 날짜
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
        }
    }
}

// MARK: - Static 프로퍼티
extension CalendarView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static let weekdaySymbols = ["일", "월", "화", "수", "목", "금", "토"]
}

#Preview {
    CalendarView(month: Date())
}
