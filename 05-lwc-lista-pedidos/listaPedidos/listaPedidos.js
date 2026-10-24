import { LightningElement, api, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import listarPedidos from '@salesforce/apex/PedidoController.listarPedidos';
import totalVendido from '@salesforce/apex/PedidoController.totalVendido';

const COLUNAS = [
    { label: 'Número', fieldName: 'numero', type: 'text' },
    { label: 'Status', fieldName: 'status', type: 'text' },
    { label: 'Data', fieldName: 'dataPedido', type: 'date' },
    { label: 'Total', fieldName: 'total', type: 'currency', typeAttributes: { currencyCode: 'BRL' } },
    { type: 'button', typeAttributes: { label: 'Abrir', name: 'abrir', variant: 'base' } }
];

export default class ListaPedidos extends NavigationMixin(LightningElement) {
    // Recebido automaticamente quando o componente está numa página de registro
    @api recordId;

    @track pedidos = [];
    @track termoBusca = '';
    @track erro = false;

    colunas = COLUNAS;

    @wire(listarPedidos, { accountId: '$recordId' })
    pedidosWire({ error, data }) {
        if (data) {
            this.pedidos = data;
            this.erro = false;
        } else if (error) {
            this.pedidos = [];
            this.erro = true;
        }
    }

    @wire(totalVendido, { accountId: '$recordId' })
    totalWire;

    get totalVendido() {
        return this.totalWire.data || 0;
    }

    get carregando() {
        return !this.totalWire.data && !this.totalWire.error && this.pedidos.length === 0 && !this.erro;
    }

    get pedidosFiltrados() {
        const termo = this.termoBusca.trim().toLowerCase();
        if (!termo) return this.pedidos;
        return this.pedidos.filter((p) =>
            (p.numero || '').toLowerCase().includes(termo) ||
            (p.status || '').toLowerCase().includes(termo)
        );
    }

    get temPedidos() {
        return !this.erro && this.pedidosFiltrados.length > 0;
    }

    get semPedidos() {
        // Mostra a mensagem vazia só depois que o total já carregou (ou seja, a consulta terminou)
        return !this.erro && this.pedidosFiltrados.length === 0 && this.totalWire.data !== undefined;
    }

    get quantidadeExibida() {
        return this.pedidosFiltrados.length;
    }

    get quantidadeTotal() {
        return this.pedidos.length;
    }

    handleBusca(event) {
        this.termoBusca = event.target.value;
    }

    handleLinha(event) {
        const pedidoId = event.detail.row.id;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: { recordId: pedidoId, actionName: 'view' }
        });
    }
}
