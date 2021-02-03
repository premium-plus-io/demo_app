# Mobile SDK Demo App

## Zendesk URL
https://premiumplusdemo.zendesk.com

## App ID
    8522ae2a6589c7ca17fd491229ca5f7ca0c4866c35529afb

## Client ID
    mobile_sdk_client_8c54403a38a122e7dcc2

## Android code snippet
    Zendesk.INSTANCE.init(context, "https://premiumplusdemo.zendesk.com",
      "8522ae2a6589c7ca17fd491229ca5f7ca0c4866c35529afb",
      "mobile_sdk_client_8c54403a38a122e7dcc2");
    Support.INSTANCE.init(Zendesk.INSTANCE);

## iOS code snippet
### Objective-C
    [ZDKZendesk initializeWithAppId: @"8522ae2a6589c7ca17fd491229ca5f7ca0c4866c35529afb"
      clientId: @"mobile_sdk_client_8c54403a38a122e7dcc2"
      zendeskUrl: @"https://premiumplusdemo.zendesk.com"];
    [ZDKSupport initializeWithZendesk: [ZDKZendesk instance]];

### Swift
    Zendesk.initialize(appId: "8522ae2a6589c7ca17fd491229ca5f7ca0c4866c35529afb",
      clientId: "mobile_sdk_client_8c54403a38a122e7dcc2",
      zendeskUrl: "https://premiumplusdemo.zendesk.com")
    Support.initialize(withZendesk: Zendesk.instance)

## JWT Authentication
### JWT URL
example https://premiumplus.eu.auth0.com/

### JWT Secret
    VOK0uJdfhjVABEEyeW8SuYdSj32tFzf4orN56oHviacZbjey