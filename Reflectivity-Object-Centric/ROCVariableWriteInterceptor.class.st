Class {
	#name : #ROCVariableWriteInterceptor,
	#superclass : #ROCAbstractInterceptor,
	#category : #'Reflectivity-Object-Centric-interceptors'
}

{ #category : #execution }
ROCVariableWriteInterceptor >> execute: aOperation [

	^ metaObject linkInsteadAssignment: aOperation
]

{ #category : #override }
ROCVariableWriteInterceptor >> execute: aName withValue: aValue [

	^ metaObject linkInsteadAssignment: aName withValue: aValue
]
