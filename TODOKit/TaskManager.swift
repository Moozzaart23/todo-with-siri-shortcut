//
//  TaskManager.swift
//  TODO-App
//
//  Created by Ashis Laha on 24/05/20.
//  Copyright © 2020 Ashis Laha. All rights reserved.
//

import Foundation
import Intents

// Model

public enum PrimaryTaskType {
	case none
	case listening
	case playing
	case studying
	case coding
	
	public func getTitle() -> String {
		var title = ""
		switch self {
		case .none: title = ""
		case .listening: title = "Listening"
		case .playing: title = "Playing"
		case .studying: title = "Studying"
		case .coding: title = "Coding"
		}
		return title
	}
	
	public func getSubTaskTitle() -> String {
		// this could be array of enum
		var title = ""
		switch self {
		case .none: title = ""
		case .listening: title = "Album Name"
		case .playing: title = "Game Name"
		case .studying: title = "Book Name"
		case .coding: title = "Language Name"
		}
		return title
	}
	
	public func mappedToSubTask() -> SecondaryTaskType {
		var SecondaryTaskType: SecondaryTaskType = .none
		switch self {
		case .none: SecondaryTaskType = .none
		case .listening: SecondaryTaskType = .albums(colletion: ["hindi movie songs", "bengali songs", "romantic songs", "stories"])
		case .playing: SecondaryTaskType = .games(list: ["counter strike", "need for speed", "pokemon", "PUBG"])
		case .studying: SecondaryTaskType = .books(names: ["chetan bhagat", "simon sinek", "Robert Kiyosaki"])
		case .coding: SecondaryTaskType = .coding(languages: ["swift", "objc", "c++", "python", "node.js"])
		}
		return SecondaryTaskType
	}
}

public enum SecondaryTaskType {
	case none
	case albums(colletion:[String])
	case games(list:[String])
	case books(names:[String])
	case coding(languages: [String])
}

public enum TaskType {
	case primary
	case secondary
}

// define Task
public struct Task {
	public let primaryDescription: String
	public let secondaryDescription: String
	public let createdTime: Date // can be treated as unique identifier to delete it
	public let performTime: Date
	
	public init(primaryDesc: String,
				secondaryDesc: String,
				createTime: Date,
				performTime: Date) {
		self.primaryDescription = primaryDesc
		self.secondaryDescription = secondaryDesc
		self.createdTime = createTime
		self.performTime = performTime
	}
	
	// define intent here
	// every task should be associated with an TaskIntent - will be created later.
	public var intent: INIntent {
		return INIntent()
	}
}

open class TaskManager {
	public static let shared = TaskManager()
	
	public var tasks: [Task] = []
	
	public func addTask(task: Task) {
		tasks.append(task)
	}
	public func removeTask(taskCreatedTime: Date) {
		
		// we can optimise it using hash-table // not doing right now
		let tempTasks = tasks
		for (index, each) in tempTasks.enumerated() {
			if each.createdTime == taskCreatedTime {
				tasks.remove(at: index)
				break
			}
		}
	}
}