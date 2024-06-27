from flask import Flask, jsonify
from flask_cors import CORS
import json

app = Flask(__name__)
CORS(app)
# Mock data for response
access_token = "sample_access_token"
refresh_token = "sample_refresh_token"
credentials_verification_response = "Credentials verified"
signup_response = "some_random_UUID"
product_response = {
    "id": "00017de0-3029-4d83-b534-adc2f977537c",
    "sku": "MA-Expert 4.9 Black",
    "name": "Huzaro Mark Adler Expert 4.9 Black",
    "description": "Mark Adler Expert 4.9 Black to czarny fotel biurowy, którego wyprofilowana konstrukcja dostosowuje się do budowy ciała użytkownika. Fotel pozwoli Ci szybko i wygodnie dostosować oparcie, zagłówek, siedzisko i podłokietniki do Twoich indywidualnych potrzeb. Z tyłu oparcia umieszczony został praktyczny wieszak z możliwością demontażu. Pozwala on wygodnie powiesić marynarkę, czy kurtkę. Zaprojektowany z dbałością o najmniejsze szczegóły oferuje wiele ergonomicznych i funkcjonalnych rozwiązań, które wspierają odpowiednią postawę ciała i chronią kręgosłup. Solidne połączenie najlepszych materiałów i specjalna konstrukcja gwarantują trwałość i nowoczesny wygląd.",
    "specification": {
        "Kolor": "Czarny",
        "Materiał obicia": "AirMesh",
        "Materiał podstawy": "Nylon",
        "Materiał kółek": "Poliuretan",
        "Regulowana wysokość siedziska": "440 - 520 mm",
        "Maksymalne obciążenie": "150 kg",
        "Wysokość oparcia": "900 - 1000 mm",
        "Szerokość siedziska": "500 mm",
        "Głębokość siedziska": "490 mm",
        "Regulowane podłokietniki": "Tak",
        "Regulowane oparcie": "Tak",
        "Funkcja bujania": "Nie",
        "Poduszka lędźwiowa": "Nie",
        "Poduszka zagłówkowa": "Nie",
        "Dodatkowe informacje": "Regulowany zagłówek",
        "Wysokość fotela": "1280 - 1450 mm",
        "Szerokość fotela": "660 mm",
        "Gwarancja": "24 miesiące (gwarancja producenta)",
        "Kod producenta": "MA-Expert 4.9 Black",
        "Kod x-kom": "1078167"
    },
    "quantity": 100,
    "price": 769.0,
    "imageUrl": "https://cdn.x-kom.pl/i/setup/images/prod/big/product-new-big,,2022/10/pr_2022_10_5_7_41_59_88_00.jpg",
    "createdOn": "2024-01-10T20:51:31.313616",
    "updatedOn": "2024-01-10T20:51:31.313616",
    "categoryId": 3300
}


@app.route('/api/auth/user/v1/signIn', methods=['POST'])
def sign_in():
    response = jsonify({"accessToken": access_token, "refreshToken": refresh_token})
    return response, 200

@app.route('/api/auth/user/v1/validateCredentials', methods=['POST'])
def validate_credentials():
    response = jsonify(credentials_verification_response)
    return response, 200

@app.route('/api/auth/user/v1/signUp', methods=['POST'])
def sign_up():
    return signup_response, 201

@app.route('/api/product/products/v1/p/<any_uid>', methods=['GET'])
def get_product(any_uid):
    response = jsonify(product_response)
    return response, 200

@app.route('/api/product/categories/v1/categoryHierarchy', methods=['GET'])
def get_category_hierarchy():
    # Load hierarchy data from file
    with open('hierarchy.json', 'r', encoding='utf-8') as file:
        hierarchy_data = json.load(file)
    return jsonify(hierarchy_data), 200

@app.route('/api/product/products/v1/c/<category>', methods=['GET'])
def get_category_products(category):
    # Load category-specific data from file
    with open('by_category.json', 'r', encoding='utf-8') as file:
        category_data = json.load(file)
    return jsonify(category_data), 200

@app.route('/api/product/products/v1/pc/<category>', methods=['GET'])
def get_category__products(category):
    # Load category-specific data from file
    with open('by_category.json', 'r', encoding='utf-8') as file:
        category_data = json.load(file)
    return jsonify(category_data), 200

@app.route('/api/product/products/v1/categoryWeb', methods=['GET'])
def get_categoryWeb__products():
    # Load category-specific data from file
    with open('categoryWeb.json', 'r', encoding='utf-8') as file:
        category_data = json.load(file)
    return jsonify(category_data), 200

if __name__ == '__main__':
    app.run(debug=True, host='192.168.0.52', port=80) #host='192.168.0.101', port=80)
