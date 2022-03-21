// This file contains your Data Connector logic
section PQExtension1;

[DataSource.Kind="PQExtension1", Publish="PQExtension1.Publish"]
shared PQExtension1.Contents = (optional message as text) =>
    let
        _mess = message,
        _message = if (message <> null) then message else "(no message)",
        transform = (input as text) => let
            transformedValue = input & "foobar"
        in 
            transformedValue,
        a = "Hello from PQExtension1: " & _message,
        response = Web.Contents("https://localhost:5001/WeatherForecast"),
        json = Json.Document(response),
        table = Table.FromRecords(json),
        tableWithFormula = Table.AddColumn(table, "formulaCol", each [temperatureF] / [temperatureC], Currency.Type),
        tableWithFormula2 = Table.AddColumn(table, "formulaCol", each Expression.Evaluate([fDivC],Record.Combine({[_=_],#shared})), Currency.Type),
        tableTransformed = Table.TransformColumns(table, {"fDivC", transform}, null, MissingField.UseNull)
    in
        tableWithFormula2;
// https://www.youtube.com/watch?v=srQ-DLqhoxM
// Data Source Kind description
PQExtension1 = [
    Authentication = [
        // Key = [],
        // UsernamePassword = [],
        // Windows = [],
        Implicit = []
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
PQExtension1.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = PQExtension1.Icons,
    SourceTypeImage = PQExtension1.Icons
];

PQExtension1.Icons = [
    Icon16 = { Extension.Contents("PQExtension116.png"), Extension.Contents("PQExtension120.png"), Extension.Contents("PQExtension124.png"), Extension.Contents("PQExtension132.png") },
    Icon32 = { Extension.Contents("PQExtension132.png"), Extension.Contents("PQExtension140.png"), Extension.Contents("PQExtension148.png"), Extension.Contents("PQExtension164.png") }
];
