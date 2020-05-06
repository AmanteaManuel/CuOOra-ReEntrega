Class {
	#name : #PreguntaComponent,
	#superclass : #MasterComponent,
	#instVars : [
		'pregunta'
	],
	#category : #'CuOOra-ui'
}

{ #category : #'instance creation' }
PreguntaComponent class >> newPregunta: unaPregunta [
	^ self new pregunta: unaPregunta.
]

{ #category : #methods }
PreguntaComponent >> agregarRespuesta [
	| unaRespuesta |
	unaRespuesta := Respuesta new.
	self
		call:
			(AgregarRespuestaComponent
				newAgregarRespuesta: unaRespuesta
				para: pregunta)
"		onAnswer:
			(self session model
				altaRespuesta: unaRespuesta
				pregunta: pregunta
				usuario: self session usuario)"
]

{ #category : #accessing }
PreguntaComponent >> initialize [
"setea una pregunta"
"	| tList t p u |
	u := Usuario new.
	tList := OrderedCollection new.
	t := Topico newTopico: 'Objetos' descripcion: 'prueba'.
	tList add: t.
	t := Topico newTopico: 'Pharo' descripcion: 'prueba'.
	tList add: t.
	p := Pregunta
		newPregunta: 'Problemas con pharo'
		descripcion: 'No me anda el seaside'
		topicos: tList.
	pregunta := p"
]

{ #category : #accessing }
PreguntaComponent >> pregunta: unaPregunta [ 
	pregunta := unaPregunta.
]

{ #category : #rendering }
PreguntaComponent >> renderContentOn: aCanvas [
	self renderHeader: aCanvas.
	aCanvas div
		id: 'italicFont';
		with: [ aCanvas heading with: pregunta titulo ].
	self renderPregunta: pregunta canvas: aCanvas.
	aCanvas anchor
		callback: [ self agregarRespuesta ];
		with: [ aCanvas text: '+ Agregar respuesta' ].
	"Mostrar las respuestas:"
	aCanvas horizontalRule.
	aCanvas
		table: [ pregunta obtenerRespuestasPorPuntaje
				do: [ :respuesta | self renderRespuesta: respuesta on: aCanvas ] ]
]

{ #category : #rendering }
PreguntaComponent >> renderPregunta: aCanvas [
	"Este metodo no se usa mas ahora usa el metodo de la master que renderiza la pregunta"

	aCanvas heading with: pregunta titulo.
	aCanvas paragraph with: pregunta descripcion.
	aCanvas div
		with: [ aCanvas paragraph with: 'Topicos: ' , (self topicosComoString:(pregunta topicos)) ].
	aCanvas
		paragraph: [ aCanvas text: 'Realizada por: ' , pregunta usuario nombreUsuario.
			aCanvas anchor callback: [ pregunta usuario ] ].
	aCanvas
		paragraph: [ aCanvas
				render:
					'Likes ' , pregunta cantLikes printString , ' | ' , 'Dislikes '
						, pregunta cantDislikes printString ].
	aCanvas
		paragraph: [ aCanvas anchor
				callback: [ "llamar a darLike" ];
				with: 'Like'.
			aCanvas text: '|'.
			aCanvas anchor
				callback: [ "llamar darDislike" ];
				with: 'Dislike' ].
	aCanvas horizontalRule
]

{ #category : #rendering }
PreguntaComponent >> renderRespuesta: unaRespuesta on: aCanvas [
	aCanvas paragraph
		with: [ aCanvas text: 'Respuesta de '.
			aCanvas anchor
				callback: [ "ver perfil" ];
				with: [ unaRespuesta usuario
						ifNotNil: [ aCanvas text: unaRespuesta usuario nombreUsuario ] ].
			aCanvas break.
			aCanvas text: unaRespuesta descripcion.
			aCanvas
				paragraph: [ aCanvas
						render:
							'Cantidad Likes ' , unaRespuesta cantLikes printString , ' | '
								, 'Cantidad Dislikes ' , unaRespuesta cantDislikes printString ].
			aCanvas
				paragraph: [ aCanvas anchor
						callback: [ self session model altaLike: unaRespuesta de: self session usuario ];
						with: 'Like'.
					aCanvas text: '|'.
					aCanvas anchor
						callback: [ self session model altaDislike: unaRespuesta de: self session usuario ];
						with: 'Dislike' ].
			aCanvas horizontalRule ]
]

{ #category : #rendering }
PreguntaComponent >> style [
	^ '
#tituloPregunta{
 display: block;
 visibility:hidden;
}
#body{
 font-size: 21;						
 text-align: center;			
}		
#italicFont{ font-style: oblique;
}
' , super style
]
