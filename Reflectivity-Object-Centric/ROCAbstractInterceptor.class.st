"
I am the Abstract class of the interceptor, I have the methods execute and execute: withValue, this methods have as arguments the reification arguments, I know the ROCMetaobject and I have a reference to the anonymous subclass.
"
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

{ #category : #accessing }
ROCAbstractInterceptor >> receiver [
	 ^metaObject receiver
]
