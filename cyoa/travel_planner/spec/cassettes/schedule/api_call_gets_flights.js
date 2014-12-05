{
    "request"
:
    {
        "departureAirport"
    :
        {
            "requestedCode"
        :
            "ORD", "fsCode"
        :
            "ORD"
        }
    ,
        "arrivalAirport"
    :
        {
            "requestedCode"
        :
            "LGA", "fsCode"
        :
            "LGA"
        }
    ,
        "codeType"
    :
        {
        }
    ,
        "departing"
    :
        false, "date"
    :
        {
            "year"
        :
            "2014", "month"
        :
            "12", "day"
        :
            "12", "interpreted"
        :
            "2014-12-12"
        }
    ,
        "url"
    :
        "https://api.flightstats.com/flex/schedules/rest/v1/json/from/ORD/to/LGA/arriving/2014/12/12"
    }
,
    "scheduledFlights"
:
    [{
        "carrierFsCode": "UA",
        "flightNumber": "1018",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T07:00:00.000",
        "arrivalTime": "2014-12-12T10:09:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2517306--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "398",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T06:00:00.000",
        "arrivalTime": "2014-12-12T09:00:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "US",
            "flightNumber": "398",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 2517908
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6643",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 2518317
        }],
        "referenceCode": "1202-2518192--"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6643",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T06:00:00.000",
        "arrivalTime": "2014-12-12T09:00:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "398",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518192--2518317"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "388",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T08:35:00.000",
        "arrivalTime": "2014-12-12T11:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "AS",
            "flightNumber": "1151",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": ["G"],
            "referenceCode": 2516869
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6635",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 2516916
        }, {
            "carrierFsCode": "US",
            "flightNumber": "388",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 2517894
        }],
        "referenceCode": "1202-2518239--"
    }, {
        "carrierFsCode": "AS",
        "flightNumber": "1151",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T08:35:00.000",
        "arrivalTime": "2014-12-12T11:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": ["G"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "388",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518239--2516869"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6635",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T08:35:00.000",
        "arrivalTime": "2014-12-12T11:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "388",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518239--2516916"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "674",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T09:00:00.000",
        "arrivalTime": "2014-12-12T12:08:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2517479--"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6611",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T09:25:00.000",
        "arrivalTime": "2014-12-12T12:25:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "384",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518143--10951533"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "358",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T16:35:00.000",
        "arrivalTime": "2014-12-12T19:40:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "JL",
            "flightNumber": "7658",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10952331
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6617",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10952333
        }, {
            "carrierFsCode": "US",
            "flightNumber": "358",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 10952336
        }],
        "referenceCode": "1202-2516854--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "350",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T17:35:00.000",
        "arrivalTime": "2014-12-12T20:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "AS",
            "flightNumber": "1011",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": ["G"],
            "referenceCode": 2516879
        }, {
            "carrierFsCode": "EY",
            "flightNumber": "3157",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["G"],
            "referenceCode": 2517031
        }, {
            "carrierFsCode": "US",
            "flightNumber": "350",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 2517823
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6609",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10952553
        }],
        "referenceCode": "1202-2518052--"
    }, {
        "carrierFsCode": "AS",
        "flightNumber": "1011",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T17:35:00.000",
        "arrivalTime": "2014-12-12T20:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": ["G"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "350",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518052--2516879"
    }, {
        "carrierFsCode": "EY",
        "flightNumber": "3157",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T17:35:00.000",
        "arrivalTime": "2014-12-12T20:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["G"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "350",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518052--2517031"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6609",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T17:35:00.000",
        "arrivalTime": "2014-12-12T20:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "350",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518052--10952553"
    }, {
        "carrierFsCode": "NK",
        "flightNumber": "630",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T17:56:00.000",
        "arrivalTime": "2014-12-12T21:05:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2518674--"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "672",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T08:00:00.000",
        "arrivalTime": "2014-12-12T11:08:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2516771--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "384",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T09:25:00.000",
        "arrivalTime": "2014-12-12T12:25:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "US",
            "flightNumber": "384",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 10951531
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6611",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10951533
        }, {
            "carrierFsCode": "JL",
            "flightNumber": "7372",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10951535
        }],
        "referenceCode": "1202-2518143--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "394",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T06:35:00.000",
        "arrivalTime": "2014-12-12T09:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "US",
            "flightNumber": "394",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 2517923
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6641",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10951333
        }],
        "referenceCode": "1202-2518197--"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6641",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T06:35:00.000",
        "arrivalTime": "2014-12-12T09:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "394",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518197--10951333"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5932",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T06:30:00.000",
        "arrivalTime": "2014-12-12T09:38:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2518432--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "392",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T07:30:00.000",
        "arrivalTime": "2014-12-12T10:30:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "US",
            "flightNumber": "392",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 2517914
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6639",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 2518307
        }],
        "referenceCode": "1202-2518211--"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6639",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T07:30:00.000",
        "arrivalTime": "2014-12-12T10:30:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "392",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518211--2518307"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5934",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T07:30:00.000",
        "arrivalTime": "2014-12-12T10:39:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2518394--"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5936",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T08:30:00.000",
        "arrivalTime": "2014-12-12T11:37:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2516970--"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5938",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T09:30:00.000",
        "arrivalTime": "2014-12-12T12:36:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2517009--"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5942",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T11:30:00.000",
        "arrivalTime": "2014-12-12T14:37:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2516996--"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5944",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T12:30:00.000",
        "arrivalTime": "2014-12-12T15:37:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2516990--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "368",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T13:20:00.000",
        "arrivalTime": "2014-12-12T16:20:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "US",
            "flightNumber": "368",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 2517794
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6625",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10951897
        }],
        "referenceCode": "1202-2517954--"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6625",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T13:20:00.000",
        "arrivalTime": "2014-12-12T16:20:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "368",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2517954--10951897"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5946",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T13:30:00.000",
        "arrivalTime": "2014-12-12T16:40:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2516966--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "366",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T14:10:00.000",
        "arrivalTime": "2014-12-12T17:10:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "BA",
            "flightNumber": "6623",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10951933
        }, {
            "carrierFsCode": "US",
            "flightNumber": "366",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 10951934
        }],
        "referenceCode": "1202-2517976--"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6623",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T14:10:00.000",
        "arrivalTime": "2014-12-12T17:10:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "366",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2517976--10951933"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5948",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T14:30:00.000",
        "arrivalTime": "2014-12-12T17:36:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2518444--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "364",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T15:00:00.000",
        "arrivalTime": "2014-12-12T18:00:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "US",
            "flightNumber": "364",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 2516836
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "4315",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10951962
        }],
        "referenceCode": "1202-2517973--"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "4315",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T15:00:00.000",
        "arrivalTime": "2014-12-12T18:00:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "364",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2517973--10951962"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5950",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T15:30:00.000",
        "arrivalTime": "2014-12-12T18:39:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2518423--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "360",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T16:05:00.000",
        "arrivalTime": "2014-12-12T19:05:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "AS",
            "flightNumber": "1214",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": ["G"],
            "referenceCode": 2518253
        }, {
            "carrierFsCode": "US",
            "flightNumber": "360",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 10952301
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6619",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10952303
        }, {
            "carrierFsCode": "QR",
            "flightNumber": "5138",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": ["Y"],
            "referenceCode": 10952304
        }],
        "referenceCode": "1202-2516518--"
    }, {
        "carrierFsCode": "AS",
        "flightNumber": "1214",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T16:05:00.000",
        "arrivalTime": "2014-12-12T19:05:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": ["G"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "360",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516518--2518253"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6619",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T16:05:00.000",
        "arrivalTime": "2014-12-12T19:05:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "360",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516518--10952303"
    }, {
        "carrierFsCode": "QR",
        "flightNumber": "5138",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T16:05:00.000",
        "arrivalTime": "2014-12-12T19:05:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["Y"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "360",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516518--10952304"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5952",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T16:30:00.000",
        "arrivalTime": "2014-12-12T19:40:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2516947--"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5954",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T17:30:00.000",
        "arrivalTime": "2014-12-12T20:38:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2518407--"
    }, {
        "carrierFsCode": "RJ",
        "flightNumber": "7061",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T18:20:00.000",
        "arrivalTime": "2014-12-12T21:25:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["J", "Y"],
        "trafficRestrictions": ["G"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "352",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516539--2517125"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6615",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T18:20:00.000",
        "arrivalTime": "2014-12-12T21:25:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "352",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516539--10952591"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5956",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T18:30:00.000",
        "arrivalTime": "2014-12-12T21:42:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2518399--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "346",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T19:15:00.000",
        "arrivalTime": "2014-12-12T22:15:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "US",
            "flightNumber": "346",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 10952890
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6607",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10952891
        }],
        "referenceCode": "1202-2516553--"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "346",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T19:15:00.000",
        "arrivalTime": "2014-12-12T22:15:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "346",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516553--10952890"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6607",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T19:15:00.000",
        "arrivalTime": "2014-12-12T22:15:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "346",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516553--10952891"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5958",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T19:30:00.000",
        "arrivalTime": "2014-12-12T22:31:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2518385--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "352",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T18:20:00.000",
        "arrivalTime": "2014-12-12T21:25:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "RJ",
            "flightNumber": "7061",
            "serviceType": "J",
            "serviceClasses": ["J", "Y"],
            "trafficRestrictions": ["G"],
            "referenceCode": 2517125
        }, {
            "carrierFsCode": "US",
            "flightNumber": "352",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 10952589
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6615",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10952591
        }],
        "referenceCode": "1202-2516539--"
    }, {
        "carrierFsCode": "NK",
        "flightNumber": "224",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T05:56:00.000",
        "arrivalTime": "2014-12-12T09:00:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2518683--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "374",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T12:25:00.000",
        "arrivalTime": "2014-12-12T15:25:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "US",
            "flightNumber": "374",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 2517813
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6629",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 2518371
        }],
        "referenceCode": "1202-2518153--"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6629",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T12:25:00.000",
        "arrivalTime": "2014-12-12T15:25:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "374",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518153--2518371"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "547",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T09:45:00.000",
        "arrivalTime": "2014-12-12T12:53:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "NH",
            "flightNumber": "7744",
            "serviceType": "J",
            "serviceClasses": ["F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 2518626
        }],
        "referenceCode": "1202-2516760--"
    }, {
        "carrierFsCode": "NH",
        "flightNumber": "7744",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T09:45:00.000",
        "arrivalTime": "2014-12-12T12:53:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "UA",
            "flightNumber": "547",
            "serviceType": "J",
            "serviceClasses": ["F", "J", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516760--2518626"
    }, {
        "carrierFsCode": "DL",
        "flightNumber": "5940",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "2",
        "arrivalTerminal": "A",
        "departureTime": "2014-12-12T10:30:00.000",
        "arrivalTime": "2014-12-12T13:36:00.000",
        "flightEquipmentIataCode": "EMJ",
        "isCodeshare": false,
        "isWetlease": true,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["F"],
        "codeshares": [],
        "wetleaseOperatorFsCode": "S5",
        "referenceCode": "1202-2518472--"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "354",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T17:00:00.000",
        "arrivalTime": "2014-12-12T20:00:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "EY",
            "flightNumber": "3050",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["G"],
            "referenceCode": 10952409
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6603",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10952410
        }, {
            "carrierFsCode": "US",
            "flightNumber": "354",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 10952412
        }],
        "referenceCode": "1202-2518051--"
    }, {
        "carrierFsCode": "EY",
        "flightNumber": "3050",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T17:00:00.000",
        "arrivalTime": "2014-12-12T20:00:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["G"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "354",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518051--10952409"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6603",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T17:00:00.000",
        "arrivalTime": "2014-12-12T20:00:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "354",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518051--10952410"
    }, {
        "carrierFsCode": "AA",
        "flightNumber": "380",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T10:40:00.000",
        "arrivalTime": "2014-12-12T13:40:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "US",
            "flightNumber": "380",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "Y"],
            "trafficRestrictions": [],
            "referenceCode": 10951705
        }, {
            "carrierFsCode": "BA",
            "flightNumber": "6633",
            "serviceType": "J",
            "serviceClasses": ["R", "F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10951707
        }],
        "referenceCode": "1202-2516567--"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "380",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T10:40:00.000",
        "arrivalTime": "2014-12-12T13:40:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "380",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516567--10951705"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6633",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T10:40:00.000",
        "arrivalTime": "2014-12-12T13:40:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "380",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516567--10951707"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "678",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T11:00:00.000",
        "arrivalTime": "2014-12-12T14:08:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "OZ",
            "flightNumber": "6446",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 2516645
        }, {
            "carrierFsCode": "NH",
            "flightNumber": "7746",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 10951728
        }],
        "referenceCode": "1202-2517512--"
    }, {
        "carrierFsCode": "OZ",
        "flightNumber": "6446",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T11:00:00.000",
        "arrivalTime": "2014-12-12T14:08:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "UA",
            "flightNumber": "678",
            "serviceType": "J",
            "serviceClasses": ["F", "J", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2517512--2516645"
    }, {
        "carrierFsCode": "NH",
        "flightNumber": "7746",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T11:00:00.000",
        "arrivalTime": "2014-12-12T14:08:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "UA",
            "flightNumber": "678",
            "serviceType": "J",
            "serviceClasses": ["F", "J", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2517512--10951728"
    }, {
        "carrierFsCode": "BA",
        "flightNumber": "6617",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T16:35:00.000",
        "arrivalTime": "2014-12-12T19:40:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "358",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516854--10952333"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "1196",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T17:00:00.000",
        "arrivalTime": "2014-12-12T20:16:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2517347--"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "1292",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T18:00:00.000",
        "arrivalTime": "2014-12-12T21:16:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2517333--"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "398",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T06:00:00.000",
        "arrivalTime": "2014-12-12T09:00:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "398",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518192--2517908"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "388",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T08:35:00.000",
        "arrivalTime": "2014-12-12T11:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "388",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518239--2517894"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "384",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T09:25:00.000",
        "arrivalTime": "2014-12-12T12:25:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "384",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518143--10951531"
    }, {
        "carrierFsCode": "JL",
        "flightNumber": "7372",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T09:25:00.000",
        "arrivalTime": "2014-12-12T12:25:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "384",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518143--10951535"
    }, {
        "carrierFsCode": "JL",
        "flightNumber": "7658",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T16:35:00.000",
        "arrivalTime": "2014-12-12T19:40:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "358",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516854--10952331"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "358",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T16:35:00.000",
        "arrivalTime": "2014-12-12T19:40:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "358",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516854--10952336"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "350",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T17:35:00.000",
        "arrivalTime": "2014-12-12T20:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "350",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518052--2517823"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "394",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T06:35:00.000",
        "arrivalTime": "2014-12-12T09:35:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "394",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518197--2517923"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "392",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T07:30:00.000",
        "arrivalTime": "2014-12-12T10:30:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "392",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518211--2517914"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "368",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T13:20:00.000",
        "arrivalTime": "2014-12-12T16:20:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "368",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2517954--2517794"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "366",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T14:10:00.000",
        "arrivalTime": "2014-12-12T17:10:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "366",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2517976--10951934"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "364",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T15:00:00.000",
        "arrivalTime": "2014-12-12T18:00:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "364",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2517973--2516836"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "360",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T16:05:00.000",
        "arrivalTime": "2014-12-12T19:05:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "360",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516518--10952301"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "354",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T17:00:00.000",
        "arrivalTime": "2014-12-12T20:00:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "354",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518051--10952412"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "352",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T18:20:00.000",
        "arrivalTime": "2014-12-12T21:25:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "352",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2516539--10952589"
    }, {
        "carrierFsCode": "US",
        "flightNumber": "374",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "3",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T12:25:00.000",
        "arrivalTime": "2014-12-12T15:25:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["R", "F", "Y"],
        "trafficRestrictions": [],
        "operator": {
            "carrierFsCode": "AA",
            "flightNumber": "374",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2518153--2517813"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "682",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T13:00:00.000",
        "arrivalTime": "2014-12-12T16:11:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2517498--"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "211",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T12:00:00.000",
        "arrivalTime": "2014-12-12T15:13:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2517401--"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "1585",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T14:00:00.000",
        "arrivalTime": "2014-12-12T17:12:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2517190--"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "668",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T06:00:00.000",
        "arrivalTime": "2014-12-12T09:08:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2517451--"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "1405",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T15:06:00.000",
        "arrivalTime": "2014-12-12T18:18:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "NH",
            "flightNumber": "7570",
            "serviceType": "J",
            "serviceClasses": ["F", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 2518573
        }],
        "referenceCode": "1202-2517362--"
    }, {
        "carrierFsCode": "NH",
        "flightNumber": "7570",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T15:06:00.000",
        "arrivalTime": "2014-12-12T18:18:00.000",
        "flightEquipmentIataCode": "737",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "UA",
            "flightNumber": "1405",
            "serviceType": "J",
            "serviceClasses": ["F", "J", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2517362--2518573"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "688",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T16:00:00.000",
        "arrivalTime": "2014-12-12T19:11:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [{
            "carrierFsCode": "NH",
            "flightNumber": "7572",
            "serviceType": "J",
            "serviceClasses": ["F", "J", "Y"],
            "trafficRestrictions": ["Q"],
            "referenceCode": 2516615
        }],
        "referenceCode": "1202-2517559--"
    }, {
        "carrierFsCode": "NH",
        "flightNumber": "7572",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T16:00:00.000",
        "arrivalTime": "2014-12-12T19:11:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": true,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": ["Q"],
        "operator": {
            "carrierFsCode": "UA",
            "flightNumber": "688",
            "serviceType": "J",
            "serviceClasses": ["F", "J", "Y"],
            "trafficRestrictions": []
        },
        "codeshares": [],
        "referenceCode": "1202-2517559--2516615"
    }, {
        "carrierFsCode": "UA",
        "flightNumber": "995",
        "departureAirportFsCode": "ORD",
        "arrivalAirportFsCode": "LGA",
        "stops": 0,
        "departureTerminal": "1",
        "arrivalTerminal": "B",
        "departureTime": "2014-12-12T20:23:00.000",
        "arrivalTime": "2014-12-12T23:29:00.000",
        "flightEquipmentIataCode": "32S",
        "isCodeshare": false,
        "isWetlease": false,
        "serviceType": "J",
        "serviceClasses": ["F", "J", "Y"],
        "trafficRestrictions": [],
        "codeshares": [],
        "referenceCode": "1202-2516668--"
    }], "appendix"
:
    {
        "airlines"
    :
        [{
            "fs": "AA",
            "iata": "AA",
            "icao": "AAL",
            "name": "American
            Airlines","
            phoneNumber":"
            1-800 - 433 - 7300
            ","active
            ":true},{"fs
            ":"QR
            ","iata
            ":"QR
            ","icao
            ":"QTR
            ","name
            ":"Qatar
            Airways","
            active":true},{"
            fs":"
            JL","
            iata":"
            JL","
            icao":"
            JAL","
            name":"
            JAL","
            active":true},{"
            fs":"
            S5","
            iata":"
            S5","
            icao":"
            TCF","
            name":"
            Shuttle
                America
            ","active
            ":true},{"fs
            ":"DL
            ","iata
            ":"DL
            ","icao
            ":"DAL
            ","name
            ":"Delta
            Air Lines
            ","phoneNumber
            ":"1 - 800 - 221 - 1212
            ","active
            ":true},{"fs
            ":"OZ
            ","iata
            ":"OZ
            ","icao
            ":"AAR
            ","name
            ":"Asiana
            Airlines","
            active":true},{"
            fs":"
            UA","
            iata":"
            UA","
            icao":"
            UAL","
            name":"
            United
                Airlines
            ","phoneNumber
            ":"1 - 800 - 864 - 8331
            ","active
            ":true},{"fs
            ":"AS
            ","iata
            ":"AS
            ","icao
            ":"ASA
            ","name
            ":"Alaska
            Airlines","
            phoneNumber":"
            1-800 - 252 - 7522
            ","active
            ":true},{"fs
            ":"EY
            ","iata
            ":"EY
            ","icao
            ":"ETD
            ","name
            ":"Etihad
            Airways","
            active":true},{"
            fs":"
            RJ","
            iata":"
            RJ","
            icao":"
            RJA","
            name":"
            Royal
                Jordanian
            ","active
            ":true},{"fs
            ":"NH
            ","iata
            ":"NH
            ","icao
            ":"ANA
            ","name
            ":"ANA
            ","phoneNumber
            ":"1 - 800 - 235 - 9262
            ","active
            ":true},{"fs
            ":"NK
            ","iata
            ":"NK
            ","icao
            ":"NKS
            ","name
            ":"Spirit
            Airlines","
            active":true},{"
            fs":"
            US","
            iata":"
            US","
            icao":"
            AWE","
            name":"
            US Airways
            ","phoneNumber
            ":"1 - 800 - 943 - 5436
            ","active
            ":true},{"fs
            ":"BA
            ","iata
            ":"BA
            ","icao
            ":"BAW
            ","name
            ":"British
            Airways","
            phoneNumber":"
            1-800 - AIRWAYS
            ","active
            ":true}],"airports
            ":[{"fs
            ":"ORD
            ","iata
            ":"ORD
            ","icao
            ":"KORD
            ","faa
            ":"ORD
            ","name
            ":"O
            ''Hare
            International Airport
            ","street1
            ":"10000
            West O
            ''Hare
            ","city
            ":"Chicago
            ","cityCode
            ":"CHI
            ","stateCode
            ":"IL
            ","postalCode
            ":"60666
            ","countryCode
            ":"US
            ","countryName
            ":"United
            States","
            regionName":"
            North America
            ","timeZoneRegionName
            ":"America / Chicago
            ","weatherZone
            ":"ILZ014
            ","localTime
            ":"2014 - 12 - 05
            T09: 08
    :
        45.612
        ","
        utcOffsetHours
        ":-6.0,"
        latitude
        ":41.976912,"
        longitude
        ":-87.904876,"
        elevationFeet
        ":668,"
        classification
        ":1,"
        active
        ":true},{"
        fs
        ":"
        LGA
        ","
        iata
        ":"
        LGA
        ","
        icao
        ":"
        KLGA
        ","
        faa
        ":"
        LGA
        ","
        name
        ":"
        LaGuardia
        Airport
        ","
        street1
        ":"
        Hangar
        7
        Center
        ","
        city
        ":"
        New
        York
        ","
        cityCode
        ":"
        NYC
        ","
        stateCode
        ":"
        NY
        ","
        postalCode
        ":"
        11371
        ","
        countryCode
        ":"
        US
        ","
        countryName
        ":"
        United
        States
        ","
        regionName
        ":"
        North
        America
        ","
        timeZoneRegionName
        ":"
        America / New_York
        ","
        weatherZone
        ":"
        NYZ176
        ","
        localTime
        ":"
        2014 - 12 - 05
        T10:08
    :
        45.612
        ","
        utcOffsetHours
        ":-5.0,"
        latitude
        ":40.774252,"
        longitude
        ":-73.871617,"
        elevationFeet
        ":22,"
        classification
        ":1,"
        active
        ":true}],"
        equipments
        ":[{"
        iata
        ":"
        EMJ
        ","
        name
        ":"
        Embraer
        RJ170 / 190
        ","
        turboProp
        ":false,"
        jet
        ":true,"
        widebody
        ":false,"
        regional
        ":true},{"
        iata
        ":"
        32
        S
        ","
        name
        ":"
        Airbus
        Industrie
        A318 / 319 / 320 / 321
        ","
        turboProp
        ":false,"
        jet
        ":true,"
        widebody
        ":false,"
        regional
        ":false},{"
        iata
        ":"
        737
        ","
        name
        ":"
        Boeing
        737
        Passenger
        ","
        turboProp
        ":false,"
        jet
        ":true,"
        widebody
        ":false,"
        regional
        ":false}]}}