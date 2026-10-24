public with sharing class ClimaService {
    public class ClimaDTO {
        public String cidade;
        public Decimal temperatura;
        public String condicao;
    }
    public class ClimaException extends Exception {}

    @future(callout=true)
    public static void atualizarClimaConta(Id accountId, String cidade) {
        ClimaDTO clima = buscarClima(cidade);
        update new Account(Id = accountId, Description = 'Clima em ' + clima.cidade + ': ' + clima.temperatura + '°C — ' + clima.condicao);
    }

    public static ClimaDTO buscarClima(String cidade) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:ClimaAPI/current?city=' + EncodingUtil.urlEncode(cidade, 'UTF-8'));
        req.setMethod('GET');
        req.setTimeout(10000);
        HttpResponse res = new Http().send(req);
        if (res.getStatusCode() != 200) {
            throw new ClimaException('Erro ao consultar clima: HTTP ' + res.getStatusCode());
        }
        Map<String, Object> body = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        ClimaDTO dto = new ClimaDTO();
        dto.cidade = (String) body.get('city');
        dto.temperatura = (Decimal) body.get('temperature');
        dto.condicao = (String) body.get('condition');
        return dto;
    }
}
