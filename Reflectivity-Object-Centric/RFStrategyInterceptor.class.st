Class {
	#name : #RFStrategyInterceptor,
	#superclass : #Object,
	#instVars : [
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #execution }
RFStrategyInterceptor >> execute: aOperation [

	^ self subclassResponsibility
]

{ #category : #execution }
RFStrategyInterceptor >> execute: aName withValue: aValue [

	^ self subclassResponsibility
]

{ #category : #accessing }
RFStrategyInterceptor >> metaObject [

	^ metaObject
]

{ #category : #accessing }
RFStrategyInterceptor >> metaObject: anObject [

	metaObject := anObject
]
