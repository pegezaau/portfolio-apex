import { createElement } from '@lwc/engine-dom';
import ListaPedidos from 'c/listaPedidos';
import listarPedidos from '@salesforce/apex/PedidoController.listarPedidos';
import totalVendido from '@salesforce/apex/PedidoController.totalVendido';

jest.mock(
    '@salesforce/apex/PedidoController.listarPedidos',
    () => ({ default: jest.fn() }),
    { virtual: true }
);
jest.mock(
    '@salesforce/apex/PedidoController.totalVendido',
    () => ({ default: jest.fn() }),
    { virtual: true }
);

const PEDIDOS = [
    { id: '801xx000001', numero: '00000123', status: 'Activated', total: 1500, dataPedido: '2026-10-20' },
    { id: '801xx000002', numero: '00000124', status: 'Draft', total: 300, dataPedido: '2026-10-21' }
];

async function flush() {
    return Promise.resolve();
}

describe('c-lista-pedidos', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });

    it('exibe os pedidos retornados pelo Apex', async () => {
        listarPedidos.mockResolvedValue(PEDIDOS);
        totalVendido.mockResolvedValue(1800);

        const element = createElement('c-lista-pedidos', { is: ListaPedidos });
        element.recordId = '001xx000001';
        document.body.appendChild(element);
        await flush();

        const tabela = element.shadowRoot.querySelector('lightning-datatable');
        expect(tabela).not.toBeNull();
        expect(tabela.data).toEqual(PEDIDOS);
    });

    it('filtra pedidos pela busca', async () => {
        listarPedidos.mockResolvedValue(PEDIDOS);
        totalVendido.mockResolvedValue(1800);

        const element = createElement('c-lista-pedidos', { is: ListaPedidos });
        element.recordId = '001xx000001';
        document.body.appendChild(element);
        await flush();

        const busca = element.shadowRoot.querySelector('lightning-input');
        busca.value = 'Draft';
        busca.dispatchEvent(new CustomEvent('change'));
        await flush();

        const tabela = element.shadowRoot.querySelector('lightning-datatable');
        expect(tabela.data).toHaveLength(1);
        expect(tabela.data[0].status).toBe('Draft');
    });
});
