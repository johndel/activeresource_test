#### Notes to my future self that would wondering what this is all about

Simple test to see how activeresource works, if it needs ActiveResource::HttpMock or if it can play nicely with VCR. Seems like VCR works correctly, HTTPMock doesn't intefer and the tests records all the API requests automatically, either from model or from feature spec. Remoteapp should run on `localhost:3001` (or change it on the fetcherapp).
