import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:openfoodfacts/openfoodfacts.dart';
// import 'package:google_generative_ai/google_generative_ai.dart'; // Not used with REST
import 'package:calorize/data/models/food_log.dart';
import 'package:calorize/services/database_service.dart';

class FoodSourcingService {
  
  Future<FoodLog?> getProductByBarcode(String code) async {
    try {
      final configuration = ProductQueryConfiguration(
        code,
        language: OpenFoodFactsLanguage.ENGLISH,
        fields: [
          ProductField.NAME,
          ProductField.BRANDS,
          ProductField.NUTRIMENTS,
          ProductField.SERVING_SIZE,
          ProductField.SERVING_QUANTITY,
        ],
        version: ProductQueryVersion.v3,
      );

      final result = await OpenFoodAPIClient.getProductV3(configuration);

      if (result.product != null) {
        final product = result.product!;
        final nutriments = product.nutriments;
        
        // Determine serving factor (default to 100g if serving size not found)
        double servingFactor = 1.0;
        String servingUnit = '100g';
        
        if (product.servingQuantity != null && product.servingQuantity! > 0) {
          servingFactor = product.servingQuantity! / 100.0;
          servingUnit = product.servingSize ?? '${product.servingQuantity}g';
        }

        return FoodLog()
          ..foodName = product.productName ?? 'Unknown Food'
          ..brandName = product.brands
          ..calories = ((nutriments?.getValue(Nutrient.energyKCal, PerSize.serving) ?? 
                         (nutriments?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ?? 0) * servingFactor)).round()
          ..macros = Macros()
          ..macros.protein = (nutriments?.getValue(Nutrient.proteins, PerSize.serving) ?? 
                              (nutriments?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? 0) * servingFactor)
          ..macros.carbs = (nutriments?.getValue(Nutrient.carbohydrates, PerSize.serving) ?? 
                            (nutriments?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ?? 0) * servingFactor)
          ..macros.fat = (nutriments?.getValue(Nutrient.fat, PerSize.serving) ?? 
                          (nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? 0) * servingFactor)
          ..macros.fiber = (nutriments?.getValue(Nutrient.fiber, PerSize.serving) ?? 
                            (nutriments?.getValue(Nutrient.fiber, PerSize.oneHundredGrams) ?? 0) * servingFactor)
          ..macros.sugar = (nutriments?.getValue(Nutrient.sugars, PerSize.serving) ?? 
                            (nutriments?.getValue(Nutrient.sugars, PerSize.oneHundredGrams) ?? 0) * servingFactor)
          ..macros.sodium = (nutriments?.getValue(Nutrient.sodium, PerSize.serving) ?? 
                             (nutriments?.getValue(Nutrient.sodium, PerSize.oneHundredGrams) ?? 0) * servingFactor) * 1000; // g to mg
      }
    } catch (e) {
      print('Error fetching product: $e');
    }
    return null;
  }

  Future<FoodLog?> analyzeImage(File image, String userContext) async {
    // Fetch API Key from UserProfile
    final profile = await DatabaseService().getUserProfile();
    final apiKey = profile?.geminiApiKey;

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Gemini API Key is missing. Please add it in Settings.');
    }

    final prompt = '''
Analyze this food image. Context: '$userContext'.
Use Google Search to verify nutritional information.
1. Identify the food item.
2. Estimate the portion size based on visual cues (plate size, utensils). If unsure, assume a STANDARD SINGLE SERVING size (e.g. 1 cup/plate).
3. Calculate nutrition based on this estimated portion. BE REALISTIC. Do not overestimate.
4. Return a SINGLE JSON object with this exact structure (no markdown, no backticks):
{
  "name": "Food Name",
  "calories": 0,
  "macros": {
    "p": 0,
    "c": 0,
    "f": 0
  },
  "micros": {
    "fiber": 0,
    "sugar": 0,
    "sodium": 0
  }
}
Ensure calories are an integer. Macros/micros can be floats. Sodium in mg, others in g.
''';

    try {
      final imageBytes = await image.readAsBytes();
      final base64Image = base64Encode(imageBytes);

      final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey');
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [{
            "parts": [
              {"text": prompt},
              {
                "inline_data": {
                  "mime_type": "image/jpeg",
                  "data": base64Image
                }
              }
            ]
          }],
          "tools": [{
            "google_search": {}
          }]
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        
        // Extract text from response
        // Structure: candidates[0].content.parts[0].text
        if (jsonResponse['candidates'] != null && 
            (jsonResponse['candidates'] as List).isNotEmpty &&
            jsonResponse['candidates'][0]['content'] != null &&
            jsonResponse['candidates'][0]['content']['parts'] != null &&
            (jsonResponse['candidates'][0]['content']['parts'] as List).isNotEmpty) {
              
          String text = jsonResponse['candidates'][0]['content']['parts'][0]['text'];
          
          // Clean up markdown if present
          final jsonStr = text.replaceAll('```json', '').replaceAll('```', '').trim();
          final data = jsonDecode(jsonStr);
          
          return FoodLog()
            ..foodName = data['name']
            ..calories = data['calories']
            ..timestamp = DateTime.now()
            ..macros = Macros()
            ..macros.protein = (data['macros']['p'] as num).toDouble()
            ..macros.carbs = (data['macros']['c'] as num).toDouble()
            ..macros.fat = (data['macros']['f'] as num).toDouble()
            ..macros.fiber = (data['micros']['fiber'] as num).toDouble()
            ..macros.sugar = (data['micros']['sugar'] as num).toDouble()
            ..macros.sodium = (data['micros']['sodium'] as num).toDouble();
        }
      } else {
        print('API Error: ${response.statusCode} - ${response.body}');
        throw Exception('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error analyzing image: $e');
      throw Exception('Failed to analyze image: $e');
    }
    
    throw Exception('No response from AI');
  }
}
