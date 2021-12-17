package com.kuliang.android.flashInfo;
import com.bytedance.applog.*;
import io.flutter.embedding.android.FlutterActivity;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.Log;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {
   @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
  }

  @Override
  protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
           final InitConfig config = new InitConfig("10000025","Google store");
      //  config.setEncryptor(EncryptorUtil::encrypt);
       config.setUriConfig(UriConfig.createByDomain("https://analytics.sesisngle.net", null));
       config.setAbEnable(false);  // 开启ABTest
       config.setAutoStart(true);
       AppLog.init(this, config);
  }
  
}
