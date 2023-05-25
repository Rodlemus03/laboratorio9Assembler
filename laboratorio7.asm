;Universidad del Valle de Guatemala
;Mauricio Lemus 22461
;Oscar Fuentes 22763
;
;
;Laboratorio 9 
;
;Catedratico: Roger Fuentes


.386 ; 
.model flat, stdcall, c ; 
.stack 4096 ; 

ExitProcess proto,dwExitCode:dword ;

.data


	arregloMes BYTE 'ENE  ',0,'FEB  ',0,'MAR  ',0,'APR  ',0,'MAY  ',0,'JUN  ',0,'JUL  ',0,'AGO  ',0,'SEP  ',0,'OCT  ',0,'NOV  ',0,'DIC  ',0
	montoNIT byte "INGRESE EL NIT: ", 0
	arregloMonto dword 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	formatoDato db "%d ", 0AH,0
	entrada db "%d", 0
	Total dword 0
	diviiiii dword 20
	mensajePequenio BYTE 'REGIMEN PEQUEÑO CONTRIBUYENTE', 0Ah, 0
	mensajeGeneral BYTE 'REGIMEN GENERAL', 0Ah, 0
	formatoImpresion BYTE " %s -+- %d  -+- %d  -+-   %d   -+-", 0Ah, 0
	res BYTE 'MONTO MENSUAL: ', 0Ah,0
	arregloIvas dword 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	vac db " ", 0ah, 0
	suma dword 0
	NIT dword 0
	IVA dword 0
	encabezado db "-+-  MES  -+- NIT   -+- IVA  -+- MONTO_F -+- ",0AH, 0


.code 

.code 

    includelib libucrt.lib ; 
    includelib legacy_stdio_definitions.lib ; 
    includelib libcmt.lib ; 
    includelib libvcruntime.lib ; 

	extrn printf:near
	extrn scanf:near
	extrn exit:near


public main 
main proc 
	mov ebx, offset arregloMonto
	mov esi, sizeof arregloMonto
	push offset montoNIT					
	call printf								
	add esp, 4								
	lea eax, [ebp-4]						
	push eax								
	push offset entrada						
	call scanf								
	add esp, 8								
	mov eax, [ebp-4]						
	mov NIT, eax
	push eax								
	push offset vac					
	call printf								
	add esp, 8		


label1: 
	push offset res		 
	call printf	
	lea eax, [ebx]							
	push eax								
	push offset formatoDato							
	add Total, eax
	call scanf								
	add ebx, 4 
	sub esi, 4
	cmp esi, 0
	JNE label1
    mov esi, offset arregloMonto
    mov ebx, sizeof arregloMonto
    mov edi, offset arregloMes
	push offset encabezado	
	call printf		


label2:
	mov eax, [esi]							 
	push eax								 
	mov edx, 0
	mov ecx, diviiiii
	div ecx
	mov IVA, eax
	push IVA
	push NIT
	mov eax, edi
	push edi
	push offset formatoImpresion					
	call printf
	sub ebx, 4								
	add esi, 4								
	add edi, 6
	cmp ebx,0								
	jne label2								
	push offset vac
	call printf 
.IF Total > 150000
		push offset mensajeGeneral
		call printf
.ELSE 
		push offset mensajePequenio
		call printf
.ENDIF
	push offset vac
	call printf  
salir:
	push 0                    
    call exit                  

main endp
end