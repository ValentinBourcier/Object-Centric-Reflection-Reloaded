Class {
	#name : #OCDMessageSendTest,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
OCDMessageSendTest >> testExecute [

	| a proxy |
	a := Bub new.
	proxy := a proxify.
	Transcript clear.
	a mWithSuper
]
