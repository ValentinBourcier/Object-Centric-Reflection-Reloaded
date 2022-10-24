Class {
	#name : #ROCVariableWriteInterceptor,
	#superclass : #ROCAbstractInterceptor,
	#category : #'Reflectivity-Object-Centric-interceptors'
}

{ #category : #execution }
ROCVariableWriteInterceptor >> execute: aOperation [
	"USING THIS"
	^ metaObject linkInsteadAssignment: aOperation
]

{ #category : #override }
ROCVariableWriteInterceptor >> execute: aName withValue: aValue [
	"NOT USING, VALUES HAVENT A GOOD VALUE"
	^ metaObject linkInsteadAssignment: aName withValue: aValue
]
