*** Settings ***
resource          ../resource/Checkbox.robot
Test Setup        Abrir navegador
Test Teardown     Fechar navegador

*** Test Case ***


#informar quais itens deve ser procurado na lista como marcado passar como argumento 
Cenario 1 - Testes
    Captura quantidade de checkbox da tela       Lettuce    Tomato        
    Valida se houve sucesso na comparação 