from fastapi import Depends, FastAPI, HTTPException
from sqlalchemy.orm import Session

from prometheus_fastapi_instrumentator import Instrumentator

from . import models, schemas
from .database import Base, engine, get_db

Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Secure Cloud-Native Product API",
    description="Product API for the DevSecOps project",
    version="1.0.0"
)
@app.on_event("startup")
def startup_event():
    Base.metadata.create_all(bind=engine)


Instrumentator().instrument(app).expose(app)


@app.get("/")
def root():
    return {
        "message": "Secure Cloud-Native Product API",
        "version": "1.0.0"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }


@app.get("/products", response_model=list[schemas.ProductResponse])
def get_products(db: Session = Depends(get_db)):
    return db.query(models.Product).all()


@app.post("/products", response_model=schemas.ProductResponse)
def create_product(
    product: schemas.ProductCreate,
    db: Session = Depends(get_db)
):
    new_product = models.Product(
        name=product.name,
        description=product.description,
        price=product.price,
        quantity=product.quantity
    )

    db.add(new_product)
    db.commit()
    db.refresh(new_product)

    return new_product


@app.get("/products/{product_id}", response_model=schemas.ProductResponse)
def get_product(
    product_id: int,
    db: Session = Depends(get_db)
):
    product = (
        db.query(models.Product)
        .filter(models.Product.id == product_id)
        .first()
    )

    if product is None:
        raise HTTPException(
            status_code=404,
            detail="Product not found"
        )

    return product