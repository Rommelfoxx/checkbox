*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections 

*** Variables ***

${BROWSER}    chrome
#URL que contem a checkbox a ser mapeada 
${URL_CHECKBOX}                   https://www.w3.org/TR/wai-aria-practices-1.1/examples/checkbox/checkbox-1/checkbox-1.html
#mapeamento do elemento das checkbox mapear elemento de forma generica o mopeamento deve mostrar todos os checkbox 
${ELEMENT_CHECKBOX}               xpath=(//*[@role="checkbox"])
@{CHECKBOX}             
${NOME_CHECKBOX}
@{QTD_SUCESSO}
@{CHECKBOX_ENCONTRADO}


*** Keywords ***

Abrir navegador
        Open Browser    url:    ${BROWSER}


Fechar navegador
        Capture Page Screenshot
        Close Browser
        
Verificar Checkbox da pagina selecionada 
  
    #Recebe por argumentos quais são os checkbox que devem ser validados
    [Arguments]     @{CHECKBOX}

    Set Suite Variable   @{CHECKBOX}    @{CHECKBOX}
    #Coloca valor das checkbox que serão validadas dentro da lista @{CHECKBOX}

    GO TO   ${URL_CHECKBOX}
    
    #Numero de checkbox da pagina que serão verificados 
    ${numero}=  Get Element Count   ${ELEMENT_CHECKBOX}


     #For para buscar em todos os checkbox da pagina 
     FOR  ${indice}  IN RANGE  1  ${numero}+1
     
         #Monta locator de cada checkbox e quarda na variavel ELEMENT_CHECKBOX_FINAL
        ${ELEMENT_CHECKBOX_FINAL}=  set variable  ${ELEMENT_CHECKBOX} [${indice}]
      
         #Captura o nome de cada checkbox da pagina 
         ${texto}=  Get WebElement   ${ELEMENT_CHECKBOX_FINAL}  
         #Armazena o nome das checkbox na variavel ${NOME_CHECKBOX}
         Set Suite Variable   ${NOME_CHECKBOX}   ${texto.text}
     
         Compara nomes das checkbox com valores informados  
    
     END



Compara nomes das checkbox com valores informados  
      
     #Avalia o nome do checkbox e compara com valores informados pelo argumento 
     ${numero_checkbox}=    Get length    ${CHECKBOX} 

     FOR  ${indice_checkbox}  IN RANGE  0  ${numero_checkbox}

      #Quarda na lista todos os itens encotrados para comparação posterior na lista @{CHECKBOX_ENCONTRADO}
      Run Keyword If    '${CHECKBOX}[${indice_checkbox}]'=='${NOME_CHECKBOX}'  Append To List  ${CHECKBOX_ENCONTRADO}    ${NOME_CHECKBOX}


    END

  
Valida se houve sucesso na comparação 
  
  #Mostra quantidade de itens encotrado para comparação de sucesso ou falha 
     ${numero_sucesso}=    Get length    ${CHECKBOX_ENCONTRADO} 
    
     ${numero_checkbox}    Get length    ${CHECKBOX}  

     Run Keyword If     ${numero_sucesso} == ${numero_checkbox}    log to console   "Pagina contem as checkbox informadas"   ELSE   Fail    Pagina não contem as checkbox informadas    

 