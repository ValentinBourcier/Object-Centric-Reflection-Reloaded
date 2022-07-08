Class {
	#name : #RFObjectCentricBreak,
	#superclass : #Exception,
	#instVars : [
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #accessing }
RFObjectCentricBreak >> defaultAction [
	^ self unhandledErrorAction
]

{ #category : #testing }
RFObjectCentricBreak >> isHandleableBy: aDebugger [
	^ aDebugger = StObjectCentricDebugger 
]

{ #category : #accessing }
RFObjectCentricBreak >> metaObject [

	^ metaObject
]

{ #category : #accessing }
RFObjectCentricBreak >> metaObject: anObject [

	metaObject := anObject
]
