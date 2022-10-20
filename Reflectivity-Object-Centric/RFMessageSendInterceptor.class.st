Class {
	#name : #RFMessageSendInterceptor,
	#superclass : #RFStrategyInterceptor,
	#instVars : [
		'receiver'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #execution }
RFMessageSendInterceptor >> execute: aOperation [

	"receive all sends filter by self if the receiver is the object who insrument if yes propagate and then call my method to do reflective part"

	aOperation receiver == self receiver ifTrue: [ 
		metaObject
			receive: aOperation selector
			withArgs: aOperation arguments ].
	^ metaObject linkInsteadMessageSend: aOperation

	"linkInsteadMessageSend:withValue:"
]

{ #category : #override }
RFMessageSendInterceptor >> execute: aName withValue: aValue [
]

{ #category : #accessing }
RFMessageSendInterceptor >> receiver [

	^ receiver
]

{ #category : #accessing }
RFMessageSendInterceptor >> receiver: anObject [

	receiver := anObject
]
