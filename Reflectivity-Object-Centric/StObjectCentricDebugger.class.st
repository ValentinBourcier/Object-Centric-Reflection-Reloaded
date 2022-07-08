Class {
	#name : #StObjectCentricDebugger,
	#superclass : #StDebugger,
	#traits : 'TDebugger',
	#classTraits : 'TDebugger classTrait',
	#instVars : [
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #'instance creation' }
StObjectCentricDebugger class >> debugSession: aDebugSession [
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
StObjectCentricDebugger class >> newApplication: anApplication model: aModel metaObject: aMetaObject [

	^ self basicNew
		metaObject: aMetaObject;
		application: anApplication;
		setModelBeforeInitialization: aModel;
		initialize;
		yourself
]

{ #category : #accessing }
StObjectCentricDebugger >> metaObject [

	^ metaObject
]

{ #category : #accessing }
StObjectCentricDebugger >> metaObject: anObject [

	metaObject := anObject
]

{ #category : #actions }
StObjectCentricDebugger >> proceedDebugSession [
	metaObject metaLevel: false.
	super proceedDebugSession
]

{ #category : #actions }
StObjectCentricDebugger >> stepOver [

	metaObject metaLevel: false.
	super stepOver
]
