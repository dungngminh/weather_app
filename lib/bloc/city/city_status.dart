abstract class CityStatus {
  const CityStatus();
}

class CityInitial extends CityStatus {
  const CityInitial();
}

class CityIsSearching extends CityStatus {}

class CitySearched extends CityStatus {}

class CitySearchedFail extends CityStatus {}
