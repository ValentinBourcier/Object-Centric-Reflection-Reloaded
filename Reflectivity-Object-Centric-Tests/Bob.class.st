Class {
	#name : #Bob,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #'Reflectivity-Object-Centric-Tests-utils'
}

{ #category : #'as yet unclassified' }
Bob >> index [

	^ -3
]

{ #category : #'as yet unclassified' }
Bob >> instVarAccessInSuperCall [
	^self index
	
]

{ #category : #accessing }
Bob >> m [
 	x := self m2
]

{ #category : #accessing }
Bob >> m2 [
	'coucou' crTrace.
 	^self
]

{ #category : #'as yet unclassified' }
Bob >> mWithSuper [
	^self index
]

{ #category : #'as yet unclassified' }
Bob >> redefineNoSuper [

	^ 1
]

{ #category : #'as yet unclassified' }
Bob >> superUpToMiddleHierarchy [
	"I do nothing"
]

{ #category : #accessing }
Bob >> x [
	 ^x
]
