Class {
	#name : #ObjectCentricDebuggerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'content'
	],
	#category : #'Reflectivity-Object-Centric-Visualization'
}

{ #category : #layout }
ObjectCentricDebuggerPresenter class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #content;
		  yourself
]

{ #category : #layout }
ObjectCentricDebuggerPresenter class >> open [

	<script>
	self new open.
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> initializePresenter [

	content:= self newButton.
]
