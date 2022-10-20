Class {
	#name : #ROCMetaObjectAndOriginalObject,
	#superclass : #Object,
	#instVars : [
		'object',
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric-instrumentation'
}

{ #category : #accessing }
ROCMetaObjectAndOriginalObject >> metaObject [

	^ metaObject
]

{ #category : #accessing }
ROCMetaObjectAndOriginalObject >> metaObject: anObject [

	metaObject := anObject
]

{ #category : #accessing }
ROCMetaObjectAndOriginalObject >> object [

	^ object
]

{ #category : #accessing }
ROCMetaObjectAndOriginalObject >> object: anObject [

	object := anObject
]
