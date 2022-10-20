Class {
	#name : #Box,
	#superclass : #Case,
	#instVars : [
		'height',
		'width',
		'depth',
		'boxWeight'
	],
	#category : #'Reflectivity-Object-Centric-Tests-utils'
}

{ #category : #accessing }
Box >> boxWeight [

	^ boxWeight
]

{ #category : #accessing }
Box >> boxWeight: anObject [

	boxWeight := anObject
]

{ #category : #accessing }
Box >> calculateBoxWeight [

	boxWeight := width * height * depth * 0.001
]

{ #category : #accessing }
Box >> depth [

	^ depth
]

{ #category : #accessing }
Box >> depth: anObject [

	depth := anObject
]

{ #category : #accessing }
Box >> height [

	^ height
]

{ #category : #accessing }
Box >> height: anObject [

	height := anObject
]

{ #category : #'api - accessing' }
Box >> weight [ 

	super weight + boxWeight
]

{ #category : #accessing }
Box >> width [

	^ width
]

{ #category : #accessing }
Box >> width: anObject [

	width := anObject
]
