@isTest
private class ClimaServiceTest {
    private class ClimaMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"city":"São Paulo","temperature":24.5,"condition":"Ensolarado"}');
            return res;
        }
    }

    @isTest static void deveDesserializarResposta() {
        Test.setMock(HttpCalloutMock.class, new ClimaMock());
        Test.startTest();
        ClimaService.ClimaDTO clima = ClimaService.buscarClima('São Paulo');
        Test.stopTest();
        System.assertEquals('São Paulo', clima.cidade);
        System.assertEquals(24.5, clima.temperatura);
        System.assertEquals('Ensolarado', clima.condicao);
    }
}
