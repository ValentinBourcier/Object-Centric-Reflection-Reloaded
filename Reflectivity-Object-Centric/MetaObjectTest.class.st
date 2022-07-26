Class {
	#name : #MetaObjectTest,
	#superclass : #Object,
	#instVars : [
		'object',
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #accessing }
MetaObjectTest >> metaObject [

	^ metaObject
]

{ #category : #accessing }
MetaObjectTest >> metaObject: anObject [

	metaObject := anObject
]

{ #category : #accessing }
MetaObjectTest >> object [

	^ object
]

{ #category : #accessing }
MetaObjectTest >> object: anObject [

	object := anObject
]
