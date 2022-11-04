Class {
	#name : #ROCAction,
	#superclass : #Object,
	#category : #'Reflectivity-Object-Centric-metalinks'
}

{ #category : #execution }
ROCAction >> execute: aLinkArguments [

	^ self subclassResponsibility
]
