enum ImageResolution { small, medium, large }

String parseRestaurantUrl(String imageId, ImageResolution resolution) {
  if (resolution == ImageResolution.small) {
    return "https://restaurant-api.dicoding.dev/images/small/$imageId";
  } else if (resolution == ImageResolution.medium) {
    return "https://restaurant-api.dicoding.dev/images/medium/$imageId";
  } else {
    return "https://restaurant-api.dicoding.dev/images/large/$imageId";
  }
}
