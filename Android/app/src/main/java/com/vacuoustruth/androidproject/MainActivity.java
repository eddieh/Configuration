package com.vacuoustruth.androidproject;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (BuildConfig.VT_USE_CONFIG) {
            System.out.println("use config");
        } else {
            System.out.println("not using config");
        }
    }
}
