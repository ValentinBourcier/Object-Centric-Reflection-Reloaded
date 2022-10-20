Class {
	#name : #ROCVariableReadInterceptor,
	#superclass : #ROCAbstractInterceptor,
	#category : #'Reflectivity-Object-Centric-interceptors'
}

{ #category : #execution }
ROCVariableReadInterceptor >> execute: aOperation [
]

{ #category : #override }
ROCVariableReadInterceptor >> execute: aName withValue: aValue [

	^ metaObject linkInsteadVariableRead: aName withValue: aValue
]
