import 'flight.dart';

List<Flight> getFlights(Category category) {
  var allFlights = <Flight>[
    Flight(
      category: Category.findTrips,
      id: 0,
      isFeatured: true,
      destination: 'Aspen, Colorado',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 1,
      isFeatured: true,
      destination: 'Big Sur, California',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 2,
      isFeatured: true,
      destination: 'Khumbu Valley, Nepal',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 3,
      isFeatured: true,
      destination: 'Machu Picchu, Peru',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 4,
      isFeatured: true,
      destination: 'Maldives, South Asia',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 5,
      isFeatured: true,
      destination: 'Vitznau, Switzerland',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 6,
      isFeatured: true,
      destination: 'Madrid, Spain',
      layover: false,
    ),
  ];
  if (category == Category.findTrips) {
    return allFlights;
  } else {
    return allFlights.where((element) => element.category == category).toList();
  }
}
