---
aliases:
  - ConstraintViolationException
  - ServerExceptionMapper
  - ExceptionHandler
tags:
  - зрелость/🌱
date:
  - - 2024-03-03
zero-link:
  - "[[Quarkus]]"
parents: 
linked: 
---
Для обычной обработки исключений достаточно  вот такого класса

```java
package dev.struchkov.network.controller.rest;  
  
import dev.struchkov.network.controller.rest.schema.error.ErrorMessage;  
import dev.struchkov.network.exception.NotFoundException;  
import dev.struchkov.network.exception.SocialNetworkException;  
import jakarta.ws.rs.core.Response;  
import org.jboss.resteasy.reactive.RestResponse;  
import org.jboss.resteasy.reactive.server.ServerExceptionMapper;  
  
public class ExceptionHandler {  
  
    @ServerExceptionMapper  
    public RestResponse<ErrorMessage> mapException(RuntimeException e) {  
        return RestResponse.status(Response.Status.BAD_REQUEST, ErrorMessage.builder().message(e.getMessage()).build());  
    }  
  
    @ServerExceptionMapper  
    public RestResponse<ErrorMessage> mapException(SocialNetworkException e) {  
        return RestResponse.status(Response.Status.BAD_REQUEST, ErrorMessage.builder().message(e.getMessage()).build());  
    }  
  
    @ServerExceptionMapper  
    public RestResponse<ErrorMessage> mapException(NotFoundException e) {  
        return RestResponse.status(Response.Status.NOT_FOUND, ErrorMessage.builder().message(e.getMessage()).build());  
    }  
  
}
```

Однако такой класс не будет перехватывать специфический исключения, например `ConstraintViolationException`, чтобы перехватывать их, необходимо реализовать `ExceptionMapper<T>`

```
package dev.struchkov.network.controller.rest;  
  
import dev.struchkov.network.controller.rest.schema.error.ValidationErrorData;  
import dev.struchkov.network.controller.rest.schema.error.ValidationErrorMessage;  
import jakarta.validation.ConstraintViolationException;  
import jakarta.ws.rs.core.Response;  
import jakarta.ws.rs.ext.ExceptionMapper;  
import jakarta.ws.rs.ext.Provider;  
  
@Provider  
public class ConstraintViolationMapper implements ExceptionMapper<ConstraintViolationException> {  
  
    @Override  
    public Response toResponse(ConstraintViolationException e) {  
        return Response.status(Response.Status.BAD_REQUEST)  
                .entity(  
                        ValidationErrorMessage.builder()  
                                .errors(  
                                        e.getConstraintViolations().stream()  
                                                .map(constraintViolation -> ValidationErrorData.builder().message(constraintViolation.getMessage()).build())  
                                                .toList()  
                                )  
                                .build()  
  
                )  
                .build();  
    }  
  
}
```