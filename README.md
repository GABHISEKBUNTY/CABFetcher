# CABFetcher

CabFetcher is a collction of files which help you to fecth cabs of various cab service providers between locations.

# Usage

For the time being, we have not provided any pod support or framework support for CABFetcher, but that doesn't mean you can not use it.
Just drag and drop the files in CodeBase folder into your project and then you are good to go. You are ready to travel now.

## UBER Fetching:

### 1. Initialise UBERManager

```
 UBERManager.initializeUBERManager(token: "Your_Token", client_id: "Your_ClientID")
```

### 2. Get Cab List

```
func getUBERCabs(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D, completion: @escaping (_ cabList: [UBERCab]?, _ errorMessage:String?)->Void)
```

### 3. Open cab selection in UBER

```
func openUberApp(selectedProductId: String,startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D, completion: (Bool)->())
```

# And what's coming ....

1. Include OLA Cab API's
2. Provide framework and Pod support.

## License

ATAppUpdater is released under the MIT license. See [LICENSE](https://github.com/emotality/ATAppUpdater/blob/master/LICENSE.md) for details.
