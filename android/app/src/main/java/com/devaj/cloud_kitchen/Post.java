package com.devaj.cloud_kitchen;

import com.google.gson.annotations.SerializedName;

class Post {
    private String id;
    private String userId;
    private String title;
    @SerializedName("body")
    private String text;

    public String getId() {
        return id;
    }

    public String getUserId() {
        return userId;
    }

    public String getTitle() {
        return title;
    }

    public String getText() {
        return text;
    }
}
