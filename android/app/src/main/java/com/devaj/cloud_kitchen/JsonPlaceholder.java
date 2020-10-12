package com.devaj.cloud_kitchen;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;

interface JsonPlaceholder {
    @GET("posts")
    Call<List<Post>> getPosts();
}
