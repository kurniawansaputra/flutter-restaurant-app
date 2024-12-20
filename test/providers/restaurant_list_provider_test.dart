import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/core/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/providers/home/restaurant_list_provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_list_response.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'restaurant_list_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService mockApiService;
  late RestaurantListProvider provider;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantListProvider(mockApiService);
  });

  group('RestaurantListProvider Tests', () {
    test('Initial state should be RestaurantListNoneState', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test('Should return list of restaurants on successful API call', () async {
      final mockResponse = RestaurantListResponse(
        error: false,
        message: "success",
        count: 20,
        restaurants: [
          Restaurant(
            id: "rqdv5juczeskfw1e867",
            name: "Melting Pot",
            description:
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",
            pictureId: "14",
            city: "Medan",
            rating: 4.2,
          ),
        ],
      );

      when(mockApiService.getRestaurantList())
          .thenAnswer((_) async => mockResponse);

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListLoadedState>());

      final state = provider.resultState as RestaurantListLoadedState;
      expect(state.data.length, mockResponse.restaurants.length);
    });

    test('Should return error state on API failure', () async {
      when(mockApiService.getRestaurantList())
          .thenThrow(Exception("Failed to load data"));

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
      final state = provider.resultState as RestaurantListErrorState;
      expect(state.error, contains("Failed to load data"));
    });
  });
}
