---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-04-03
zero-link:
  - "[[Quarkus]]"
  - "[[00 gRPC]]"
parents: 
linked: 
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