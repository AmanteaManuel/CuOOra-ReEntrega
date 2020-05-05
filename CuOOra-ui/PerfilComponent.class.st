Class {
	#name : #PerfilComponent,
	#superclass : #MasterComponent,
	#instVars : [
		'usuario'
	],
	#category : #'CuOOra-ui'
}

{ #category : #'instance creation' }
PerfilComponent class >> newPerfil: anUser [
	^ self new usuario:anUser.
]

{ #category : #rendering }
PerfilComponent >> initialize [
	super initialize.
]

{ #category : #rendering }
PerfilComponent >> renderBody: aCanvas [
	| preguntas |
	aCanvas div
		id: 'btnFallow';
		with: [ aCanvas button
				callback:
						[ self session model usuario: self session usuario seguirA: usuario ];
				with: 'Follow' ].
	aCanvas heading with: 'Preguntas de ' , usuario nombreUsuario.
	preguntas := self session model ultimasCincoPreguntasDe:usuario.
	aCanvas horizontalRule.
	preguntas
		do: [ :pregunta | 
			self renderPregunta: pregunta canvas: aCanvas.
			aCanvas horizontalRule ]
]

{ #category : #rendering }
PerfilComponent >> renderContentOn: aCanvas [
	self renderHeader: aCanvas.
	self renderBody: aCanvas 
]

{ #category : #accessing }
PerfilComponent >> usuario [
	^ usuario
]

{ #category : #accessing }
PerfilComponent >> usuario: anObject [
	usuario := anObject
]
