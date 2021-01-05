*** Settings ***
resource          ../resource/Checkbox.robot
Test Setup        Abrir navegador
Test Teardown     Fechar navegador

*** Test Case ***


#Informar quais itens deve ser verificar nos checkbox 
Cenario 1 - Testes
    Verificar Checkbox da pagina selecionada       Lettuce    Tomato        
    Valida se houve sucesso na comparação 