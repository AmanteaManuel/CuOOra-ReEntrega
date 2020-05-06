Class {
	#name : #ErrorLoginComponent,
	#superclass : #AccessGrantingComponent,
	#category : #'CuOOra-ui'
}

{ #category : #accessing }
ErrorLoginComponent >> initialize [ 
	super initialize.
]

{ #category : #accessing }
ErrorLoginComponent >> renderBody: aCanvas [
	aCanvas div
		id: 'error';
		with: [ aCanvas
	 heading with: 'Usuario o contraseña incorrecta.']
]

{ #category : #accessing }
ErrorLoginComponent >> renderContentOn: aCanvas [
	super renderContentOn: aCanvas.
]
