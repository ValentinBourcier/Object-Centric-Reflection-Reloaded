Class {
	#name : #RFStrategyInterceptor,
	#superclass : #Object,
	#instVars : [
		'metaObject',
		'selector'
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

{ #category : #accessing }
RFStrategyInterceptor >> selector [

	^ selector
]

{ #category : #accessing }
RFStrategyInterceptor >> selector: anObject [

	selector := anObject
]
