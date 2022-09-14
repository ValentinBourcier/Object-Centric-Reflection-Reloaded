Class {
	#name : #ObjectCentricDebuggerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'notebook',
		'dynamicPage',
		'content',
		'InstalledTab',
		'addOCDTab'
	],
	#category : #'Reflectivity-Object-Centric-Visualization'
}

{ #category : #layout }
ObjectCentricDebuggerPresenter class >> open [

	<script>
	self new open.
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> addOCDPage [

	^ SpNotebookPage
		  title: 'Add OCD'
		  icon: (self iconNamed: #nautilusIcon)
		  provider: [ 
			  SpClassMethodBrowser new
				  classes: self class environment allClasses;
				  yourself ]
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: notebook;
		  yourself
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> initialize [
	super initialize
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> initializePresenter [

	notebook := self newNotebook.
	notebook
		addPage: self installedPage;
		addPage: self addOCDPage.
]

{ #category : #initialization }
ObjectCentricDebuggerPresenter >> installedPage [

	^ (SpNotebookPage title: 'Installed' provider: [ 
		   SpDemoMessageBrowser new
			   messages: Object methods;
			   yourself ]) yourself
]
