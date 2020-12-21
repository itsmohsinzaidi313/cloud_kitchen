package com.devaj.cloud_kitchen;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;

interface RegisterApi {
    @POST
    Call<ServerResponse> createPost(@Body RegisterOpen registerOpen);
}
