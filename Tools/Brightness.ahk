class Brightness {

   static __comObjPath := "winmgmts:\\.\root\WMI"
   
   static ChangeBrightnessAbsolute(brightness) {
      switch {
         case brightness < 0:brightness := 0
         case brightness > 100:brightness := 100
      }
      static brightnessMethods := ComObjGet(this.__comObjPath).ExecQuery("SELECT * FROM WmiMonitorBrightnessMethods")
      for property in brightnessMethods
         property.WmiSetBrightness(1, brightness)
   }
   
   static ChangeBrightnessRelative(difference) => this.ChangeBrightnessAbsolute(this.GetCurrBrightness() + difference)

   static GetCurrBrightness() {
      static brightnessProperties := ComObjGet(this.__comObjPath).ExecQuery("SELECT * FROM WmiMonitorBrightness")
      for property in brightnessProperties
         currentBrightness := property.CurrentBrightness
      return currentBrightness
   }
}