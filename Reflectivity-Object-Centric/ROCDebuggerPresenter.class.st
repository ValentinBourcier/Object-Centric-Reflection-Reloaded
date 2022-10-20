Class {
	#name : #ROCDebuggerPresenter,
	#superclass : #StDebugger,
	#traits : 'TDebugger',
	#classTraits : 'TDebugger classTrait',
	#instVars : [
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric-presenters'
}

{ #category : #'instance creation' }
ROCDebuggerPresenter class >> debugSession: aDebugSession [
	| debugger metaObject |
	metaObject := aDebugSession exception metaObject.
	metaObject metaLevel: true.
	debugger := self newApplication: self currentApplication model: aDebugSession metaObject: metaObject.
	debugger metaObject: metaObject.
	aDebugSession application 
		ifNotNil: [ :app | debugger application: app ].
	metaObject metaLevel: true.
	debugger openWithFullView.
	^ debugger
]

{ #category : #'instance creation' }
ROCDebuggerPresenter class >> newApplication: anApplication model: aModel metaObject: aMetaObject [

	^ self basicNew
		metaObject: aMetaObject;
		application: anApplication;
		setModelBeforeInitialization: aModel;
		initialize;
		yourself
]

{ #category : #accessing }
ROCDebuggerPresenter >> metaObject [

	^ metaObject
]

{ #category : #accessing }
ROCDebuggerPresenter >> metaObject: anObject [

	metaObject := anObject
]

{ #category : #actions }
ROCDebuggerPresenter >> proceedDebugSession [
	metaObject metaLevel: false.
	super proceedDebugSession
]

{ #category : #actions }
ROCDebuggerPresenter >> stepOver [

	metaObject metaLevel: false.
	super stepOver
]
