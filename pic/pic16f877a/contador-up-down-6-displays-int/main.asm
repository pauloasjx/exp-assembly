    list p=16f877a
    include <p16f877a.inc>
    
    __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF 
     
    cblock H'20'
    temp_work		    ; utilizado para salvar contexto
    temp_status
    
    ultimo_portb
    temp
    
    mmilhar
    cmilhar
    dmilhar
    milhar
    centena
    dezena
    unidade
    
    endc
    
    org H'0000'
    goto setup
    
    org H'0004'
    
    ; salva contexto **
    movwf temp_work
    swapf STATUS, W
    bcf STATUS, RP0
    movwf temp_status
    
    btfss INTCON, INTF
    goto $+2
    call restart
    
    bcf INTCON, RBIF
    movf PORTB, 0
    
    movwf temp
    xorwf ultimo_portb, 1
    
    btfsc ultimo_portb, 6
    goto rb6
    btfsc ultimo_portb, 7
    goto rb7
    goto exit

rb6:
    btfsc PORTB, RB6
    call inc
    goto exit
    
rb7:
    btfsc PORTB, RB7
    call dec
    goto exit

exit:
    ; retorna contexto **
    bcf INTCON, INTF
    movf  temp, 0
    movwf ultimo_portb
    swapf temp_status, W
    movwf STATUS
    swapf temp_work, F
    swapf temp_work, W
    
    retfie
    
    
setup:			    ; inicialização
    bsf STATUS, RP0
    movlw H'06'
    movwf ADCON1
    movlw H'00'
    movwf TRISA
    movlw H'FF'
    movwf TRISB
    movlw H'00'
    movwf TRISC
    bsf OPTION_REG, INTEDG
    
    bcf STATUS, RP0
    movlw H'98'
    movwf INTCON
    
    bcf PORTB, 1
    bcf PORTB, 6
    bcf PORTB, 7
    

loop:		
    movlw B'00000001'
    movwf PORTC
    movfw unidade
    movwf PORTA
    
    movlw B'00000010'
    movwf PORTC
    movfw dezena
    movwf PORTA
    
    movlw B'00000100'
    movwf PORTC
    movfw centena
    movwf PORTA
    
    movlw B'00001000'
    movwf PORTC
    movfw milhar
    movwf PORTA
    
    movlw B'00010000'
    movwf PORTC
    movfw dmilhar
    movwf PORTA
   
    movlw B'00100000'
    movwf PORTC
    movfw cmilhar
    movwf PORTA
    
    movlw B'01000000'
    movwf PORTC
    movfw mmilhar
    movwf PORTA
    
    goto loop
 
inc:
    incf unidade, F	    ; incrementa o valor da unidade
    movlw H'0A'
    xorwf unidade, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, unidade = 10
    return
    clrf unidade	    ; limpa o valor da unidade
    
    incf dezena, F	    ; incrementa o valor da dezena
    movlw H'0A'
    xorwf dezena, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, dezena = 10
    return
    clrf dezena		    ; limpa o valor da dezena
    
    incf milhar, F	    ; incrementa o valor da milhar
    movlw H'0A'
    xorwf milhar, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, milhar = 10
    return
    
    incf dmilhar, F	    ; incrementa o valor da dezena milhar
    movlw H'0A'
    xorwf dmilhar, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, dezena milhar = 10
    return
    
    incf cmilhar, F	    ; incrementa o valor da centena milhar
    movlw H'0A'
    xorwf cmilhar, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, centena milhar = 10
    return
    
    incf mmilhar, F	    ; incrementa o valor da milhar milhar
    movlw H'0A'
    xorwf mmilhar, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, milhar milhar = 10
    return
    
    clrf mmilhar
    return
    
dec:
    decf unidade, F	    ; decrementa o valor da unidade
    movlw H'FF'
    xorwf unidade, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, unidade = 255
    return
    movlw H'09'		    ; seta unidade como 9
    movwf unidade
    
    decf dezena, F	    ; decrementa o valor da dezena
    movlw H'FF'
    xorwf dezena, W	   
    btfss STATUS, Z	    ; se não houve estouro, ou seja, dezena = 255
    return
    movlw H'09'		    ; seta dezena como 9
    movwf dezena
    
    decf centena, F	    ; decrementa o valor da centena
    movlw H'FF'
    xorwf centena, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, centena = 255
    return
    movlw H'09'		    ; seta centena como 9
    movwf centena
    
    decf milhar, F	    ; decrementa o valor da centena
    movlw H'FF'
    xorwf milhar, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, centena = 255
    return
    movlw H'09'		    ; seta centena como 9
    movwf milhar
    
    decf dmilhar, F	    ; decrementa o valor da centena
    movlw H'FF'
    xorwf dmilhar, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, centena = 255
    return
    movlw H'09'		    ; seta centena como 9
    movwf dmilhar
    
    decf cmilhar, F	    ; decrementa o valor da centena
    movlw H'FF'
    xorwf cmilhar, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, centena = 255
    return
    movlw H'09'		    ; seta centena como 9
    movwf cmilhar
    
    decf mmilhar, F	    ; decrementa o valor da centena
    movlw H'FF'
    xorwf mmilhar, W
    btfss STATUS, Z	    ; se não houve estouro, ou seja, centena = 255
    return
    movlw H'09'		    ; seta centena como 9
    movwf mmilhar
    return
    
restart:
    clrf unidade
    clrf dezena
    clrf centena
    clrf milhar
    clrf dmilhar
    clrf cmilhar
    clrf mmilhar
    return
end