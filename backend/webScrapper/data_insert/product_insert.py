import json
from sqlalchemy import create_engine, Column, String, Integer, DateTime, ForeignKey, Double
from sqlalchemy.orm import sessionmaker, declarative_base
from datetime import datetime
import uuid

Base = declarative_base()

class Product(Base):
    __tablename__ = 'product'

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    sku = Column(String)
    name = Column(String)
    description = Column(String)
    specification = Column(String)
    quantity = Column(Integer)
    price = Column(Double)
    image_url = Column(String)
    created_on = Column(DateTime, default=datetime.utcnow)
    updated_on = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    category_id = Column(String)

# Configure your PostgreSQL connection
DB_URL = "postgresql://admin:root@localhost:5442/product"
engine = create_engine(DB_URL)

# Create a session to interact with the database
Session = sessionmaker(bind=engine)
session = Session()

# Read JSON file and insert data into the database
json_file_path = "../data/output.json"

print("START")
with open(json_file_path, 'r') as file:
    data = json.load(file)

    for category_id, products_list in data.items():
        for product_data in products_list:
            product_name, product_info = product_data.popitem()

            if 'Kod producenta' not in product_info['Specification']:
                # Key doesn't exist, go to the next iteration or handle it as needed
                continue
            sku = product_info['Specification']['Kod producenta']
            description = product_info['Description'] if product_info['Description'] else "Some description"
            price = product_info['Price']
            product = Product(
                sku=sku,
                name=product_name,
                specification=json.dumps(product_info['Specification']),
                description=description,
                quantity=100,
                price=price,
                image_url=product_info['ImageUrl'],
                category_id=category_id
            )

            session.add(product)

# Commit changes and close the session
session.commit()
session.close()
