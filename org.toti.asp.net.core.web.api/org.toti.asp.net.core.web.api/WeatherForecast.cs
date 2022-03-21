using System;

namespace org.toti.asp.net.core.web.api
{
    public class WeatherForecast
    {
        public DateTime Date { get; set; }

        public int TemperatureC { get; set; }

        public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);

        public string Summary { get; set; }

        public string FDivC => "[temperatureF]/[temperatureC]";
    }
}
