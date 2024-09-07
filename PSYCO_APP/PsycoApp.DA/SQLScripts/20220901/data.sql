USE [DB_TEA]
GO
SET IDENTITY_INSERT [dbo].[tbl_centros_atencion] ON 
GO
INSERT [dbo].[tbl_centros_atencion] ([id_centro_atencion], [centro_atencion], [direccion], [horario], [latitud], [longitud]) VALUES (1, N'Centro Cívico', N'Av. Paseo de la República', N'Todo el día', N'-12.056308', N'-77.037218')
GO
INSERT [dbo].[tbl_centros_atencion] ([id_centro_atencion], [centro_atencion], [direccion], [horario], [latitud], [longitud]) VALUES (2, N'Rambla', N'Av. Javier Prado', N'10:00 - 18:00', N'-12.087802', N'-77.014022')
GO
INSERT [dbo].[tbl_centros_atencion] ([id_centro_atencion], [centro_atencion], [direccion], [horario], [latitud], [longitud]) VALUES (3, N'Plaza Lima Sur', N'Av Paseo de la República', N'10:00 - 21:00', N'-12.173210', N'-77.014127')
GO
SET IDENTITY_INSERT [dbo].[tbl_centros_atencion] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_cita] ON 
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (1, 2, CAST(N'2022-08-05' AS Date), CAST(N'13:00:00' AS Time), 3, 1, CAST(N'2022-08-05T13:10:17.757' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (2, 2, CAST(N'2022-08-05' AS Date), CAST(N'14:00:00' AS Time), 4, 2, CAST(N'2022-08-05T13:11:37.873' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (3, 2, CAST(N'2022-08-12' AS Date), CAST(N'13:00:00' AS Time), 3, 1, CAST(N'2022-08-05T13:14:12.070' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (4, 2, CAST(N'2022-08-04' AS Date), CAST(N'08:00:00' AS Time), 3, 1, CAST(N'2022-08-05T13:21:55.307' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (5, 2, CAST(N'2022-08-26' AS Date), CAST(N'14:00:00' AS Time), 3, 1, CAST(N'2022-08-05T13:38:20.857' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (6, 2, CAST(N'2022-08-26' AS Date), CAST(N'13:00:00' AS Time), 5, 1, CAST(N'2022-08-05T15:26:47.760' AS DateTime))
GO
INSERT [dbo].[tbl_cita] ([id_cita], [id_usuario], [fecha_cita], [hora_cita], [id_doctor_asignado], [id_estado_cita], [fecha_registro]) VALUES (7, 2, CAST(N'2022-09-01' AS Date), CAST(N'10:00:00' AS Time), 3, 1, CAST(N'2022-08-31T22:12:17.580' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_cita] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_encuesta] ON 
GO
INSERT [dbo].[tbl_encuesta] ([id_item], [id_usuario], [puntuacion], [hora], [fecha], [resultado]) VALUES (1, 2, 4, N'15:09:34', N'2021-04-03', N'Detractor')
GO
SET IDENTITY_INSERT [dbo].[tbl_encuesta] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_estados_cita] ON 
GO
INSERT [dbo].[tbl_estados_cita] ([id_estado_cita], [estado_cita], [fecha_registro]) VALUES (1, N'REGISTRADO', CAST(N'2022-08-25T21:45:58.160' AS DateTime))
GO
INSERT [dbo].[tbl_estados_cita] ([id_estado_cita], [estado_cita], [fecha_registro]) VALUES (2, N'ATENDIDO', CAST(N'2022-08-25T21:45:58.163' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_estados_cita] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_flujos] ON 
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (1, 2, N'text', N'Hola, ¿cómo estás?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">19:28</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (2, -1, N'text', N'Hola, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">03:00</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (3, -2, N'text', N'Hola, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola, ¿cómo puedo ayudarte?</div></div><div class="chat-time">15:05</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (4, -2, N'text', N'graciass', N'<li class="reverse"><div class="chat-time">15:05</div><div class="chat-content"><div class="box bg-light-inverse">graciass</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (5, -2, N'text', N'Gracias a Usted! Que tenga un buen día!', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Gracias a Usted! Que tenga un buen día!</div></div><div class="chat-time">15:05</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (6, -2, N'text', N'tengo un problema', N'<li class="reverse"><div class="chat-time">15:06</div><div class="chat-content"><div class="box bg-light-inverse">tengo un problema</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (7, -2, N'text', N'Revise si se encuentra enchufado a la corriente
', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Revise si se encuentra enchufado a la corriente
</div></div><div class="chat-time">15:06</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (8, -2, N'options_title', N'¿Se soluciono?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Se soluciono?</div></div></div><div class="chat-time">15:06</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (9, -2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Confirm'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''LaptoRouter'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (10, -2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">15:06</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (11, -2, N'text', N'Gracias! Por su preferencia
', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Gracias! Por su preferencia
</div></div><div class="chat-time">15:06</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (12, 2, N'text', N'tengo un problema', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">tengo un problema</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (13, 2, N'text', N'Revise si se encuentra enchufado a la corriente
', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Revise si se encuentra enchufado a la corriente
</div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (14, 2, N'options_title', N'¿Se soluciono?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Se soluciono?</div></div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (15, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Confirm'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''LaptoRouter'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (16, 2, N'text', N'Si', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">Si</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (17, 2, N'text', N'Gracias! Por su preferencia
', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Gracias! Por su preferencia
</div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (18, 2, N'text', N'No', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">No</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (19, 2, N'options_title', N'Por favor conecte su laptop al router por cable de red', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Por favor conecte su laptop al router por cable de red</div></div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (20, 2, N'option', N'Si tengo mi cable de Red,No tengo mi cable de Red', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''SiCable'',''Si tengo mi cable de Red'')"><div class="box bg-light-info">Si tengo mi cable de Red</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo mi cable de red'',''No tengo mi cable de Red'')"><div class="box bg-light-info">No tengo mi cable de Red</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (21, 2, N'text', N'No tengo mi cable de red', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">No tengo mi cable de red</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (22, 2, N'options_title', N'Por favor conecte su laptop al router por cable de red', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Por favor conecte su laptop al router por cable de red</div></div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (23, 2, N'option', N'Si tengo mi cable de Red,No tengo mi cable de Red', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''SiCable'',''Si tengo mi cable de Red'')"><div class="box bg-light-info">Si tengo mi cable de Red</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo mi cable de red'',''No tengo mi cable de Red'')"><div class="box bg-light-info">No tengo mi cable de Red</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (24, 2, N'text', N'Si tengo mi cable de Red', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">Si tengo mi cable de Red</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (25, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (26, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (27, 2, N'text', N'Si tengo internet', N'<li class="reverse"><div class="chat-time">15:07</div><div class="chat-content"><div class="box bg-light-inverse">Si tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (28, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:07</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (29, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (30, 2, N'text', N'Si tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">Si tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (31, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (32, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (33, 2, N'text', N'No tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">No tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (34, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (35, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (36, 2, N'text', N'No tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">No tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (37, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (38, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (39, 2, N'text', N'No tengo mi cable de red', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">No tengo mi cable de red</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (40, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (41, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (42, 2, N'text', N'No tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">No tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (43, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (44, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (45, 2, N'text', N'tengo un problema', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">tengo un problema</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (46, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (47, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (48, 2, N'text', N'No tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">No tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (49, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (50, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (51, 2, N'text', N'tengo un problema', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">tengo un problema</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (52, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:08</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (53, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (54, 2, N'text', N'Si tengo internet', N'<li class="reverse"><div class="chat-time">15:08</div><div class="chat-content"><div class="box bg-light-inverse">Si tengo internet</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (55, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (56, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (57, 2, N'text', N'si tengo', N'<li class="reverse"><div class="chat-time">15:09</div><div class="chat-content"><div class="box bg-light-inverse">si tengo</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (58, 2, N'options_title', N'¿Tiene internet?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tiene internet?</div></div></div><div class="chat-time">15:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (59, 2, N'option', N'Si,No', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Si tengo internet'',''Si'')"><div class="box bg-light-info">Si</div></div><div class="chat-content chat-option" onclick="redirect_message(''No tengo internet'',''No'')"><div class="box bg-light-info">No</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (60, 2, N'text', N'gracias', N'<li class="reverse"><div class="chat-time">15:09</div><div class="chat-content"><div class="box bg-light-inverse">gracias</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (61, 2, N'options_title', N'¿Tienes alguna consulta adicional?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">¿Tienes alguna consulta adicional?</div></div></div><div class="chat-time">15:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (62, 2, N'option', N'SI,NINGUNA', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''si_otra_consulta'',''SI'')"><div class="box bg-light-info">SI</div></div><div class="chat-content chat-option" onclick="redirect_message(''ninguna_consulta'',''NINGUNA'')"><div class="box bg-light-info">NINGUNA</div></div></div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (63, 2, N'text', N'No tengo otra consulta', N'<li class="reverse"><div class="chat-time">15:09</div><div class="chat-content"><div class="box bg-light-inverse">No tengo otra consulta</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 0, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (64, 2, N'text', N'Gracias! Por su preferencia', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Gracias! Por su preferencia</div></div><div class="chat-time">15:09</div></li>', 0, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (65, 2, N'text', N'Hola otra vez, ¿cómo puedo ayudarte?', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" alt="user" /></div><div class="chat-content"><div class="box bg-light-success">Hola otra vez, ¿cómo puedo ayudarte?</div></div><div class="chat-time">15:09</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (66, 2, N'text', N'hola', N'<li class="reverse"><div class="chat-time">01:13</div><div class="chat-content"><div class="box bg-light-inverse">hola</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (67, 2, N'text', N'¡Hola! Soy Bankito, tu asistente virtual ??. 
Puedes realizar cualquier consulta de los productos que tenemos disponibles para ti ?? del siguiente menú:', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">¡Hola! Soy Bankito, tu asistente virtual ??. 
Puedes realizar cualquier consulta de los productos que tenemos disponibles para ti ?? del siguiente menú:</div></div><div class="chat-time">01:13</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (68, 2, N'options_title', N'Menu de opciones', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Menu de opciones</div></div></div><div class="chat-time">01:13</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (69, 2, N'option', N'A) Cuentas y número de Cuentas Interbancarias (CCI) ??,B) Tarjetas de Crédito ??,C) Créditos Personales ??,D) Seguros Bancarios ??,E) Estado de Cuenta ??,F) Más Productos y servicios Bancarias ,G) Sugerencias para mejorar el servicio', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Opción A'',''A) Cuentas y número de Cuentas Interbancarias (CCI) ??'')"><div class="box bg-light-info">A) Cuentas y número de Cuentas Interbancarias (CCI) ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción B'',''B) Tarjetas de Crédito ??'')"><div class="box bg-light-info">B) Tarjetas de Crédito ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción C'',''C) Créditos Personales ??'')"><div class="box bg-light-info">C) Créditos Personales ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción D'',''D) Seguros Bancarios ??'')"><div class="box bg-light-info">D) Seguros Bancarios ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción E'',''E) Estado de Cuenta ??'')"><div class="box bg-light-info">E) Estado de Cuenta ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción F'',''F) Más Productos y servicios Bancarias '')"><div class="box bg-light-info">F) Más Productos y servicios Bancarias </div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción G'',''G) Sugerencias para mejorar el servicio'')"><div class="box bg-light-info">G) Sugerencias para mejorar el servicio</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (70, 2, N'text', N'Opción B', N'<li class="reverse"><div class="chat-time">22:21</div><div class="chat-content"><div class="box bg-light-inverse">Opción B</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (71, 2, N'text', N'Disponible : S/.4000
Utilizado : S/.1200
Ultimos Movimientos:
-Pago otros bancos     S/.400,00  08/11/2021
-Compras Adidas        S/.500,00  08/11/2021 
-Pago Tarjeta                S/.300,00  08/11/2021 
Fecha Pago : 05 de cada mes
*Tienes una promoción para agrandar tu crédito, comunícate por whatsapp al 957705114', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Disponible : S/.4000
Utilizado : S/.1200
Ultimos Movimientos:
-Pago otros bancos     S/.400,00  08/11/2021
-Compras Adidas        S/.500,00  08/11/2021 
-Pago Tarjeta                S/.300,00  08/11/2021 
Fecha Pago : 05 de cada mes
*Tienes una promoción para agrandar tu crédito, comunícate por whatsapp al 957705114</div></div><div class="chat-time">22:21</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (72, 2, N'text', N'hola', N'<li class="reverse"><div class="chat-time">22:23</div><div class="chat-content"><div class="box bg-light-inverse">hola</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (73, 2, N'options_title', N'Menu de opciones', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="chat-content" style="margin-bottom: -10px;"><div class="box bg-light-success">Menu de opciones</div></div></div><div class="chat-time">22:23</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (74, 2, N'text', N'¡Hola! Soy Bankito, tu asistente virtual ??. 
Puedes realizar cualquier consulta de los productos que tenemos disponibles para ti ?? del siguiente menú:', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">¡Hola! Soy Bankito, tu asistente virtual ??. 
Puedes realizar cualquier consulta de los productos que tenemos disponibles para ti ?? del siguiente menú:</div></div><div class="chat-time">22:23</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (75, 2, N'option', N'A) Cuentas y número de Cuentas Interbancarias (CCI) ??,B) Tarjetas de Crédito ??,C) Créditos Personales ??,D) Seguros Bancarios ??,E) Estado de Cuenta ??,F) Más Productos y servicios Bancarias ,G) Sugerencias para mejorar el servicio', N'<li style="margin-top: 10px;"><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class="invisible-element"/></div><div class="chat-content"><div class="chat-content chat-option" onclick="redirect_message(''Opción A'',''A) Cuentas y número de Cuentas Interbancarias (CCI) ??'')"><div class="box bg-light-info">A) Cuentas y número de Cuentas Interbancarias (CCI) ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción B'',''B) Tarjetas de Crédito ??'')"><div class="box bg-light-info">B) Tarjetas de Crédito ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción C'',''C) Créditos Personales ??'')"><div class="box bg-light-info">C) Créditos Personales ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción D'',''D) Seguros Bancarios ??'')"><div class="box bg-light-info">D) Seguros Bancarios ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción E'',''E) Estado de Cuenta ??'')"><div class="box bg-light-info">E) Estado de Cuenta ??</div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción F'',''F) Más Productos y servicios Bancarias '')"><div class="box bg-light-info">F) Más Productos y servicios Bancarias </div></div><div class="chat-content chat-option" onclick="redirect_message(''Opción G'',''G) Sugerencias para mejorar el servicio'')"><div class="box bg-light-info">G) Sugerencias para mejorar el servicio</div></div></div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (76, 2, N'text', N'Opción B', N'<li class="reverse"><div class="chat-time">22:23</div><div class="chat-content"><div class="box bg-light-inverse">Opción B</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (77, 2, N'text', N'Disponible : S/.4000
Utilizado : S/.1200
Ultimos Movimientos:
-Pago otros bancos     S/.400,00  08/11/2021
-Compras Adidas        S/.500,00  08/11/2021 
-Pago Tarjeta                S/.300,00  08/11/2021 
Fecha Pago : 05 de cada mes
*Tienes una promoción para agrandar tu crédito, comunícate por whatsapp al 957705114', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Disponible : S/.4000
Utilizado : S/.1200
Ultimos Movimientos:
-Pago otros bancos     S/.400,00  08/11/2021
-Compras Adidas        S/.500,00  08/11/2021 
-Pago Tarjeta                S/.300,00  08/11/2021 
Fecha Pago : 05 de cada mes
*Tienes una promoción para agrandar tu crédito, comunícate por whatsapp al 957705114</div></div><div class="chat-time">22:23</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (78, 2, N'text', N'Opción F', N'<li class="reverse"><div class="chat-time">22:24</div><div class="chat-content"><div class="box bg-light-inverse">Opción F</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (79, 2, N'text', N'El servicio de Chatbot no responde. Vuelva a intentarlo', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">El servicio de Chatbot no responde. Vuelva a intentarlo</div></div><div class="chat-time">22:24</div></li>', 1, N'bot')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (80, 2, N'text', N'Opción E', N'<li class="reverse"><div class="chat-time">22:24</div><div class="chat-content"><div class="box bg-light-inverse">Opción E</div></div><div class="chat-img"><img src="https://icons.iconarchive.com/icons/graphicloads/flat-finance/256/person-icon.png" /></div></li>', 1, N'person')
GO
INSERT [dbo].[tbl_flujos] ([id_flujo], [id_usuario], [tipo], [contenido_texto], [contenido_html], [habilitado], [remitente]) VALUES (81, 2, N'text', N'Le brindamos el saldo de sus cuentas actuales.', N'<li><div class="chat-img"><img src="https://freesvg.org/img/1538298822.png" class=""/></div><div class="chat-content"><div class="box bg-light-success">Le brindamos el saldo de sus cuentas actuales.</div></div><div class="chat-time">22:24</div></li>', 1, N'bot')
GO
SET IDENTITY_INSERT [dbo].[tbl_flujos] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_invitados] ON 
GO
INSERT [dbo].[tbl_invitados] ([id_invitado], [linea], [id_tipolinea]) VALUES (-2, N'123123123', 1)
GO
INSERT [dbo].[tbl_invitados] ([id_invitado], [linea], [id_tipolinea]) VALUES (-1, N'98769876', 2)
GO
SET IDENTITY_INSERT [dbo].[tbl_invitados] OFF
GO
INSERT [dbo].[tbl_menu] ([id_padre], [id_opcion], [opcion], [posicion], [icono], [url], [habilitado]) VALUES (N'00', N'01  ', N'ADMINISTRACION', 1, N'mdi mdi-gauge', N'', 1)
GO
INSERT [dbo].[tbl_menu] ([id_padre], [id_opcion], [opcion], [posicion], [icono], [url], [habilitado]) VALUES (N'01', N'02  ', N'Visitas', 1, N'mdi mdi-gauge', N'Home', 1)
GO
INSERT [dbo].[tbl_menu] ([id_padre], [id_opcion], [opcion], [posicion], [icono], [url], [habilitado]) VALUES (N'01', N'03  ', N'Reportes', 1, N'mdi mdi-gauge', N'Reportes', 1)
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (1, N'ENERO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (2, N'FEBRERO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (3, N'MARZO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (4, N'ABRIL')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (5, N'MAYO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (6, N'JUNIO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (7, N'JULIO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (8, N'AGOSTO')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (9, N'SETIEMBRE')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (10, N'OCTUBRE')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (11, N'NOVIEMBRE')
GO
INSERT [dbo].[tbl_meses] ([num_mes], [mes]) VALUES (12, N'DICIEMBRE')
GO
INSERT [dbo].[tbl_opciones_usuario] ([id_usuario], [id_tipousuario], [id_opcion], [habilitado]) VALUES (1, 1, N'01', 1)
GO
INSERT [dbo].[tbl_opciones_usuario] ([id_usuario], [id_tipousuario], [id_opcion], [habilitado]) VALUES (1, 1, N'02', 1)
GO
INSERT [dbo].[tbl_opciones_usuario] ([id_usuario], [id_tipousuario], [id_opcion], [habilitado]) VALUES (1, 1, N'03', 1)
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-10-18T18:17:45.190' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-07T21:15:15.290' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'CALL-CENTER', N'CLIENTE', CAST(N'2020-11-07T21:26:01.613' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-07T21:30:22.330' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-09T23:23:33.793' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-09T23:24:57.120' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-09T23:26:42.620' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-09T23:27:37.190' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-13T09:01:27.710' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2020-11-13T09:04:13.883' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'NO CLIENTE', CAST(N'2020-11-20T19:04:29.557' AS DateTime))
GO
INSERT [dbo].[tbl_puntos_visitados] ([punto_visitado], [visitante], [fecha_visita]) VALUES (N'WHATSAPP', N'CLIENTE', CAST(N'2022-05-23T22:11:58.780' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_resumen_flujo] ON 
GO
INSERT [dbo].[tbl_resumen_flujo] ([id_item], [id_usuario], [resultado]) VALUES (1, 2, N'GRACIAS')
GO
SET IDENTITY_INSERT [dbo].[tbl_resumen_flujo] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_tipolinea] ON 
GO
INSERT [dbo].[tbl_tipolinea] ([id_tipolinea], [tipolinea]) VALUES (1, N'Móvil')
GO
INSERT [dbo].[tbl_tipolinea] ([id_tipolinea], [tipolinea]) VALUES (2, N'Fija')
GO
SET IDENTITY_INSERT [dbo].[tbl_tipolinea] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_tipousuario] ON 
GO
INSERT [dbo].[tbl_tipousuario] ([id_tipousuario], [tipousuario]) VALUES (1, N'Admin')
GO
INSERT [dbo].[tbl_tipousuario] ([id_tipousuario], [tipousuario]) VALUES (2, N'Cliente')
GO
INSERT [dbo].[tbl_tipousuario] ([id_tipousuario], [tipousuario]) VALUES (3, N'Doctor')
GO
SET IDENTITY_INSERT [dbo].[tbl_tipousuario] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_usuario] ON 
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email]) VALUES (1, N'Martin', N'Aguirre', 1, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'11111111', N'admin@abc.com')
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email]) VALUES (2, N'Juan', N'Marca', 2, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'22222222', N'cliente@abc.com')
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email]) VALUES (3, N'Dr Luis', N'Ortiz', 3, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'33333333', N'doc1@abc.com')
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email]) VALUES (4, N'Dr Daniel', N'Espinoza', 3, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'44444444', N'doc2@abc.com')
GO
INSERT [dbo].[tbl_usuario] ([id_usuario], [nombres], [apellidos], [id_tipousuario], [password], [habilitado], [tipo_documento], [num_documento], [email]) VALUES (5, N'Dr Felipe', N'Ugarte', 3, 0x01000000639CDBDD6A636021E0C9DD5C848990FDF573A7847EF50B7E, 1, N'DNI', N'55555555', N'doc3@abc.com')
GO
SET IDENTITY_INSERT [dbo].[tbl_usuario] OFF
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T17:01:22.340' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T17:08:28.523' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-18T17:10:28.167' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-18T18:03:50.630' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-18T18:17:22.860' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-18T20:05:46.383' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T20:31:08.837' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-18T21:06:55.187' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T22:03:27.740' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T22:10:19.307' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T22:41:39.900' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T22:45:25.140' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T22:53:15.087' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T23:31:33.050' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-29T15:03:32.530' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-10-29T15:14:06.697' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-29T15:14:43.107' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-07T21:13:44.420' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-07T21:25:33.137' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-07T21:26:24.060' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-07T21:33:29.410' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-07T21:37:26.410' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-09T23:23:15.430' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-09T23:24:44.140' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-09T23:26:29.413' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T07:18:30.257' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T07:23:40.253' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T07:25:29.783' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T07:57:54.527' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T08:42:02.010' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T09:07:06.500' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-16T21:21:46.403' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-16T23:10:22.693' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-16T23:19:03.200' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-16T23:25:20.510' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-16T23:38:34.117' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T00:03:48.243' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T01:13:57.937' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T02:25:05.823' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T09:21:02.403' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T18:40:27.193' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-20T19:04:13.410' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T21:09:52.207' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T21:19:27.397' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T21:56:19.180' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T02:43:07.653' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T05:10:59.140' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:07:40.880' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:25:19.447' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:58:50.423' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T13:14:03.230' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T13:28:45.530' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T13:36:17.780' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T15:37:14.417' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T15:39:25.890' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T15:50:43.737' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T15:52:22.477' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T15:57:01.113' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T16:29:40.193' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T17:10:11.080' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T19:14:30.257' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T19:27:21.433' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T23:44:06.047' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T01:56:49.433' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T02:05:00.840' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T02:53:43.643' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T03:10:56.497' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T10:36:37.360' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T13:36:40.570' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T13:55:27.627' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T14:11:55.133' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T14:31:00.313' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T15:06:50.770' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T15:20:21.707' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T15:36:06.803' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T15:55:08.080' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T16:04:37.290' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T16:12:31.720' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T16:46:30.163' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T17:08:12.767' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T17:26:12.120' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T17:38:22.640' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T17:51:28.963' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T20:53:09.323' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T20:54:49.463' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T21:05:41.677' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T21:13:05.033' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T21:45:12.043' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T21:58:47.307' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T22:29:11.257' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T22:46:39.710' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T22:49:59.540' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T23:02:21.300' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T02:05:55.477' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T16:44:47.490' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T21:13:23.830' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T22:19:29.493' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T22:25:53.457' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T22:41:53.920' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T22:45:51.487' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T23:33:19.970' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T01:00:24.520' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T01:26:57.143' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T01:29:40.093' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T01:35:35.050' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T01:36:22.670' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T02:23:25.300' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T02:25:34.503' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T02:35:43.340' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T02:40:39.080' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T02:48:25.263' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T15:39:03.060' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T15:40:12.410' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T20:10:02.403' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T20:21:09.610' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T22:18:46.113' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T22:51:06.400' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T22:54:42.407' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:30:25.330' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:33:47.340' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:42:56.480' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:44:30.310' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:48:41.383' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T00:07:46.973' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2021-04-03T15:05:15.093' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2021-04-03T15:06:57.080' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:13:24.350' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:15:08.037' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:16:22.953' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:19:10.560' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:20:29.630' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T21:08:52.680' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T21:16:25.420' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T23:54:18.203' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T22:57:45.740' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T22:59:02.170' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T23:14:16.510' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T03:55:23.450' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T05:21:50.497' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:08:07.293' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T04:38:33.267' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T00:40:51.583' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T00:41:25.560' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T21:29:52.073' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-10-18T21:44:39.617' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T08:31:48.800' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T01:32:43.563' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T10:09:54.467' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T20:37:36.750' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T17:10:27.890' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T21:35:07.223' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T00:33:36.527' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T00:59:12.530' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T15:20:47.543' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T15:58:54.300' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T16:27:13.630' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T16:27:42.473' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T17:48:30.920' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T22:42:46.770' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T00:43:30.140' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T00:57:38.527' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T01:50:23.573' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-25T01:58:01.160' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T02:11:14.277' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-25T03:00:25.997' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T03:06:18.637' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T03:13:22.090' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T03:21:55.013' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:39:53.287' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:46:16.187' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2022-05-20T01:52:41.777' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-13T09:21:14.007' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T01:53:20.590' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T02:41:21.250' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-17T03:46:46.387' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T18:02:16.027' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T20:31:42.950' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T20:45:05.333' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T20:50:08.987' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T22:21:08.880' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T03:19:49.460' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T03:33:57.957' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T04:17:06.720' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T05:46:55.307' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:22:09.040' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:23:09.750' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:26:54.440' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T12:46:27.050' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T13:04:07.460' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T19:26:59.183' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T20:26:55.457' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T22:54:56.687' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-21T23:01:18.810' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T01:06:56.693' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T02:38:10.163' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T03:36:41.920' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T03:40:00.367' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T14:40:09.000' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T14:53:16.873' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T22:18:46.590' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T23:01:53.800' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-22T23:02:51.143' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T00:42:21.877' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T00:50:46.443' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T02:56:52.873' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T03:18:26.580' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-23T22:48:13.713' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T21:55:16.333' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:06:05.277' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'NO CLIENTE', CAST(N'2020-11-24T23:12:42.500' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-25T01:56:50.127' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-20T22:54:41.180' AS DateTime))
GO
INSERT [dbo].[tbl_visitas] ([visitante], [fecha_visita]) VALUES (N'CLIENTE', CAST(N'2020-11-24T23:07:22.693' AS DateTime))
GO
