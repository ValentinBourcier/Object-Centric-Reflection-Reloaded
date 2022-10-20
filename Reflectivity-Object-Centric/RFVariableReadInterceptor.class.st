Class {
	#name : #RFVariableReadInterceptor,
	#superclass : #RFStrategyInterceptor,
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #execution }
RFVariableReadInterceptor >> execute: aOperation [
]

{ #category : #override }
RFVariableReadInterceptor >> execute: aName withValue: aValue [

	^ metaObject linkInsteadVariableRead: aName withValue: aValue
]
