//
//  Date+Math.swift
//  NextAppsKit
//
//  Created by Louis D'hauwe on 01/03/2017.
//  Copyright © 2017 Next Apps. All rights reserved.
//

import Foundation

extension Date {
	
	private var calendar: Calendar {
		return .current
	}
	
	public func component(_ component: Calendar.Component) -> Int {
		return calendar.component(component, from: self)
	}
	
	public var dayOfWeek: Int {
		return component(.weekday)
	}
	
	public var dayOfMonth: Int {
		return component(.day)
	}
	
	public var month: Int {
		return component(.month)
	}
	
	public var year: Int {
		return component(.year)
	}
	
	public mutating func clearSeconds() {
		
		let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
		self = calendar.date(from: components)!
		
	}
	
	public func byAdding(_ value: Int, for component: Calendar.Component) -> Date? {
		
		let date = calendar.date(byAdding: component, value: value, to: self)
		
		return date
	}
	
	public func byAddingYears(_ years: Int) -> Date? {
		return byAdding(years, for: .year)
	}
	
	public func byAddingMonths(_ months: Int) -> Date? {
		return byAdding(months, for: .month)
	}
	
	public func byAddingDays(_ days: Int) -> Date? {
		return byAdding(days, for: .day)
	}
	
	public func byAddingMinutes(_ minutes: Int) -> Date? {
		return byAdding(minutes, for: .minute)
	}
	
	public func startOfMonth() -> Date? {
		
		let currentDateComponents = (calendar as NSCalendar).components([.year, .month], from: self)
		let startOfMonth = calendar.date(from: currentDateComponents)
		
		return startOfMonth
	}
	
	public func endOfMonth() -> Date? {
		
		if let plusOneMonthDate = self.byAddingMonths(1) {
			let plusOneMonthDateComponents = (calendar as NSCalendar).components([.year, .month], from: plusOneMonthDate)
			
			let endOfMonth = calendar.date(from: plusOneMonthDateComponents)?.addingTimeInterval(-1)
			
			return endOfMonth
		}
		
		return nil
	}
	
	public func startOfDay() -> Date? {
		
		let currentDateComponents = (calendar as NSCalendar).components([.year, .month, .day], from: self)
		let startOfMonth = calendar.date(from: currentDateComponents)
		
		return startOfMonth
	}
	
	public func endOfDay() -> Date? {
		
		if let plusOneDayDate = self.byAddingDays(1) {
			let plusOneDayDateComponents = (calendar as NSCalendar).components([.year, .month, .day], from: plusOneDayDate)
			
			let endOfDay = calendar.date(from: plusOneDayDateComponents)?.addingTimeInterval(-1)
			
			return endOfDay
		}
		
		return nil
	}
	
	public func dateAtStartOfDay() -> Date? {
		
		var components = (Calendar.current as NSCalendar).components([.year, .month, .day, .weekOfYear, .hour, .minute, .second, .weekday, .weekday], from: self)
		
		components.hour = 0
		components.minute = 0
		components.second = 0
		
		return Calendar.current.date(from: components)
	}
	
	public func isSameDay(as date: Date) -> Bool {
		
		let sameDay = calendar.isDate(self, equalTo: date, toGranularity: .day)
		
		return sameDay
	}
	
	public func isSameYear(as date: Date) -> Bool {
		
		let sameYear = calendar.isDate(self, equalTo: date, toGranularity: .year)
		
		return sameYear
	}
	
	public var isToday: Bool {
		return isSameDay(as: Date())
	}
	
	public func isSameMonth(as date: Date) -> Bool {
		
		let sameMonth = calendar.isDate(self, equalTo: date, toGranularity: .month)
		
		return sameMonth
		
	}
	
}
