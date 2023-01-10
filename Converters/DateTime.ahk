; No dependencies

class DateTime {

   static Date {
      get => FormatTime(, "yy.MM.dd")
   }

   static Time {
      get => FormatTime(, "HH:mm")
   }

   static WeekDay {
      get => FormatTime(, "dddd")
   }

}