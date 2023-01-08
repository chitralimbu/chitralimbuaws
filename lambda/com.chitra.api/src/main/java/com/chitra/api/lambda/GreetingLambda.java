package com.chitra.api.lambda;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class GreetingLambda implements RequestHandler<Void, String> {

    @Override
    public String handleRequest(Void input, Context context) {
        return "Hello world! from chitra!!!";
    }
}
