Class {
	#name : #NuevaPreguntaComponent,
	#superclass : #MasterComponent,
	#instVars : [
		'titulo',
		'descripcion',
		'topicos'
	],
	#category : #'CuOOra-ui'
}

{ #category : #'instance creation' }
NuevaPreguntaComponent class >> nuevaPreguntaComponent [
	^ self new
]

{ #category : #accessing }
NuevaPreguntaComponent >> crearPregunta [
	self validarIntegridadDatos
		ifTrue: [ self session model
				altaPregunta: titulo
				descripcion: descripcion
				topicos: topicos 
				usuario: self session usuario].
	self answer.
]

{ #category : #accessing }
NuevaPreguntaComponent >> descripcion [
	^ descripcion
]

{ #category : #accessing }
NuevaPreguntaComponent >> descripcion: anObject [
	descripcion := anObject
]

{ #category : #rendering }
NuevaPreguntaComponent >> renderBody: aCanvas [
	aCanvas
		form: [ aCanvas
				table: [ aCanvas
						tableRow: [ aCanvas tableData: [ aCanvas text: 'Titulo' ].
							aCanvas
								tableData: [ aCanvas textInput
										id: 'formInput';
										callback: [ :value | titulo := value ];
										with: 'Escriba aqui el titulo de su pregunta' ] ].
					aCanvas
						tableRow: [ aCanvas tableData: [ aCanvas text: 'Desarrollo' ].
							aCanvas
								tableData: [ aCanvas textArea
										id: 'formInput';
										rows: 10;
										columns: 60;
										callback: [ :value | descripcion := value ];
										with: 'Escriba aqui el desarrollo de su pregunta' ] ].
					aCanvas
						tableRow: [ aCanvas tableData: [ aCanvas text: 'Topicos' ].
							aCanvas
							tableData: [ aCanvas textInput
										id: 'formInput';
										callback: [ :value | topicos := value ];
										with: 'Ingrese los topicos separados por coma' ].
							 ].
					aCanvas
						tableRow: [ aCanvas tableData: [  ].
							aCanvas
								tableData: [ aCanvas submitButton
										callback: [ self crearPregunta ];
										with: 'Guardar'.
									aCanvas submitButton
										callback: [ self answer ];
										with: 'Cancelar' ] ] ] ]
]

{ #category : #rendering }
NuevaPreguntaComponent >> renderContentOn: aCanvas [
	self renderHeader: aCanvas.
	 aCanvas heading with: 'Nueva Pregunta'.
	self renderBody: aCanvas
]

{ #category : #accessing }
NuevaPreguntaComponent >> titulo [
	^ titulo
]

{ #category : #accessing }
NuevaPreguntaComponent >> titulo: anObject [
	titulo := anObject
]

{ #category : #accessing }
NuevaPreguntaComponent >> topicos [
	^ topicos
]

{ #category : #accessing }
NuevaPreguntaComponent >> topicos: anObject [
	topicos := anObject
]

{ #category : #accessing }
NuevaPreguntaComponent >> validarIntegridadDatos [
	titulo ifEmpty: [ ^ false ].
	descripcion ifEmpty: [ ^ false ].
	topicos ifEmpty: [ ^ false ].
	^ true
]
