Class {
	#name : #MasterComponent,
	#superclass : #WAComponent,
	#category : #'CuOOra-ui'
}

{ #category : #rendering }
MasterComponent >> logOut [
	self session unregister.
	self requestContext redirectTo: self application url. 
]

{ #category : #rendering }
MasterComponent >> renderHeader: aCanvas [
	aCanvas div
		id: 'titulo';
		with: [ aCanvas heading with: 'CuOOra'.
			aCanvas div
				id: 'usuarioencabezado';
				with: [
					aCanvas label with: 'Usuario: ' .
					aCanvas anchor
					id:'perfilUri';
						callback: [self call: (PerfilComponent newPerfil: (self session usuario))];
						with:[
					aCanvas
						render:self session usuario nombreUsuario].
					aCanvas space.
					aCanvas space.
					aCanvas anchor
						callback: [ self call: HomeComponent new ];
						with: 'Home'.
						aCanvas space.
						aCanvas space.
					aCanvas anchor
						callback: [ self logOut ];
						with: 'Log Out' ] ].
	aCanvas horizontalRule.
	aCanvas break
]

{ #category : #rendering }
MasterComponent >> renderPregunta: pregunta canvas: aCanvas [
	aCanvas div
		id: 'tituloPregunta';
		with: [ aCanvas anchor
				callback: [ self call: (PreguntaComponent newPregunta: pregunta) ];
				with: pregunta titulo ].
	aCanvas div
		with: [ aCanvas paragraph with: 'Topicos: ' , (self topicosComoString:(pregunta topicos)) ].
	aCanvas
		paragraph: [ aCanvas render: 'Realizada por: '.
			aCanvas anchor				
				callback: [ self call: (PerfilComponent newPerfil: pregunta usuario) ];
				with: pregunta usuario nombreUsuario ].
	aCanvas
		paragraph: [ aCanvas
				render: pregunta cantidadRespuestas printString , ' Respuestas' ].
	aCanvas
		paragraph: [ aCanvas
				render:
					'Cantidad Likes ' , pregunta cantLikes printString , ' | '
						, 'Cantidad Dislikes ' , pregunta cantDislikes printString ].
	aCanvas
		paragraph: [ aCanvas anchor
				callback: [ self session model altaLike: pregunta de: self session usuario];
				with: 'Like'.
			aCanvas text: '|'.
			aCanvas anchor
				callback: [ self session model altaDislike: pregunta de: self session usuario ];
				with: 'Dislike' ]
]

{ #category : #rendering }
MasterComponent >> style [
	^ '
	#usuarioencabezado{
		text-align:right;
		margin-right:50px;
		font-weight: bold;
	}
	
	#btnFallow{
	text-align:right;
	margin-right:50px
	}
	
	#titulo{
				font-size: 21;						
		 		text-align: center;
			}
	#tituloPregunta{}
	#nombreOwnerPregunta{ text-decoration: overline;}
	#formInput{ width: 100%;}
	#perfilUri{
	color: #3399ff;
	font-weight: bold;
	}
	'
]

{ #category : #rendering }
MasterComponent >> topicosComoString:topicosList [
	^ (topicosList collect: [ :each | each nombre ]) asCommaString.
]
