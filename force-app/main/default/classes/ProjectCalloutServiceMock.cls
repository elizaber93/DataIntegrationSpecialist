public class ProjectCalloutServiceMock implements HttpCalloutMock {
   public HTTPResponse respond(HTTPRequest req) {
       	System.assertEquals('https://sb-integration-pms-2.herokuapp.com/projects', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
       	
       	res.setStatus('OK');
        res.setStatusCode(201);
        return res;
    }
}