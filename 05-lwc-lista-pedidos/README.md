# 05 — LWC real: Lista de Pedidos

Componente Lightning Web Component **de verdade** (não só o backend) que mostra os pedidos de uma conta direto na página do registro no Salesforce.

Ele completa o projeto 04: usa o `PedidoController` já existente (`listarPedidos` e `totalVendido`) e entrega a interface que o usuário final vê.

## ✨ O que a tela faz

- Mostra os pedidos da conta em uma tabela (`lightning-datatable`) com número, status, data e total
- Mostra o **total vendido** da conta em destaque no cabeçalho
- Tem **busca/filtro** por número ou status do pedido, digitando na hora
- Mostra estado de carregamento (spinner), mensagem quando não há pedidos e mensagem de erro amigável se a consulta falhar
- Ao clicar numa linha, abre o pedido (navegação padrão do Salesforce)

## 🧩 Arquivos

| Arquivo | Papel |
|---------|-------|
| `listaPedidos/listaPedidos.html` | Template: cartão, busca, tabela, total e estados |
| `listaPedidos/listaPedidos.js` | Lógica: `@wire` para buscar pedidos e total, filtro em memória, navegação |
| `listaPedidos/listaPedidos.css` | Estilos do cabeçalho e do total |
| `listaPedidos/listaPedidos.js-meta.xml` | Expõe o componente para página de registro de Conta, App Page e Home |
| `listaPedidos/__tests__/listaPedidos.test.js` | Teste Jest: verifica renderização, total e filtro |

## 🚀 Como implantar (Salesforce DX)

Copie as pastas para a estrutura de um projeto SFDX e faça o deploy:

```bash
# Estrutura esperada
# force-app/main/default/lwc/listaPedidos/
# force-app/main/default/classes/PedidoController.cls  (do projeto 04)

sf project deploy start --source-dir force-app/main/default/lwc/listaPedidos
sf project deploy start --source-dir force-app/main/default/classes/PedidoController.cls
```

Depois, no Lightning App Builder, abra uma página de registro de **Account** e arraste o componente **Lista de Pedidos** para a página. Ele recebe o `recordId` da conta automaticamente.

## 🧪 Como rodar o teste Jest

```bash
sf lightning lwc test run -- --testPathPattern=listaPedidos
```

## 🔗 Backend usado

- `PedidoController.listarPedidos(accountId)` — `@AuraEnabled(cacheable=true)`
- `PedidoController.totalVendido(accountId)` — `@AuraEnabled(cacheable=true)`

Ambos estão em `../04-servico-pedidos-lwc/PedidoController.cls`.
