Class {
	#name : #AgregarRespuestaComponent,
	#superclass : #PreguntaComponent,
	#instVars : [
		'respuesta'
	],
	#category : #'CuOOra-ui'
}

{ #category : #'instance creation' }
AgregarRespuestaComponent class >> newAgregarRespuesta: unaRespuesta para: unaPregunta [
	^ self new respuesta: unaRespuesta para: unaPregunta.
]

{ #category : #methods }
AgregarRespuestaComponent >> cancelar [
	self respuesta: nil.
]

{ #category : #methods }
AgregarRespuestaComponent >> guardar: unaRespuesta a: unaPregunta de: unUsuario [
	""

	self session model
		altaRespuesta: unaRespuesta
		pregunta: unaPregunta
		usuario: unUsuario
]

{ #category : #rendering }
AgregarRespuestaComponent >> renderContentOn: aCanvas [
	self renderHeader: aCanvas.
	aCanvas div
		id: 'italicFont';
		with: [ aCanvas heading with: pregunta titulo ].
	self renderPregunta: pregunta canvas: aCanvas.
	self renderTextareaRespuesta: aCanvas
]

{ #category : #rendering }
AgregarRespuestaComponent >> renderTextareaRespuesta: aCanvas [
	| unaRespuesta |
	aCanvas
		form: [ aCanvas textArea
				rows: 10;
				columns: 50;
				callback: [ :value | unaRespuesta := value ].
			aCanvas break.
			aCanvas submitButton
				callback: [ self guardar: unaRespuesta a: pregunta de: self session usuario ];
				with: 'Responder' ]
]

{ #category : #accessing }
AgregarRespuestaComponent >> respuesta [
	^ respuesta
]

{ #category : #accessing }
AgregarRespuestaComponent >> respuesta: anObject [
	respuesta := anObject
]

{ #category : #methods }
AgregarRespuestaComponent >> respuesta: unaRespuesta para: unaPregunta [
	respuesta := unaRespuesta. pregunta:= unaPregunta
]
