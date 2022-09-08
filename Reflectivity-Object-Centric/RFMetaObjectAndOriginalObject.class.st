Class {
	#name : #RFMetaObjectAndOriginalObject,
	#superclass : #Object,
	#instVars : [
		'object',
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #accessing }
RFMetaObjectAndOriginalObject >> metaObject [

	^ metaObject
]

{ #category : #accessing }
RFMetaObjectAndOriginalObject >> metaObject: anObject [

	metaObject := anObject
]

{ #category : #accessing }
RFMetaObjectAndOriginalObject >> object [

	^ object
]

{ #category : #accessing }
RFMetaObjectAndOriginalObject >> object: anObject [

	object := anObject
]
