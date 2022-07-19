import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class parissaintgermainwfView extends WatchUi.WatchFace {
  var logo;
  var font;

  function initialize() { WatchFace.initialize(); }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    font = WatchUi.loadResource(Rez.Fonts.font);
    logo = WatchUi.loadResource(Rez.Drawables.Logo);
    setLayout(Rez.Layouts.WatchFace(dc));
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {}

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Get the current time and format it correctly
    var hourFormat = "$1$";
    var minuteFormat = "$1$";
    var clockTime = System.getClockTime();
    var hours = clockTime.hour;
    if (!System.getDeviceSettings().is24Hour) {
      if (hours > 12) {
        hours = hours - 12;
      }
    } else {
      if (getApp().getProperty("UseMilitaryFormat")) {
        hourFormat = "$1$";
        minuteFormat = "$2$";
        hours = hours.format("%02d");
      }
    }
    var hoursString = Lang.format(hourFormat, [hours]);
    var minutesString =
        Lang.format(minuteFormat, [clockTime.min.format("%02d")]);
    View.onUpdate(dc);

    var widthScreen = dc.getWidth();
    var heightScreen = dc.getHeight();
    var heightCenter = heightScreen / 2;
    var widthCenter = widthScreen / 2;
    var band = widthScreen / 4;
    var positionLogo = widthScreen / 4 - 41;
    var positionHour = heightCenter - 60;
    var positionMinute = heightCenter + 5;

    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
    dc.fillRectangle(band - 5, 0, 15, heightScreen);

    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    dc.fillRectangle(band + 10, 0, 15, heightScreen);

    dc.drawBitmap(positionLogo, heightCenter - 50, logo);

    dc.setColor(getApp().getProperty("ForegroundColor"),
                Graphics.COLOR_TRANSPARENT);
    dc.drawText(widthCenter + 50, positionHour, font, hoursString,
                Graphics.TEXT_JUSTIFY_CENTER);

    dc.setColor(getApp().getProperty("ForegroundColor"),
                Graphics.COLOR_TRANSPARENT);
    dc.drawText(widthCenter + 50, positionMinute, font, minutesString,
                Graphics.TEXT_JUSTIFY_CENTER);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  // The user has just looked at their watch. Timers and animations may be
  // started here.
  function onExitSleep() as Void {}

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {}
}
