package com.liberchat.mobile;

import android.os.Bundle;
import tools.fastlane.screengrab.Screengrab;
import tools.fastlane.screengrab.UiAutomatorScreenshotStrategy;
import tools.fastlane.screengrab.locale.LocaleTestRule;

import androidx.test.ext.junit.runners.AndroidJUnit4;
import androidx.test.rule.ActivityTestRule;
import androidx.test.uiautomator.UiDevice;
import androidx.test.uiautomator.UiObject;
import androidx.test.uiautomator.UiSelector;

import org.junit.ClassRule;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import static androidx.test.platform.app.InstrumentationRegistry.getInstrumentation;

@RunWith(AndroidJUnit4.class)
public class ScreenshotTest {
    
    @ClassRule
    public static final LocaleTestRule localeTestRule = new LocaleTestRule();

    @Rule
    public ActivityTestRule<MainActivity> activityRule = new ActivityTestRule<>(MainActivity.class);

    @Test
    public void testTakeScreenshots() throws Exception {
        Screengrab.setDefaultScreenshotStrategy(new UiAutomatorScreenshotStrategy());
        
        UiDevice device = UiDevice.getInstance(getInstrumentation());
        
        // Attendre que l'app se charge
        Thread.sleep(3000);
        
        // Capture 1: Splash Screen / Écran d'accueil
        Screengrab.screenshot("01_splash_screen");
        
        // Attendre le chargement
        Thread.sleep(2000);
        
        // Capture 2: Sélection du serveur
        Screengrab.screenshot("02_server_selection");
        
        // Simuler une sélection de serveur (si possible)
        try {
            UiObject serverButton = device.findObject(new UiSelector().textContains("Serveur"));
            if (serverButton.exists()) {
                serverButton.click();
                Thread.sleep(1000);
            }
        } catch (Exception e) {
            // Continuer même si l'élément n'est pas trouvé
        }
        
        // Capture 3: Interface principale
        Screengrab.screenshot("03_main_interface");
        
        // Capture 4: Menu ou paramètres (si accessible)
        try {
            // Essayer d'ouvrir un menu
            device.pressMenu();
            Thread.sleep(1000);
            Screengrab.screenshot("04_menu");
        } catch (Exception e) {
            // Si pas de menu, prendre une autre capture
            Screengrab.screenshot("04_app_view");
        }
        
        // Capture 5: Thème sombre (si possible de basculer)
        Screengrab.screenshot("05_dark_theme");
    }
}