package com.cyanogenmod.settings.device;

import android.os.AsyncTask;
import android.os.Bundle;
import android.os.SystemProperties;
import android.preference.SwitchPreference;
import android.preference.ListPreference;
import android.preference.EditTextPreference;
import android.preference.Preference;
import android.preference.PreferenceFragment;
import android.provider.Settings;
import android.widget.Toast;
import android.util.Slog;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Arrays;

/**
 * Created by prodoomman on 19.02.15.
 */
public class SettingsFragment extends PreferenceFragment implements Preference.OnPreferenceChangeListener {
    
    private static final String TAG = "JSR";
    
    private class SysfsValue {
        private String fileName;
        private String value;

        private SysfsValue(String fileName, String value) {
            this.fileName = fileName;
            this.value = value;
        }

        public String getFileName() {
            return fileName;
        }

        public String getValue() {
            return value;
        }
    }

    class SysfsWriteTask extends AsyncTask<SysfsValue, Void, Integer> {

        @Override
        protected Integer doInBackground(SysfsValue... params) {
            try {
                FileOutputStream fos = new FileOutputStream(params[0].getFileName());
                fos.write(params[0].getValue().getBytes(Charset.forName("UTF-8")));
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
            return 0;
        }

        @Override
        protected void onPostExecute(Integer result) {
            if(0 != result) {
                Toast.makeText(getActivity(), R.string.fail, Toast.LENGTH_SHORT).show();
            }
        }
    }

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.pref_jsr);

        ListPreference main_storage = (ListPreference)findPreference("main_storage");
        main_storage.setOnPreferenceChangeListener(this);

        ListPreference zram_size = (ListPreference)findPreference("zram_size");
        zram_size.setOnPreferenceChangeListener(this);

        int planned_swap = SystemProperties.getInt("persist.storages.planned_swap", 0);
        main_storage.setValue(String.valueOf(planned_swap));

        int zram_planned_size = SystemProperties.getInt("persist.zram.planned_size", 0);
        zram_size.setValue(String.valueOf(zram_planned_size));
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue)
    {
        if (preference.getKey().equals("main_storage")) {
            SystemProperties.set("persist.storages.planned_swap", (String)newValue);
            Toast.makeText(getActivity(), R.string.reboot_needed, Toast.LENGTH_LONG).show();
        }
        if (preference.getKey().equals("zram_size")) {
            SystemProperties.set("persist.zram.planned_size", (String) newValue);
            Toast.makeText(getActivity(), R.string.reboot_needed, Toast.LENGTH_LONG).show();
        }
        return true;
    }
}
