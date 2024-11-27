---
aliases: 
tags:
  - maturity/🌱
date: 2024-04-03
---
```java
import io.grpc.ManagedChannel;  
import io.grpc.ManagedChannelBuilder;

@ApplicationScoped  
public class AppealSdkManager {  
  
    private final Vertx vertx;  
    private final MutinyAppealGrpcApiGrpc.MutinyAppealGrpcApiStub grpcClient;  
  
    public AppealSdkManager(  
            @ConfigProperty(name = "crm.service.appeal.grpc.host", defaultValue = "communication-appeal-service") String storageHost,  
            @ConfigProperty(name = "crm.service.appeal.grpc.port", defaultValue = "8090") int storagePort,  
            Vertx vertx
    ) {  
        this.vertx = vertx; 
        final ManagedChannel channel = ManagedChannelBuilder.forAddress(storageHost, storagePort)  
                .usePlaintext()  
                .executor(MutinyHelper.executor(Vertx.currentContext()))  
                .idleTimeout(5, TimeUnit.MINUTES)  
                .build();  
        this.grpcClient = MutinyAppealGrpcApiGrpc.newMutinyStub(channel);  
    }
	...
}
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Quarkus|00 Quarkus]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-04-03]]
### Дополнительные материалы
- [[../gRPC|gRPC]]
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
