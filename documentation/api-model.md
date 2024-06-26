## Url Geo:

```
https://api.api-ninjas.com/v1/geocoding?city=London&country=England
```

```
key: X-Api-Key
value: b0xNipXHc7QidOPhDcuGOg==PZ7OUWlS1DZN3KcI
```

#### resultat:
```
[
    {
        "name": "London",
        "latitude": 51.5073219,
        "longitude": -0.1276474,
        "country": "GB",
        "state": "England"
    },
    {
        "name": "City of London",
        "latitude": 51.5156177,
        "longitude": -0.0919983,
        "country": "GB",
        "state": "England"
    },
    {
        "name": "Chelsea",
        "latitude": 51.4875167,
        "longitude": -0.1687007,
        "country": "GB",
        "state": "England"
    },
    {
        "name": "Vauxhall",
        "latitude": 51.4874834,
        "longitude": -0.1229297,
        "country": "GB",
        "state": "England"
    }
]
```


## Wheater by Geo Loc

```
https://api.openweathermap.org/data/2.5/weather?lat=51.5073219&lon=-0.1276474&appid=912ea2507df16681dfeac8634f83f4ff
```

```
{
    "coord": {
        "lon": -0.1276,
        "lat": 51.5073
    },
    "weather": [
        {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04d"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 301.71,
        "feels_like": 302.05,
        "temp_min": 300.03,
        "temp_max": 303.51,
        "pressure": 1009,
        "humidity": 48
    },
    "visibility": 10000,
    "wind": {
        "speed": 3.09,
        "deg": 90
    },
    "clouds": {
        "all": 75
    },
    "dt": 1719413445,
    "sys": {
        "type": 2,
        "id": 2075535,
        "country": "GB",
        "sunrise": 1719373492,
        "sunset": 1719433308
    },
    "timezone": 3600,
    "id": 2643743,
    "name": "London",
    "cod": 200
}
```