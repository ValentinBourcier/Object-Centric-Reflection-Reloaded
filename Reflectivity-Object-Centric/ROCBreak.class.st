Class {
	#name : #ROCBreak,
	#superclass : #Exception,
	#instVars : [
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric-tools'
}

{ #category : #accessing }
ROCBreak >> defaultAction [
	^ self unhandledErrorAction
]

{ #category : #testing }
ROCBreak >> isHandleableBy: aDebugger [
	^ aDebugger = ROCDebuggerPresenter 
]

{ #category : #accessing }
ROCBreak >> metaObject [

	^ metaObject
]

{ #category : #accessing }
ROCBreak >> metaObject: anObject [

	metaObject := anObject
]
