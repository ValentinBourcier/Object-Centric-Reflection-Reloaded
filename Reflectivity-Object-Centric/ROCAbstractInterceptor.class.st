Class {
	#name : #ROCAbstractInterceptor,
	#superclass : #Object,
	#instVars : [
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric-interceptors'
}

{ #category : #execution }
ROCAbstractInterceptor >> execute: aOperation [

	^ self subclassResponsibility
]

{ #category : #execution }
ROCAbstractInterceptor >> execute: aName withValue: aValue [

	^ self subclassResponsibility
]

{ #category : #accessing }
ROCAbstractInterceptor >> metaObject [

	^ metaObject
]

{ #category : #accessing }
ROCAbstractInterceptor >> metaObject: anObject [

	metaObject := anObject
]
